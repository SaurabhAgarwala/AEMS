var express=require('express')

var app=express();

app.set('view engine','ejs')
app.use('/',require('./Router/index.js'));
app.use('/ambulance',require('./Router/ambulance.js'));

app.listen(8080,()=>{
    console.log('connected to the server');
})