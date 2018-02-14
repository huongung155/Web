var express = require('express'),
    router = express.Router({mergeParams: true}),/*merge id in app.use('/campgrounds/:id/comments', commentRoutes) in app.js*/
    Campground = require('../models/campground'),
    Comment = require('../models/comment');

//==============================================
//Comments route
//==============================================
router.get('/new', isLoggedin, function(req, res) {
    Campground.findById(req.params.id, function(err, foundCampground){
        if(err){
            console.log(err);
        }else{
            res.render('comments/new', {campground: foundCampground});
        }
    });
});

router.post('/', isLoggedin, function(req, res){
    Campground.findById(req.params.id, function(err, campground) {
        if(err){
            console.log(err);
            res.redirect('/campgrounds');
        }else{
            Comment.create(req.body.comment, function(err, comment){
                if(err){
                    console.log(err);
                }else{
                    //add username and id to comment
                    comment.author.id = req.user._id;
                    comment.author.username = req.user.username;
                    //save comment
                    comment.save(function (err, data) {
                        if(err){
                            console.log(err);
                        }else{
                            console.log(data);
                        }
                    });
                    campground.comments.push(comment);
                    campground.save(function (err, data) {
                        if(err){
                            console.log(err);
                        }else{
                            console.log(data);
                        }
                    });
                    res.redirect('/campgrounds/' + req.params.id);
                }
            });
        }
    });
});

function isLoggedin(req, res, next){
    if(req.isAuthenticated()){
        return next();
    }
    res.redirect('/login');
}

module.exports = router;