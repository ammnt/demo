# Demo Java (Spring Framework) application for microservice architecture

# Add book in the database:
curl -X POST http://172.17.0.3:8080/books -H "Content-Type: application/json" -d '{"author":"Joshua Bloch","title":"Effective Java","price":"54.99"}'

# Find all book by the name:
curl -X GET --location "http://172.17.0.3:8080/books?author=Bloch" -H "Accept: application/json"

# Show all books in the books:
curl -X GET --location "http://172.17.0.3:8080/books" -H "Accept: application/json"
