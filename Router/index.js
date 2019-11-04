var express=require('express')
var mysql=require('mysql');

const kmeans=require('node-kmeans');
var reader=require('csv-reader');

const {ensureAuthenticated}=require('../config/auth');

/*points=[[2,10],[2,5],[8,4],[5,8],[7,5],[6,4],[1,2],[4,9]]

kmeans.clusterize(points,{k:3},(req,res,err)=>{
    if(err) throw err;
    else{
        console.log('clusterised');
        console.log('%o',res);
    }
})*/

var app=express.Router();

var ejs=require('ejs');
var bodyparser=require('body-parser');

urlencodedparser=bodyparser.urlencoded({extended: false});



function findistance(point1,point2){
    var ans = Math.sqrt(Math.pow(point1[0]-point2[0],2)+ Math.pow(point1[1]-point2[1],2));
    return ans;
}

var db = mysql.createConnection({
    host     : 'localhost',
    user     : '17shashank17',
    password : 'lelopassword@',
    database : 'aems'
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
    res.render('main');
});

app.post('/',urlencodedparser,(req,res)=>{

    if (req.body.problem==undefined){

        db.query(`Select * from Ambulance where status='available'`,(err,results)=>{
            console.log(results);
            console.log(req.body.problem);
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
    }
    else{

        db.query(`insert into Patient_records values('${req.body.x}','${req.body.y}','${req.body.problem}')`,(err,results)=>{
            if(err) throw err;
            else console.log("insertion complete");

        });
        var min=20000;
        var min_index=0;
        db.query(`select x,y,vehicle_no from Ambulance_loc where vehicle_no in (select Amb.vehicle_no from (select vehicle_no from Ambulance
            where tools in (select Tools from Diseases where Disease='${req.body.problem}')) as Amb group by Amb.vehicle_no
            having count(Amb.vehicle_no)=(select count(Tools) from Diseases where Disease='${req.body.problem}'))`,(err,results)=>{
                if(err) throw err;
                else{
                    var min_dist=20000;
                    var min_index=-1
                    var k=0;
                    for (i of results){
                        x=findistance([i.x,i.y],[req.body.x,req.body.y])
                        if(x<min_dist){
                            min_dist=x;
                            min_index=k;
                        }
                        k+=1
                    }
                    //Ambulance found
                    console.log(results[min_index]);

                }
        });
        db.query(`Select * from Hospitals`,(err,results)=>{
            if(err) throw err;
            else{
                var min_dist=20000;
                var min_index=-1;
                var k=0;
                for (i of results){
                    x=findistance([i.x,i.y],[req.body.x,req.body.y])
                    if(x<min_dist){
                        min_dist=x;
                        min_index=k;
                    }
                    k+=1
                }
                //Hospital Found
                console.log(results[min_index])
            }
        });
        //send optimised ambulance and hospital id

    }
});

app.get('/dashboard',ensureAuthenticated,(req,res)=> res.render('dashboard',{username:req.user.username}));

module.exports=app;

