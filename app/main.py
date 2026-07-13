import json
import logging
import os
import time
import uuid
from collections.abc import Callable

import psycopg
from flask import Flask, Response, g, jsonify, request
from prometheus_client import CONTENT_TYPE_LATEST, Counter, Histogram, generate_latest

REQUESTS = Counter(
    "http_requests_total",
    "Количество HTTP-запросов",
    ("method", "path", "status"),
)
LATENCY = Histogram(
    "http_request_duration_seconds",
    "Длительность HTTP-запросов",
    ("method", "path"),
)


class JsonFormatter(logging.Formatter):
    def format(self, record: logging.LogRecord) -> str:
        return json.dumps(
            {
                "timestamp": self.formatTime(record, "%Y-%m-%dT%H:%M:%S%z"),
                "level": record.levelname,
                "logger": record.name,
                "message": record.getMessage(),
            },
            ensure_ascii=False,
        )


def configure_logging() -> None:
    root = logging.getLogger()
    root.setLevel(os.getenv("LOG_LEVEL", "INFO"))
    if not root.handlers:
        root.addHandler(logging.StreamHandler())
    for handler in root.handlers:
        handler.setFormatter(JsonFormatter())


def database_ready(connect: Callable[..., object] = psycopg.connect) -> bool:
    try:
        with connect(os.environ["DATABASE_URL"], connect_timeout=2) as connection:
            with connection.cursor() as cursor:
                cursor.execute("SELECT 1")
                return cursor.fetchone() == (1,)
    except (KeyError, psycopg.Error):
        return False


def create_app(readiness_check: Callable[[], bool] = database_ready) -> Flask:
    app = Flask(__name__)
    configure_logging()

    @app.before_request
    def start_request() -> None:
        g.started_at = time.monotonic()
        g.request_id = request.headers.get("X-Request-ID", str(uuid.uuid4()))

    @app.after_request
    def observe(response: Response) -> Response:
        path = request.url_rule.rule if request.url_rule else "unmatched"
        duration = time.monotonic() - g.started_at
        REQUESTS.labels(request.method, path, response.status_code).inc()
        LATENCY.labels(request.method, path).observe(duration)
        response.headers["X-Request-ID"] = g.request_id
        app.logger.info(
            "request_complete method=%s path=%s status=%s duration=%.4f request_id=%s",
            request.method,
            request.path,
            response.status_code,
            duration,
            g.request_id,
        )
        return response

    @app.get("/")
    def index() -> Response:
        return jsonify(service="devops-api", version=os.getenv("APP_VERSION", "dev"))

    @app.get("/health")
    def health() -> Response:
        return jsonify(status="ok")

    @app.get("/ready")
    def ready() -> tuple[Response, int] | Response:
        if readiness_check():
            return jsonify(status="ready")
        return jsonify(status="not_ready"), 503

    @app.get("/metrics")
    def metrics() -> Response:
        return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)

    return app


app = create_app()
