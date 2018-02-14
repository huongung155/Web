var Comment = require('../models/comment'),
    Campground = require('../models/campground');
var middlewareObj = {
    isLoggedIn: function(req, res, next){
        if(req.isAuthenticated()){
            next();
        }else {
            req.flash('error', 'Please Login First');//Good point of flash is that it won't show right away, instead it just shows after redirect login
            res.redirect('/login');
        }
    },
    checkCampgroundOwnership: function(req, res, next){
        Campground.findById(req.params.id, function(err, foundCampground){
            if(err || !foundCampground){
                console.log(err);
                req.flash('error', 'Campground not found');
                res.redirect('/campgrounds');
            } else if(foundCampground.author.id.equals(req.user._id) || req.user.isAdmin){
                req.campground = foundCampground;
                next();
            } else {
                req.flash('error', 'You don\'t have permission to do that!');
                res.redirect('/campgrounds/' + req.params.id);
            }
        });
    },
    checkCommentOwnership: function(req, res, next){
        Comment.findById(req.params.commentId, function(err, foundComment){
            if(err || !foundComment){
                console.log(err);
                req.flash('error', 'Comment not found');
                res.redirect('/campgrounds');
            } else if(foundComment.author.id.equals(req.user._id) || req.user.isAdmin){
                req.comment = foundComment;
                next();
            } else {
                req.flash('error', 'You don\'t have permission to do that!');
                res.redirect('/campgrounds/' + req.params.id);
            }
        });
    },
    isAdmin: function(req, res, next) {
        if(req.user.isAdmin) {
            next();
        } else {
            req.flash('error', 'This site is only for admin');
            res.redirect('back');
        }
    },
    isSafe: function(req, res, next) {
        if(req.body.image.match(/^https:\/\/images\.unsplash\.com\/.*/)) {
            next();
        }else {
            req.flash('error', 'Only images from images.unsplash.com allowed.\nSee https://youtu.be/Bn3weNRQRDE for how to copy image urls from unsplash.');
            res.redirect('back');
        }
    }
};

/*middlewareObj.checkCampgroundOwnership = function () {

};

middlewareObj.checkCommentOwnership = function () {

};*/

module.exports = middlewareObj;