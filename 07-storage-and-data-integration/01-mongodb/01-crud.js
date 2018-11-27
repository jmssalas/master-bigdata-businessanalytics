// Insert one
db.University.Students.insert({"Name":"Rafael", "Age":20 })
// Insert some
var some = [{"Name":"Isabel", "Age":20}, {"Name":"Maria", "Age":21}]
db.University.Students.insert(some)



// Remove one
db.University.Students.remove({"Name":"Rafael"})
// Remove all
db.University.Students.remove({})
// Remove all documents
db.University.Students.drop()



// Update
var juan = {
	"name": "Juan", 
	"age": 31,
	"electives": ["Bases de datos NoSQL","Aplicaciones Web"],
	"compulsory": ["Compiladores", "Autómatas"]
}
db.University.Students.insert(juan)

// Insert new student
db.University.Students.insert({"name": "Isabel", "age": 20})
var isabel = db.University.Students.findOne({"name": "Isabel"})

// Set Isabel's electives 
isabel.electives = juan.electives

// Update Isabel's document
db.University.Students.update({"name": "Isabel"}, isabel)
db.University.Students.findOne({"name": "Isabel"})


// Update using $inc
db.University.Students.update({"name": "Isabel"}, {"$inc": {"age": 1}})
db.University.Students.findOne({"name": "Isabel"})

db.University.Students.update({"name": "Isabel"}, {"$inc": {"age": -4}})
db.University.Students.findOne({"name": "Isabel"})

db.University.Students.update({"name": "Isabel"}, {"$inc": {"credits": 44}})
db.University.Students.findOne({"name": "Isabel"})



// Update usign $set and $unset
db.University.Students.update({"name": "Isabel"}, {"$set": {"turn": "evening"}})
db.University.Students.findOne({"name": "Isabel"})

db.University.Students.update({"name": "Isabel"}, {"$set": {"turn": "morning"}})
db.University.Students.findOne({"name": "Isabel"})

db.University.Students.update({"name": "Isabel"}, {"$set": {"turn": ["evening", "morning"]}})
db.University.Students.findOne({"name": "Isabel"})



var daniel = {
	"name": "Daniel", 
	"age": 22,
	"subjects": {
		"electives": ["Bases de datos NoSQL", "Aplicaciones Web"],
		"compulsory": ["Compiladores", "Autómatas"]
	},
	"sports" : [
		"karate"
	]
}

db.University.Students.insert(daniel)
db.University.Students.findOne({"name": "Daniel"})
db.University.Students.update({"name": "Daniel"}, {"$set": {"subjects.electives": [
																"Bases de Datos NoSQL", 
																"Procesadores de lenguaje"
																]}
															})
db.University.Students.findOne({"name": "Daniel"})


db.University.Students.update({"name": "Isabel"}, {"$unset": {"turn": 1}})
db.University.Students.findOne({"name": "Isabel"})




// Update arrays with $push
db.University.Students.update({"name": "Isabel"}, 
	{"$push": {"califications": {
		"Bases de Datos": 4, "Programacion I":6
	}}})
db.University.Students.findOne({"name": "Isabel"})


db.University.Students.update({"name": "Isabel"}, 
	{"$push": {"califications": {
		"Compiladores": 3, "Logica":7
	}}})
db.University.Students.findOne({"name": "Isabel"})


// $push with $each
db.University.Students.update({"name": "Isabel"}, 
	{"$push": {"sports": {"$each": [
		"swimming", "fencing"
	]}}})
db.University.Students.findOne({"name": "Isabel"})




// $push with $sort
db.University.Students.update({"name": "Isabel"}, 
	{"$push": {"championships": {"$each": [
			{"sport": "swimming", "score": 4},
			{"sport": "fencing", "score": 6},
			{"sport": "tennis", "score": 9}
		],
	"$sort": {"score":-1}
}}})

db.University.Students.findOne({"name": "Isabel"})



// Arrays like sets
db.University.Students.update({"name": "Daniel"}, {"$addToSet": {"compulsory": "Calculo"}})
db.University.Students.findOne({"name": "Daniel"})


db.University.Students.update({"name": "Daniel"}, {"$addToSet": {"compulsory": {"$each": ["Calculo", "Algebra", "Compiladores"]}}})
db.University.Students.findOne({"name": "Daniel"})




// Remove elements with $pop

// Like stack
db.University.Students.update({"name": "Daniel"}, {"$pop": {"compulsory": 1}})
db.University.Students.findOne({"name": "Daniel"})


// Like queue
db.University.Students.update({"name": "Daniel"}, {"$pop": {"compulsory": -1}})
db.University.Students.findOne({"name": "Daniel"})




db.University.Students.update({"name": "Daniel"}, {"$addToSet": {"compulsory": {"$each": ["Calculo", "Algebra", "Compiladores"]}}})
db.University.Students.findOne({"name": "Daniel"})


// Remove elements with $pull
db.University.Students.update({"name": "Daniel"}, {"$pull": {"compulsory": "Algebra"}})
db.University.Students.findOne({"name": "Daniel"})
