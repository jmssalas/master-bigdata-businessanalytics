// Find all documents
db.University.Students.find()

// Find all elements with a value
db.University.Students.find({"name": "Juan"})

// Find all elements with a some
db.University.Students.find({"age": 17, "name": "Isabel"})


// Find all elements showing not all values
db.University.Students.find({}, {"age": 1, "name": 1})
db.University.Students.find({}, {"age": 1, "name": 1, "_id": 0})


// Using $lt, $lte, $gt and $gte
db.University.Students.find({"age": {"$gte": 16, "$lt": 21}}, {"age":1, "name":1})


// Using $ne
db.University.Students.find({"name": {"$ne": "Isabel"}}, {"age":1, "name":1, "_id": 0})


// Using $in
db.University.Students.find({"age": {"$in": [22,31]}, {"age":1, "name":1, "_id": 0})


// Using $or
db.University.Students.findOne({"$or": [{"age": 17}, {"name": "Daniel"}]}, {"age":1, "name":1, "_id": 0})




// Using null value to find elements which have not a key with value
db.University.Students.findOne({"credits": null})

// Using null value to find elements which have a key without value
db.University.Students.findOne({"credits": {"$in":[null], "$exists": true}})
db.University.Students.update({"name": "Daniel"}, {"$set": {"credits": null}})
db.University.Students.findOne({"credits": {"$in":[null], "$exists": true}})




// Regular Expresions
db.University.Students.findOne({"name": /juan/})
db.University.Students.findOne({"name": /I?/i})



// Using $size
db.University.Students.findOne({"sports": {"$size": 1}})
db.University.Students.findOne({"sports": {"$size": 2}})


// Using $slice
db.University.Students.findOne({}, {"electives": {"$slice": 1}})
db.University.Students.findOne({}, {"electives": {"$slice": -1}})