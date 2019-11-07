var express=require('express');

var passport=require('passport');

var mysql=require('mysql');
var io=require('../app.js')

var optimizeAmbulanceLocation = require('./index.js').optimizeAmbulanceLocation

var router=express.Router()

var db = mysql.createConnection({
    host     : 'localhost',
    user     : 'saurabh',
    password : 'Saurabh@2021',
    database : 'aems'
});

db.connect((err)=>{
    if(err) throw err;
    else
        console.log('Connection with mysql database ambulance established');
});
//var bodyparser=require('body-parser');

//urlencoded=bodyparser.urlencoded({extended:false})

router.get('/login',(req,res) => res.render('login'));

router.get('/register',(req,res) => res.render('register'));

const User=require('../models/User');

const bcrypt=require('bcryptjs');

router.post('/register',function(req,res){
    console.log(req.body);
    const {nameofuser,username,password,conf_password,email}=req.body;
    let errors=[]
    if (!nameofuser || !username || !password || !email){
        errors.push("Fields can not be left empty");
    }
    if (password.length<6){
        errors.push('Password length must be greater than 6');
    }
    if(password != conf_password){
        errors.push('Password do not matches');
    }
    if (errors.length>0){
        res.render('register',{
            errors,
            nameofuser,
            username,
            password,
            conf_password,
            email
        })
    }
    else{
        User.findOne({email:email})
        .then(user => {
            if(user){
                errors.push('Email is already registered');
                res.render('register',{
                    errors,
                    nameofuser,
                    username,
                    password,
                    conf_password,
                    email,
                }); 
            }
            else{
                const newUser=new User({
                    nameofuser,
                    username,
                    password,
                    email,
                });
                bcrypt.genSalt(10,(err,salt) => {
                    bcrypt.hash(newUser.password,salt,(err,hash) => {
                        if(err) throw err;

                        newUser.password=hash;
                        //console.log(newUser.password);
                        newUser.save()
                        .then(user => {
                            
                            req.flash('success_msg','You have successfully created your account. Login to Continue');
                            res.redirect('/ambulance/login');
                        })
                        .catch(err => console.log(err));
                    })
                })
            }
        });
    }
});

router.post('/login',(req,res,next) => {
    passport.authenticate('local',{
        successRedirect: '/dashboard',
        failureRedirect: '/ambulance/login',
        failureFlash: true
    })(req,res,next)
})

router.get('/logout',(req,res) => {
    req.logout();
    req.flash('success_msg','Successfully Logged Out!');
    res.redirect('/');
})

router.post('/change_status_available/:vehicle_no',(req,res)=>{
    console.log(req.params.vehicle_no);
    res.json(JSON.stringify({'status':'available'}));
});

router.post('/confirmation/:vehicle_no',(req,res)=>{
    db.query(`update Ambulance_loc set status='Not Available' where vehicle_no='${req.params.vehicle_no}'`,(err,result)=>{
        if(err) console.log('Error ocuured while updation');
        else{
            console.log('updated');
            console.log('####################################################################################');
            console.log(req.body.problem);
            io.sockets.on('connection',(socket)=>{
                console.log('inside amulance io');
                io.sockets.emit('send detail to driver',{patient:'yes done'});
            })
            console.log('ends here  ')
            optimizeAmbulanceLocation(req.body.problem)
            console.log('starts here')
            res.json(JSON.stringify({'status':'Booked'}))
        }
    })
    //req.flash('success_msg','Your booked ambulance is on the way')
    
});

module.exports=router;