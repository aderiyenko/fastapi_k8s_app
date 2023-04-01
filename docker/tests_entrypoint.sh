#!/bin/sh

black fastapi_k8s_app tests
isort .
mypy .
flake8 --max-line-length=127 .
PYTHONDONTWRITEBYTECODE=1 python -m pytest --disable-warnings --cov=fastapi_k8s_app --cov-report term-missing tests/