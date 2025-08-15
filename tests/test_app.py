from src.app import app

def test_root():
    client = app.test_client()
    r = client.get('/')
    assert r.status_code == 200
    assert "AKS" in r.get_data(as_text=True)
