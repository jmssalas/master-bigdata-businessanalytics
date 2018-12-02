// Create Library database
use Library
db.Books.drop()

// Insert Books collection
var books = [
	{
		"type": "book",
		"title": "Python para todos",
		"ISBN": "987-1-2344-5334-8",
		"editorial": "Prentince Hall",
		"author": [
			"Isabel Carrasco",
			"Carlos Sanz",
			"Santiago Merino"
		],
		"chapters": [
			{
				"chapter": 1,
				"title": "Primeros pasos en Python",
				"long": 20
			},
			{
				"chapter": 2,
				"title": "El entorno Jupyter Notebook",
				"long": 25
			}
		]
	},
	{
		"type": "ebook",
		"title": "Historia de Alemania",
		"ISBN": "988-1-3444-6789-9",
		"editorial": "Alianza Editorial",
		"author": [
			"Walter House",
			"Bryan Reagan"
		],
		"chapters": [
			{
				"chapter": 1,
				"title": "Prehistoria alemana",
				"long": 40
			},
			{
				"chapter": 2,
				"title": "La edad media alemana",
				"long": 25
			}
		]
	},
	{
		"type": "book",
		"title": "El símbolo perdido",
		"ISBN": "5678-18-6784-53433-45",
		"editorial": "Planeta",
		"author": [
			"Dan Brown"
		],
		"chapters": [
			{
				"chapter": 1,
				"title": null,
				"long": 20
			},
			{
				"chapter": 2,
				"title": null,
				"long": 25
			}
		]
	}
]

db.Books.insert(books)
db.Books.find({}, {"title":1, "_id": 0})


// Add to authors of "Python para todos" the author "Felix Sanchez"
db.Books.update({"title": "Python para todos"}, {"$addToSet": {"author": "Felix Sánchez"}})


// Get all documents with all fields except the fields: editorial, isbn, id and chapter
db.Books.find({}, {"type":1, "title":1, "author":1, "_id":0})


// Set a 'read' new field 
db.Books.update({}, {"$set": {"read": 0}}, {multi: true})
db.Books.find({}, {"title":1, "read":1, "_id":0})


// Add 3 to "Historia de Alemania"'s read field
db.Books.update({"title": "Historia de Alemania"}, {"$inc": {"read": 3}})
db.Books.find({"title": "Historia de Alemania"}, {"title":1, "read":1, "_id":0})


// Remove 'editorial' field from "El simbolo perdido" book
db.Books.update({"title": "El símbolo perdido"}, {"$unset": {"editorial": 1}})
db.Books.find({"title": "El símbolo perdido"}, {"title":1, "editorial":1, "_id":0})


// Add 'editorials' array to "El simbolo perdido"
db.Books.update({"title": "El símbolo perdido"}, {"$set": {"editorials": []}})
db.Books.find({"title": "El símbolo perdido"}, {"title":1, "editorials":1, "_id":0})


// Add a new document to 'chapters' of "Historia de Alemania"
db.Books.update({"title": "Historia de Alemania"}, {"$push": {"chapters": {
	"chapter": 3,
	"title": "La unificacion alemana",
	"long": 45
}}})
db.Books.find({"title": "Historia de Alemania"}, {"title":1, "chapters":1, "_id":0})


// Add "Isabel Carrasco" and "Victor Peña" as "Python para todos" authors like a set
db.Books.update({"title": "Python para todos"}, {"$addToSet": {"author": {"$each": ["Isabel Carrasco", "Victor Peña"]}}})
db.Books.find({"title": "Python para todos"}, {"title":1, "author":1, "_id":0})


// Delete the first element in "author" array of "Python para todos"
db.Books.update({"title": "Python para todos"}, {"$pop": {"author": -1}})
db.Books.find({"title": "Python para todos"}, {"title":1, "author":1, "_id":0})


// Add "Dan Brown" in "author" of "Eĺ símbolo perdido" twice
db.Books.update({"title": "El símbolo perdido"}, {"$push": {"author": {"$each": ["Dan Brown", "Dan Brown"]}}})
db.Books.find({"title": "El símbolo perdido"}, {"title":1, "author":1, "_id":0})


// Remove all "Dan Brown" elements in "author" of "El símbolo perdido"
db.Books.update({"title": "El símbolo perdido"}, {"$pullAll": {"author": ["Dan Brown"]}})
db.Books.find({"title": "El símbolo perdido"}, {"title":1, "author":1, "_id":0})


// Update "long" + 4 of chapter "Prehistoria alemana"
db.Books.find({"chapters.title": "Prehistoria alemana"}, {"chapters.title":1, "chapters.long":1, "_id":0})
db.Books.update({"chapters.title": "Prehistoria alemana"}, {"$inc": {"chapters.$.long": 4}})
db.Books.find({"chapters.title": "Prehistoria alemana"}, {"chapters.title":1, "chapters.long":1, "_id":0})


// Find all book documents where its author is not Dan Brown
db.Books.find({"author": {"$nin": ["Dan Brown"]}}, {"title":1, "author":1, "_id":0})



// Find all book documents written by Walter House and Bryan Reagan,
// Also, in its chapters, "La edad media alemana" title have to stay.
db.Books.find({"$and": [
	{"author": {"$in": ["Walter House", "Bryan Reagan"]}}, 
	{"chapters.title" : "La edad media alemana"}
]}, {"title":1, "author":1, "chapters":1, "_id":0})


// Find books which have the "title" = "Historia de Alemania" or
// "type" = "book"
db.Books.find({"$or": [
	{"title": "Historia de Alemania"},
	{"type": "book"}
]}, {"title":1, "type":1, "_id":0})


// Get the "Python para todos"'s authors:
db.Books.find({"title": "Python para todos"})

// -- The 3 first
db.Books.find({"title": "Python para todos"}, {"author": {"$slice": 3}})


// -- The 3 last
db.Books.find({"title": "Python para todos"}, {"author": {"$slice": -3}})


// -- 3 authors without the 2 first
db.Books.find({"title": "Python para todos"}, {"author": {"$slice": [2,5]}})


// -- 4 authors without the 5 last
db.Books.find({"title": "Python para todos"}, {"author": {"$slice": [-5,4]}})



// Get all documents which have "long" field like "long" MOD 25 = 0
db.Books.find({"chapter.long": {"$mod": [25, 0]}})