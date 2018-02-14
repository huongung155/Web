var express = require('express');
var app = express();

app.get("/", function(req, res){
    res.send("Hi there, welcome to my assignment!") ;
});

app.get("/speak/:animal", function(req, res){
    var animal = req.params.animal;
    var sounds = {
        pig: "Oink",
        cow: "Moo",
        dog: "Woof Woof!",
        cat: "Hate you",
    }
    var sound = sounds[animal];
    res.send("The " + animal + " says '" + sound + "'");
});

app.get("/repeat/:message/:times", function(req, res){
    var times = Number(req.params.times);
    var message = req.params.message;

    var result = "";
    for(var i = 0; i < times; i++){
        result += (message + " ")
    }
    res.send(result);
});

app.get("*", function(req, res) {
    res.send("Sorry, page not found...What are you doing with your life?");
});

module.exports = app;