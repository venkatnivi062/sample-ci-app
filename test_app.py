#from app import app
 
#def test_home():
    #client = app.test_client()
    #response = client.get('/')
    #assert response.data == b"Hello, CI/CD World!"

from app import create_app

def test_home_page():
    app = create_app()
    client = app.test_client()

    response = client.get("/")
    assert response.status_code == 200

