var express = require('express');
var app = express();
var bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({extended: true}));
app.set('view engine', 'ejs');

var friends = ["Tony", "Miranda", "Justin", "Pierre", "Lilly"];

app.get("/", function(req, res){
    res.render("home");
});

app.post("/addFriend", function(req, res){
    var friend = req.body.newfriend;//need to install body-parser
    friends.push(friend);
    res.redirect("/friends");
});

app.get("/friends", function(req, res){

    res.render("friends", {friends: friends});
});

module.exports = app;