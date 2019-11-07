var express=require('express')

var app=express();
var ejslayout=require('express-ejs-layouts');
var path=require('path')

var server=require('http').createServer(app);
var io=require('socket.io').listen(server);
module.exports=io;



app.set('view engine','ejs')
app.use(ejslayout);

var bodyParser=require('body-parser');
app.use(bodyParser());
app.use(bodyParser.urlencoded());

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
    extended: true
  }));

// To include assets for UI
app.use(express.static(path.join(__dirname, "public")));

const expressSession = require('express-session')
const flash=require('connect-flash');
const passport=require('passport');

require('./config/passport')(passport);


app.set('view engine','ejs');


app.use(expressSession({
    secret: 'secret',
    resave: false,
    saveUninitialized: true
  }));

app.use(passport.initialize());
app.use(passport.session());

app.use(flash());

app.use((req,res,next) => {
    res.locals.success_msg=req.flash('success_msg');
    res.locals.error_msg=req.flash('error_msg');
    res.locals.error=req.flash('error');
    next();
});

var mongoose=require('mongoose');

const db=require('./config/keys').MongoURI;



mongoose.connect(db,{useUnifiedTopology:true,useNewUrlParser:true})
    .then(() => console.log("MongoDB Connection Established"))
    .catch(err => console.log(err));

app.use('/',require('./Router/index.js'));
app.use('/ambulance',require('./Router/ambulance.js'));



server.listen(8080,()=>{
    console.log('connected to the server');
})



