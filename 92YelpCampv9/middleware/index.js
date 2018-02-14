var Campground = require('../models/campground'),
    Comment = require('../models/comment');

//all the middleware goes here
var middlewareObj = {
    checkCampgroundOwnership: function (req, res, next) {
        if(req.isAuthenticated()){
            Campground.findById(req.params.id, function (err,foundCampground) {
                if(err){
                    console.log(err);
                    req.flash('error', 'Campground not found')
                    res.redirect('back');
                }else{
                    //does user own the campground?
                    if(foundCampground && foundCampground.author.id.equals(req.user._id)) {
                        next();
                    }else{
                        req.flash('error', 'You are not allowed to do it')
                        res.redirect('back');
                    }
                }
            });
        }else{
            req.flash('error', 'Please Login First');
            res.redirect('back');
        }
    },
    checkCommentOwnership: function (req, res, next) {
        if(req.isAuthenticated()){
            Comment.findById(req.params.comment_id, function (err,foundComment) {
                if(err){
                    console.log(err);
                    res.redirect('back');
                }else{
                    //does user own the comment?
                    if(foundComment.author.id.equals(req.user._id)) {
                        next();
                    }else{
                        req.flash('error', 'You are not allowed to do it')
                        res.redirect('back');
                    }
                }
            });
        }else{
            res.redirect('back');
        }
    },
    isLoggedin: function (req, res, next) {
        if(req.isAuthenticated()){
            return next();
        }
        req.flash('error', 'Please Login First');//Good point of flash is that it won't show right away, instead it just shows after redirect login
        res.redirect('/login');
    }
};

/*middlewareObj.checkCampgroundOwnership = function () {
    
};

middlewareObj.checkCommentOwnership = function () {
    
};*/

module.exports = middlewareObj;