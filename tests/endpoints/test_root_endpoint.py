import re

from freezegun import freeze_time


def test_root_endpoint__request__returns_timestamp(client):
    response = client.get("/")
    assert response.status_code == 200
    assert "timestamp" in response.json()


@freeze_time("1985-09-19 00:00:00")
def test_root_endpoint__request__returns_timestamp_contains_actual_timestamp(client):
    response = client.get("/")
    assert response.status_code == 200
    assert response.json()["timestamp"] == 495936000.0


def test_root_endpoint__request__returns_hostname(client):
    response = client.get("/")
    assert response.status_code == 200
    assert "hostname" in response.json()


def test_root_endpoint__request__returns_hostname_alphanumeric(client):
    response = client.get("/")
    assert response.status_code == 200
    assert is_valid_hostname(response.json()["hostname"])


def is_valid_hostname(hostname):
    if len(hostname) > 255:
        return False
    if hostname[-1] == ".":
        hostname = hostname[:-1]
    allowed = re.compile("(?!-)[A-Z\\d-]{1,63}(?<!-)$", re.IGNORECASE)
    return all(allowed.match(x) for x in hostname.split("."))
