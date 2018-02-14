var express = require('express');
var app = express();

app.get("/", function(req, res){
    res.send("Hi there!");
});

app.get("/r/:subName", function(req, res) {
    res.send("WELCOME TO SUBWEB!");
});

app.get("/r/:subName/comments/:id/:title", function(req, res) {
    console.log(req.params);
    var subName = req.params.subName;
    res.send("WELCOME TO THE " + subName.toUpperCase());
});

app.get("/bye", function(req, res){
    res.send("Goodbye!");
});

app.get("/dog", function(req, res){
    console.log("SOMEONE access to /dog");// print on console of c9
    res.send("Meow!");//print on browser
});

app.get("*", function(req, res) {
    res.send("YOU ARE A STAR");
});

module.exports = app;