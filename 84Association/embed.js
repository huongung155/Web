var mongoose = require("mongoose");
mongoose.connect("mongodb://localhost/blog_demo");

var postSchema = new mongoose.Schema({
    title: String,
    content: String
});

var Post = mongoose.model("Post", postSchema);

var userSchema = new mongoose.Schema({
    email: String,
    name: String,
    posts: [postSchema]
}, {
    usePushEach: true
});

var User = mongoose.model("User", userSchema);

/*var newUser = new User({
    email: "charlie@brown.edu",
    name: "Charlie Brown"
});*/


/*var newPost = new Post({
    title: "Reflections on Apples",
    content: "They are delicious"
});

newPost.save(function(err, post){
    if(err){
        console.log(err);
    }else{
        console.log(post);
    }
});*/

/*var newUser = new User({
    email: "hermione@hogwarts.edu",
    name: "Hermione Granger"
});

newUser.posts.push({
    title: "How to bre polyjuice potion",
    content: "Just kidding. Go to potion class"
});

newUser.save(function(err, user){
    if(err){
        console.log(err);
    }else{
        console.log(user);
    }
});*/

User.findOne({name: "Hermione Granger"}, function(err, user){
    if(err){
        console.log(err);
    }else{
        user.posts.push({
            title: "3 things I really hate",
            content: "Voldemort. Voldemort. Voldemort"
        });
        user.save(function(err, user){
            if(err){
                console.log(err);
            }else{
                console.log(user);
            }
        });
    }
});