var express = require('express'),
    router = express.Router({mergeParams: true}),/*merge id in app.use('/campgrounds/:id/comments', commentRoutes) in app.js*/
    Campground = require('../models/campground'),
    Comment = require('../models/comment'),
    middleware = require('../middleware');//it will automatically go to middleware/index.js


//==============================================
//Comments route
//==============================================
router.get('/new', middleware.isLoggedin, function(req, res) {
    Campground.findById(req.params.id, function(err, foundCampground){
        if(err){
            console.log(err);
        }else{
            res.render('comments/new', {campground: foundCampground});
        }
    });
});

router.post('/', middleware.isLoggedin, function(req, res){
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
                    req.flash('success', 'Comment is added');
                    res.redirect('/campgrounds/' + req.params.id);
                }
            });
        }
    });
});

//Edit Comment Route
router.get('/:comment_id/edit', middleware.checkCommentOwnership, function (req, res) {
    Comment.findById(req.params.comment_id, function (err, foundComment) {
            res.render('comments/edit', {campground_id: req.params.id, comment: foundComment});
    });
});

//Update Comment Route
router.put('/:comment_id', middleware.checkCommentOwnership, function (req, res) {
    Comment.findByIdAndUpdate(req.params.comment_id, req.body.comment, function (err, comment) {
            res.redirect('/campgrounds/' + req.params.id);
    });
});

//Delete Comment
router.delete('/:comment_id', middleware.checkCommentOwnership, function (req, res) {
    Comment.findByIdAndRemove(req.params.comment_id, function (err) {
        req.flash('success', 'Comment deleted');
        res.redirect('/campgrounds/' + req.params.id);
    })
});

module.exports = router;