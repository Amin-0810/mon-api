from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)


def test_health_returns_200():
    response = client.get("/health")
    assert response.status_code == 200


def test_health_returns_ok():
    response = client.get("/health")
    assert response.json() == {"status": "ok"}


def test_get_item():
    response = client.get("/items/42")
    assert response.status_code == 200
    assert response.json()["id"] == 42