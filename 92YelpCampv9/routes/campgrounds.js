var express = require('express'),
    router = express.Router(),
    Campground = require('../models/campground'),
    middleware = require('../middleware');//it will automatically go to middleware/index.js

//INDEX - DIsplay a list of all campground
router.get('/', function(req, res){//should be /campground but we declare /campgrounds in app.use('/campgrounds', campgroundRoute)
    //Get all campgrounds from DB
    Campground.find({}, function(err, allCampgrounds){
        if(err){
            console.log(err);
        }else{
            res.render('campgrounds/index', {campgrounds: allCampgrounds});
        }
    });

});

//CREATE - Add new campground to DB
router.post('/', middleware.isLoggedin, function(req, res){
    //get data from form and add to campgrounds array
    var name = req.body.name;
    var price = req.body.price;
    var image = req.body.image;
    var desc = req.body.description;
    var author = {
        id: req.user._id,
        username: req.user.username
    };

    var newCampground = {name: name, price: price, image: image, description: desc, author: author};

    //Create a new campground and save to DB
    Campground.create(newCampground, function(err, newlyCreated){
        if(err){
            console.log(err);
        }else{
            newlyCreated.save(function (err, data) {
                if(err){
                    console.log(err);
                }else{
                    console.log(data);
                }
            });
            //redirect back to campgound page
            res.redirect('/campgrounds');
        }
    });

});

//NEW - Display a form to make a new campground
router.get('/new', middleware.isLoggedin, function(req, res) {
    res.render('campgrounds/new');
});

//SHOW - Shows info about one campground
router.get('/:id', function(req, res) {
    //Find the campground with provided ID
    Campground.findById(req.params.id).populate('comments').exec(function(err, foundCampground){
        if(err){
            console.log(err);
        }else{
            res.render('campgrounds/show', {campground: foundCampground});
        }
    });
});

//Edit Campground Route
router.get('/:id/edit', middleware.checkCampgroundOwnership, function(req, res){
    Campground.findById(req.params.id, function(err, campground){
        if(err){
            console.log(err);
        }else{
            res.render('campgrounds/edit', {campground:campground});
        }
    });
});

//Update Campground Route
router.put('/:id', middleware.checkCampgroundOwnership, function(req, res){
    Campground.findByIdAndUpdate(req.params.id, req.body.campground, function(err, campground){
        if(err){
            console.log(err);
        }else{
            res.redirect('/campgrounds/'+req.params.id);
        }
    });
});

//Delete Campground
router.delete('/:id', middleware.checkCampgroundOwnership, function(req, res){
    Campground.findByIdAndRemove(req.params.id, function(err){
        if(err){
            console.log(err);
        }else{
            res.redirect('/campgrounds');
        }
    });
});

module.exports = router;