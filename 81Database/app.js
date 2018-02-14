var mongoose = require("mongoose");
mongoose.connect("mongodb://localhost/cat_app");

var catSchema = new mongoose.Schema({
    name:String,
    age: Number,
    temperament: String
});

var Cat = mongoose.model("Cat", catSchema);
/*From now on, instead of db.cats.find() and we can write Cat.find()*/

/*var george = new Cat({
 name: "George",
 age: 11,
 temperament: "Grouchy"
 });

 george.save(function(err, cat){
 if(err){
 console.log("SOMETHING WENT WRONG");
 }else{
 console.log("WE JUST SAVED A CAT TO DB:");
 console.log(cat);
 }
 });*/

/*Instead of declare george and save it, we can easily use CREATE*/

Cat.create({
    name: "Snow White",
    age: 15,
    temperament: "Bland"
}, function(err, cat){
    if(err){
        console.log(err);
    }else{
        console.log(cat);
    }
});

Cat.find({}, function(err, cats){
    if(err){
        console.log("ERROR");
        console.log(err);
    }else{
        console.log("ALL THE CATS...");
        console.log(cats);
    }
});