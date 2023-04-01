import pytest
from fastapi.testclient import TestClient

from fastapi_k8s_app.app import app


@pytest.fixture
def client():
    client = TestClient(app)
    yield client
