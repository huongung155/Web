var express = require('express'),
    app = express(),
    bodyParser = require('body-parser'),
    mongoose = require('mongoose'),
    passport = require('passport'),
    methodOverride = require("method-override"),
    LocalStrategy = require('passport-local'),
    User = require('./models/user'),
    Campground = require('./models/campground'),
    Comment = require('./models/comment'),
    seedDB = require('./seeds');

var campgroundRoutes = require('./routes/campgrounds'),
    commentRoutes = require('./routes/comments'),
    indexRoutes = require('./routes/index');

mongoose.connect('mongodb://localhost/test');

app.use(bodyParser.urlencoded({extended: true}));
app.use(methodOverride("_method"));
app.set('view engine', 'ejs');
app.use(express.static('./public'));
//seedDB();

//PASSPORT Configuration
app.use(require('express-session')({
    secret: 'Quan Luu is quite handsome',
    resave: false,
    saveUninitialized: false
}));
app.use(passport.initialize());
app.use(passport.session());
passport.use(new LocalStrategy(User.authenticate()));
passport.serializeUser(User.serializeUser());
passport.deserializeUser(User.deserializeUser());

//The following code is actually add middleware to every single 'app.'
//This middleware is to add req.user to every single 'app.' like app.get("/campgrounds")
app.use(function(req, res, next){
    res.locals.currentUser = req.user;
    next();//do the code after middleware
});

app.use('/campgrounds', campgroundRoutes);//all link in router.get() starts by /campgrounds
app.use('/campgrounds/:id/comments', commentRoutes);
app.use(indexRoutes);

module.exports = app;