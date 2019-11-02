var express=require('express')
var mysql=require('mysql');

var app=express()

var ejs=require('ejs');
var bodyparser=require('body-parser');

urlencodedparser=bodyparser.urlencoded({extended: false});

app.set('view engine','ejs')

var db = mysql.createConnection({
    host     : 'localhost',
    user     : '17shashank17',
    password : 'lelopassword@',
    database : 'User_Info'
});

db.connect((err)=>{
    if(err) throw err;
    else
        console.log('Connection with database established');
});

app.get('/createtable',(req,res)=>{
    db.query('Create table User(name varchar(20), username varchar(20))',(err,results)=>{
        if (err) throw err;
        else
            console.log(results);
});

})

app.get('/',(req,res)=>{
    res.render('home');
});

app.post('/',urlencodedparser,(req,res)=>{
    console.log(req.body);
    console.log(`${req.body.fullname}`);
    db.query(`insert into User values('${req.body.fullname}','${req.body.username}')`,(err,result)=>{
        if(err) throw err;
        else{
            console.log('insertion complete');
            res.redirect('/');
        }
    });
})

app.listen(8080,()=>{
    console.log('connected to the server')
})