var express = require("express"),
    mongoose = require("mongoose"),
    bodyParser = require("body-parser"),
    methodOverride = require("method-override"),
    expressSanitizer = require("express-sanitizer"),
    app = express();

mongoose.connect("mongodb://localhost/test");
app.set("view engine", "ejs");
app.use(express.static("public"));
app.use(bodyParser.urlencoded({extended: true}));
app.use(expressSanitizer());
app.use(methodOverride("_method"));

var blogSchema = new mongoose.Schema({
    title: String,
    image: String,
    body: String,
    created: {type: Date, default: Date.now}
});

var Blog = mongoose.model("Blog", blogSchema);

/*Blog.create({
    title: "Test Blog",
    image: "https://images.unsplash.com/photo-1484882918957-e9f6567be3c8?auto=format&fit=crop&w=400&q=60&ixid=dW5zcGxhc2guY29tOzs7Ozs%3D",
    body: "Hello this is a blog post 2"
});*/

app.get("/", function(req, res){
    res.redirect("/blogs");
});

//INDEX Route
app.get("/blogs", function(req, res){
    Blog.find({}, function(err, allBlogs){
        if(err){
            console.log(err);
        }else{
            res.render("index", {blogs: allBlogs});
        }
    });
});

//NEW Route
app.get("/blogs/new", function(req, res) {
    res.render("new");
});

//CREATE Route
app.post("/blogs", function(req, res){
    var newBlog = req.body.blog;
    newBlog.body = req.sanitizer(newBlog.body);
    Blog.create(newBlog, function(err, blog){
        if(err){
            res.redirect("/blogs/new");
        }else{
            res.redirect("/blogs");
        }
    });
});

//SHOW Route
app.get("/blogs/:id", function(req, res) {
    Blog.findById(req.params.id, function(err, foundBlog){
        if(err){
            res.redirect("/blogs");
        }else{
            res.render("show", {blog: foundBlog});
        }
    });
});

//EDIT Route
app.get("/blogs/:id/edit", function(req, res) {
    Blog.findById(req.params.id, function(err, foundBlog){
        if(err){
            res.redirect("/blogs");
        }else{
            res.render("edit", {blog: foundBlog});
        }
    });
});

//UPDATE Route
app.put("/blogs/:id", function(req, res){
    req.body.blog.body = req.sanitizer(req.body.blog.body);
    Blog.findByIdAndUpdate(req.params.id, req.body.blog, function(err, updatedBlog){
        if(err){
            res.redirect("/blogs");
        }else{
            res.redirect("/blogs/" + updatedBlog._id);
        }
    });
});

//DELETE Route
app.delete("/blogs/:id", function(req, res){
    Blog.findByIdAndRemove(req.params.id, function(err){
        if(err){
            res.redirect("/blogs");
        }else{
            res.redirect("/blogs");
        }
    });
});

module.exports = app;
