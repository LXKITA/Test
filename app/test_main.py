from app.main import create_app


def test_health() -> None:
    client = create_app().test_client()

    response = client.get("/health")

    assert response.status_code == 200
    assert response.json == {"status": "ok"}
    assert response.headers["X-Request-ID"]


def test_ready_when_database_is_available() -> None:
    client = create_app(lambda: True).test_client()

    response = client.get("/ready")

    assert response.status_code == 200
    assert response.json == {"status": "ready"}


def test_not_ready_when_database_is_unavailable() -> None:
    client = create_app(lambda: False).test_client()

    response = client.get("/ready")

    assert response.status_code == 503
    assert response.json == {"status": "not_ready"}


def test_metrics() -> None:
    client = create_app().test_client()

    client.get("/health")
    response = client.get("/metrics")

    assert response.status_code == 200
    assert b"http_requests_total" in response.data
