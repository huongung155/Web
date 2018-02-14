var express = require('express'),
    router = express.Router(),
    Campground = require('../models/campground')

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
router.post('/', function(req, res){
    //get data from form and add to campgrounds array
    var name = req.body.name;
    var image = req.body.image;
    var desc = req.body.description;
    var newCampground = {name: name, image: image, description: desc};
    //Create a new campground and save to DB
    Campground.create(newCampground, function(err, newlyCreated){
        if(err){
            console.log(err);
        }else{
            //redirect back to campgound page
            res.redirect('/campgrounds');
        }
    });

});

//NEW - Display a form to make a new campground
router.get('/new', function(req, res) {
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

module.exports = router;