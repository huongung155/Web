var express = require("express"),
    app = express(),
    bodyParser = require("body-parser"),
    mongoose = require("mongoose"),
    Campground = require('./models/campground'),
    Comment = require('./models/comments'),
    seedDB = require('./seeds');


mongoose.connect("mongodb://localhost/test");

app.use(bodyParser.urlencoded({extended: true}));
app.set("view engine", "ejs");
seedDB();

/*Create before description is added
Campground.create({
    name: "Granite Hill",
    image: "http://photosforclass.com/download/31733208"
}, function(err, campground){
    if(err){
        console.log(err);
    }else{
        console.log("NEW CAMPGROUND: ");
        console.log(campground);
    }
});

Campground.create({
    name: "Granite Hill",
    image: "http://photosforclass.com/download/31733208",
    description: "This is a huge granite hill, no bathrooms. No water. Beautiful granite"
}, function(err, campground){
    if(err){
        console.log(err);
    }else{
        console.log("NEW CAMPGROUND: ");
        console.log(campground);
    }
});

var campgrounds = [
            {name: "Salmon Greek", image: "http://photosforclass.com/download/10759552364"},
            {name: "Granite Hill", image: "http://photosforclass.com/download/31733208"},
            {name: "Mountain Goat's Rest", image: "http://photosforclass.com/download/7930463550"},
            {name: "Salmon Greek", image: "http://photosforclass.com/download/10759552364"},
            {name: "Granite Hill", image: "http://photosforclass.com/download/31733208"},
            {name: "Mountain Goat's Rest", image: "http://photosforclass.com/download/7930463550"},
            {name: "Salmon Greek", image: "http://photosforclass.com/download/10759552364"},
            {name: "Granite Hill", image: "http://photosforclass.com/download/31733208"},
            {name: "Mountain Goat's Rest", image: "http://photosforclass.com/download/7930463550"}
        ];*/

app.get("/", function(req, res){
    // res.send("The lading page will show soon");
    res.render("landing");
});

//INDEX - DIsplay a list of all campground
app.get("/campgrounds", function(req, res){
    //Get all campgrounds from DB
    Campground.find({}, function(err, allCampgrounds){
        if(err){
            console.log(err);
        }else{
            res.render("campgrounds/index", {campgrounds: allCampgrounds});
        }
    });

});

//CREATE - Add new campground to DB
app.post("/campgrounds", function(req, res){
    //get data from form and add to campgrounds array
    var name = req.body.name;
    var image = req.body.image;
    var desc = req.body.description;
    var newCampground = {name: name, image: image, description: desc};
    //Create a new campground and save to DB
    Campground.create(newCampground, function(err, newlyCreated){
        if(err){
            console.log(err);
        }else{
            //redirect back to campgound page
            res.redirect("/campgrounds");
        }
    });

});

//NEW - Display a form to make a new campground
app.get("/campgrounds/new", function(req, res) {
    res.render("campgrounds/new");
});

//SHOW - Shows info about one campground
app.get("/campgrounds/:id", function(req, res) {
    //Find the campground with provided ID
    Campground.findById(req.params.id).populate("comments").exec(function(err, foundCampground){
        if(err){
            console.log(err);
        }else{
            res.render("campgrounds/show", {campground: foundCampground});
        }
    });
});

//==============================================
//Comments route
//==============================================
app.get("/campgrounds/:id/comments/new", function(req, res) {
    Campground.findById(req.params.id, function(err, foundCampground){
        if(err){
            console.log(err);
        }else{
            res.render("comments/new", {campground: foundCampground});
        }
    });
});

app.post("/campgrounds/:id/comments", function(req, res){
    Campground.findById(req.params.id, function(err, campground) {
        if(err){
            console.log(err);
        }else{
            Comment.create(req.body.comment, function(err, comment){
                if(err){
                    console.log(err);
                }else{
                    campground.comments.push(comment);
                    campground.save();
                    res.redirect("/campgrounds/" + req.params.id);
                }
            });
        }
    });
});

module.exports = app;