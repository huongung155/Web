//The order of declaration should be followed
var express = require('express'),
    mongoose = require('mongoose'),
    passport = require('passport'),
    bodyParser = require('body-parser'),
    User = require('./models/user'),
    LocalStrategy = require("passport-local"),
    passportLocalMongoose = require("passport-local-mongoose"),
    app = express();


mongoose.connect('mongodb://localhost/authentication');
app.use(bodyParser.urlencoded({extended: true}));
app.set('view engine', 'ejs');

app.use(require('express-session')({
    secret: 'Quan Luu is quite handsome',//an arbitrary sentence is used to encode and decode the session
    resave: false,
    saveUninitialized: false
    //resave and saveUninitialized is just to say please add them in
}));

app.use(passport.initialize());
app.use(passport.session());

//serializeUser & deserializeUser is responsible for reading data from session that is encoded
//All method serializeUser() & deserializeUser() is in User because we plugin passportLocalMongoose in User.js
passport.use(new LocalStrategy(User.authenticate()));
passport.serializeUser(User.serializeUser());
passport.deserializeUser(User.deserializeUser());

//==============================================
//ROUTES
//==============================================

//=====Homepage (if already login, user page)=====
app.get('/', function(req, res){
    res.render('home');
});

//midlleware: is implemmented before function(req, res)
//isLoggedin: is middleware to check whether guest is logged in before to allow access secret page
app.get('/secret', isLoggedin, function(req, res){
    res.render('secret');
});

function isLoggedin(req, res, next){
    if(req.isAuthenticated()){
        return next();
    }
    res.redirect('/login');
}
//=============================================

//================Sign Up========================
//Show sign up form
app.get('/register', function(req, res){
    res.render('register');
});

////Handling user sign up
app.post('/register', function(req, res){
    User.register(new User({username: req.body.username}), req.body.password, function(err, user){
        if(err){
            console.log(err);
            return res.render('register');
        }
        //The following line will handle everything in session: store correct information, run the serialized user method
        //In this case, we use local strategy, but in the future we can use twitter/ facebook strategy
        passport.authenticate('local')(req, res, function(){
            res.redirect('/secret');
        });
    });
});
//==============================================

//===============Log in/out=====================
//Login routes
app.get('/login', function(req, res) {
    res.render('login');
});

app.post('/login', passport.authenticate("local", {
    successRedirect: '/secret',
    failureRedirect: '/login'
}), function(req, res){

});

app.get('/logout', function(req, res) {
    req.logout();//passport destroys data in session, no effect on database
    res.redirect('/');
})
//==============================================

module.exports = app;
