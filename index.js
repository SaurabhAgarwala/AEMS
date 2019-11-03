var express=require('express')
var mysql=require('mysql');

const kmeans=require('node-kmeans');
var reader=require('csv-reader');

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
    console.log('Pts:',point1,point2)
    var ans = Math.sqrt(Math.pow(point1[0]-point2[0],2)+ Math.pow(point1[1]-point2[1],2));
    console.log(ans);
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
    res.render('home');
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
        db.query(`select Amb.vehicle_no from (select vehicle_no from Ambulance
            where tools in (select Tools from Diseases where Disease='${req.body.problem}')) as Amb group by Amb.vehicle_no 
            having count(Amb.vehicle_no)=(select count(Tools) from Diseases where Disease='${req.body.problem}')`,(err,results)=>{
                console.log('Results from query:',results);
                // var k=0;
                for (i=0;i<results.length;i++){
                    console.log('Individual Ambulance:',results[i]);
                    db.query(`select x,y,vehicle_no from Ambulance_loc where vehicle_no = '${results[i].vehicle_no}' and status='available'`,(err,result)=>{
                        if(err) throw err;
                        else{ 
                            console.log('In else');
                            console.log('Ambulance Location',result[0].x,result[0].y)
                            x=findistance([result[0].x,result[0].y],[req.body.x,req.body.y]);
                            console.log('min_current',min, 'Current distance',x);
                            if (min>x){
                                min=x;
                                min_index=k;
                                console.log('updated index',min_index);
                            }
                        }
                    });
                    k+=1;
                }
                console.log('Ans_min_index',min_index);
                console.log('Ans',results[min_index]);
            });
    }
});

app.listen(8080,()=>{
    console.log('connected to the server');
})