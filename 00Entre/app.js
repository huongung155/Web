var express = require('express'),
    bodyParser = require('body-parser'),
    app = express();

// view engine setup
app.set('view engine', 'ejs');
app.use(express.static('./public'));

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(bodyParser.urlencoded({ extended: false }));

var adLink = 'https://drive.google.com/file/d/12WAKVeOHjGohJCFGBD2Ll4JXTXjp-yVT/preview';

//REGISTER route
app.get('/register', function (req, res) {
    res.render('register', {adLink: adLink});
});

app.get('/', function (req, res) {
    res.render('index');
});

app.get('/input', function (req, res) {
    res.render('input');
});

app.get('/result', function (req, res) {
    res.render('result');
})

module.exports = app;
