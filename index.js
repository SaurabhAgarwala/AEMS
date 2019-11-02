var express=require('express')
var mysql=require('mysql');

const kmeans=require('node-kmeans');

/*points=[[2,10],[2,5],[8,4],[5,8],[7,5],[6,4],[1,2],[4,9]]

kmeans.clusterize(points,{k:3},(req,res,err)=>{
    if(err) throw err;
    else{
        console.log('clusterised');
        console.log('%o',res);
    }
})*/

var app=express()

var ejs=require('ejs');
var bodyparser=require('body-parser');

urlencodedparser=bodyparser.urlencoded({extended: false});

app.set('view engine','ejs')

function findistance(point1,point2){
    return Math.sqrt(Math.pow(point1[0]-point2[0],2)+ Math.pow(point1[1]-point2[1],2));
}

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

    /*db.query(`insert into Patient_Record values('${req.body.x}','${req.body.y}','${req.body.problem}')`,(err,result)=>{
        if(err) throw err;
        else{
            console.log('insertion complete');
        }*/
    db.query(`Select * from Ambulance where status='available'`,(err,results)=>{
        console.log(results); 
    
        var points=[];
        k=0;
        min_distance=99999;
        min_distance_index=-1;
        for (i of results){
            var distance=findistance([req.body.x,req.body.y],[i.x,i.y])
            if (distance<min_distance){
                min_distance=distance;
                min_distance_index=k;
            }
            k+=1;
        }
        console.log(results[min_distance_index].vehicle_no);
    });
})

app.listen(8080,()=>{
    console.log('connected to the server');
})