#!/usr/bin/env python3
import argparse
import json
import logging
import sys
import urllib.error
import urllib.request


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Проверка HTTP endpoint")
    parser.add_argument("--url", required=True)
    parser.add_argument("--timeout", type=float, default=3.0)
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    logging.basicConfig(level=logging.INFO, format="%(levelname)s %(message)s")
    try:
        with urllib.request.urlopen(args.url, timeout=args.timeout) as response:
            result = {"url": args.url, "status": response.status, "ok": True}
            print(json.dumps(result, ensure_ascii=False))
            return 0
    except urllib.error.HTTPError as error:
        result = {"url": args.url, "status": error.code, "ok": False}
        print(json.dumps(result, ensure_ascii=False))
        return 1
    except (urllib.error.URLError, TimeoutError, ValueError) as error:
        logging.error("healthcheck failed: %s", error)
        return 2


if __name__ == "__main__":
    sys.exit(main())
