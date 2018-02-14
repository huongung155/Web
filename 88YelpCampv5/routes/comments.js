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
        }else{
            Comment.create(req.body.comment, function(err, comment){
                if(err){
                    console.log(err);
                }else{
                    campground.comments.push(comment);
                    campground.save();
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