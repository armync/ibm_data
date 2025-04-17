from pymongo import MongoClient
user = 'root'
password = 'cAcBS2HJGJNqAAD0sRgk0QoI'
host='mongo'

connecturl = "mongodb://{}:{}@{}:27017/?authSource=admin".format(user,password,host)

print("Connecting to mongodb server")
connection = MongoClient(connecturl)

db = connection.training

collection = db.mongodb_glossary

doc_all = [
    {"database": "a database contains collections"},
    {"collection": "a collection stores the documents"},
    {"document": "a document contains the data in the form of key value pairs"}
]

print("Inserting a document into collection.")
db.collection.insert_many(doc_all)

print("Printing the documents in the collection.")
docs = db.collection.find()

for documents in docs:
    print(documents)

print("Closing the connection.")
connection.close()