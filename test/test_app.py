from app.app import app


def test_index_endpoint():
    client = app.test_client()
    response = client.get("/")
    assert response.status_code == 200


def test_healthcheck_endpoint():
    client = app.test_client()
    response = client.get("/health")
    assert response.status_code == 200
