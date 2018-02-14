var express = require('express');
var app = express();

app.use(express.static("public"));/*tell express to serve the content of CSS in the public directory*/
app.set("view engine", "ejs");/*Instead of writing res.render(home.ejs), we write res.render(home)*/

app.get("/", function(req, res){
    res.render("home");
});

app.get("/fallinlovewith/:thing", function(req, res){
    var thing = req.params.thing;
    res.render("love", {thingVar: thing});
});

app.get("/posts", function(req, res) {
    var posts = [
        {title: "Post 1", author: "Susy"},
        {title: "My adorable pet bunny", author: "Charlie"},
        {title: "Can you believe this pomsky", author: "Colt"}
    ];
    res.render("posts", {posts: posts});
});

module.exports = app;