var express=require('express')
var mysql=require('mysql');
var io=require('../app.js');

const kmeans=require('node-kmeans');
var reader=require('csv-reader');

const {ensureAuthenticated}=require('../config/auth');

var app=express.Router();

var ejs=require('ejs');
var bodyparser=require('body-parser');

urlencodedparser=bodyparser.urlencoded({extended: false});

var db = mysql.createConnection({
    host     : 'localhost',
    user     : '17shashank17',
    password : 'lelopassword@',
    database : 'aems'
});

db.connect((err)=>{
    if(err) throw err;
    else
        console.log('Connection with mysql database established');
});

function findistance(point1,point2){
    var ans = Math.sqrt(Math.pow(point1[0]-point2[0],2)+ Math.pow(point1[1]-point2[1],2));
    return ans;
}

function optimizeAmbulanceLocation(disease_name){
    db.query(`select x,y from Patient_records where disease='${disease_name}' order by ID desc limit 100;`,(err,train_points)=>{
        console.log('train pts',train_points)
        console.log('name',disease_name);
        db.query(`select vehicle_no from Ambulance_loc where vehicle_no in (select Amb.vehicle_no from (select vehicle_no from Ambulance
            where tools in (select Tools from Diseases where Disease='${disease_name}')) as Amb group by Amb.vehicle_no 
            having count(Amb.vehicle_no)=(select count(Tools) from Diseases where Disease='${disease_name}'))`,(err,ambulance_ids)=>{
                train_pts = []
                for (pt of train_points){ 
                    train_pts.push([pt.x,pt.y]);
                }
                console.log('train pts',train_pts)
                var no_of_clusters = ambulance_ids.length;
                km(train_pts,no_of_clusters,ambulance_ids);
        })      
    })
};

function km(test,k_value,ambs_nos){
    kmeans.clusterize(test,{k:k_value},(req,res,err)=>{
        if(err) throw err;
        else{
            // console.log('clusterised');
            // console.log('%o',res);
            // console.log(res[0].centroid);
            // centroids = []
            console.log('ambs_nos',ambs_nos[0].vehicle_no);
            count = 0;
            for (i of res){
                console.log('Centroid',count,Math.floor(i.centroid[0]),Math.floor(i.centroid[1]));
                console.log('Values',count,Math.floor(i.centroid[0]),Math.floor(i.centroid[1]),ambs_nos[count].vehicle_no);
                db.query(`update Ambulance_loc set x='${Math.floor(i.centroid[0])}', y='${Math.floor(i.centroid[1])}' where vehicle_no='${ambs_nos[count].vehicle_no}'`,(err,results)=>{
                    if(err) throw err;
                    else{
                        console.log('Ambulance Location Optimized',results);
                    }
                });
            count++;
            }
            db.query(`select * from Ambulance_loc`, (err,results)=>{
                if(err) throw err;
                console.log(results);
            });
        }
    })
};


app.get('/createtable',(req,res)=>{
    db.query('Create table User(name varchar(20), username varchar(20))',(err,results)=>{
        if (err) throw err;
        else
            console.log(results);
    });
});

app.get('/dashboard/register',ensureAuthenticated,(req,res)=>{

    db.query(`Select vehicle_no from Ambulance_driver where driver_name='${req.user.username}'`,(err,result)=>{
        if(err) console.log('Error occured dashboard_register')
        else{
            console.log(result);
            if(result.length>0){
                req.flash('success_msg','Your ambulance is registered')
                res.redirect('/dashboard')
            }
            else
                res.render('ambulance_register');
            // only unregistered people can visit 
        }
    })
    
})

app.post('/dashboard/register',ensureAuthenticated,(req,res)=>{
    console.log(req.user.username)
    db.query(`insert into Ambulance values('${req.body.ambulance_number}','${req.body.equipments}')`,(err,result)=>{
        if(err) console.log("Error 1")
        else console.log("insertion 1 complete");
    })
    db.query(`insert into Ambulance_loc values('${req.body.ambulance_number}','${50}','${50}',${500},${20},'Available')`,(err,result)=>{
        if(err) console.log("Error 2")
        else console.log("insertion 2 complete");
    })
    db.query(`insert into Ambulance_driver values('${req.body.ambulance_number}','${req.user.username}','${req.body.contact_no}',${5})`,(err,result)=>{
        if(err) console.log("Error 3")
        else {
            console.log("insertion 3 complete");
            res.redirect('/dashboard');
        }

    });

});

app.get('/',(req,res)=>{
    res.render('main');
});

app.post('/',urlencodedparser,(req,res)=>{
    /*var xhr=new XMLHttpRequest();
    xhr.open('POST','http://localhost:8080/dashboard',{'a':'b'})
    xhr.send();*/

    if (typeof(req.body.problem)!='string'){
        var data=[];
        var amb_vehicle_no = 0;
        var total_distance = 0;
        db.query(`Select * from Ambulance_loc where status='Available'`,(err,results)=>{
            // console.log(results);
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
            // console.log(results[min_distance_index].vehicle_no);
            amb_vehicle_no = results[min_distance_index].vehicle_no
            data.push({vehicle_no:results[min_distance_index].vehicle_no,x:results[min_distance_index].x,y:results[min_distance_index].y, 
                base_fare:results[min_distance_index].base_fare, charge_per_km:results[min_distance_index].charge_per_km});
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
                // console.log(results[min_index])
            }
            total_distance = min_dist;
            var cost = data[0].base_fare + (min_dist*data[0].charge_per_km);
            // console.log('cost', cost);
            data.push({hid:results[min_index].ID,x:results[min_index].x,y:results[min_index].y, cost:parseInt(cost), distance:min_dist});
            // console.log('inside if',data)
            // res.render('results',{data:data});
            console.log(amb_vehicle_no);
            db.query(`select * from Ambulance_driver where vehicle_no='${amb_vehicle_no}'`,(err,results)=>{
                if(err) console.log('this is the error', results);
                else{
                    // console.log('these results', results)
                    data.push({contact_no:results[0].contact_no, driver_name:results[0].driver_name})
                    // console.log('inside if',data);
                    res.render('results',{data:data});
                }
            });
            // console.log('inside if',data)
            
        });
    }
    else{
        var data=[];
        var amb_vehicle_no = 0;
        db.query(`insert into Patient_records(x,y,disease) values('${req.body.x}','${req.body.y}','${req.body.problem}')`,(err,results)=>{
            if(err) throw err;
            else console.log("insertion complete");

        });
        var min=20000;
        var min_index=0;
        db.query(`select x,y,vehicle_no,base_fare,charge_per_km from Ambulance_loc where status='Available' and vehicle_no in (select Amb.vehicle_no from (select vehicle_no from Ambulance
            where tools in (select Tools from Diseases where Disease='${req.body.problem}')) as Amb group by Amb.vehicle_no
            having count(Amb.vehicle_no)=(select count(Tools) from Diseases where Disease='${req.body.problem}'))`,(err,results)=>{
                if(err) throw err;
                else{
                    var min_dist=20000;
                    var min_index=-1
                    var k=0;
                    console.log('%%%%',results.length)
                    if(results.length>0){
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
                
                amb_vehicle_no = results[min_index].vehicle_no
                data.push({vehicle_no:results[min_index].vehicle_no,x:results[min_index].x,y:results[min_index].y,problem:req.body.problem,base_fare:results[min_index].base_fare,charge_per_km:results[min_index].charge_per_km});
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
                            k+=1;
                        }
                        //Hospital Found
                        console.log(results[min_index]);
                    }
                    console.log('@@@@@@',data)
                    total_distance = min_dist;
                    var cost = data[0].base_fare + (min_dist*data[0].charge_per_km);
                    data.push({hid:results[min_index].ID,x:results[min_index].x,y:results[min_index].y,cost:parseInt(cost), distance:min_dist});
                    // console.log('data',data);
                    // res.render('results',{data:data});
                //send optimised ambulance and hospital id
                    console.log('Ambulance number',amb_vehicle_no);
                    db.query(`select * from Ambulance_driver where vehicle_no='${amb_vehicle_no}'`,(err,results)=>{
                    if(err) console.log('this is the error', results);
                    else{
                        data.push({contact_no:results[0].contact_no, driver_name:results[0].driver_name})
                        res.render('results',{data:data});
                    }
                });
            });
            }
                else{
                    console.log('entered in else')
                    db.query(`Select * from Ambulance_loc where status='Available'`,(err,results)=>{
                        console.log('query executed');
                        if(err) throw console.log("Error Occured");
                        else{
                            
                        var points=[];
                        k=0;
                        min_distance=99999;
                        min_distance_index=-1;
                        console.log('results',results)
                        for (i of results){
                            var distance=findistance([req.body.x,req.body.y],[i.x,i.y])
                            if (distance<min_distance){
                                min_distance=distance;
                                min_distance_index=k;
                            }
                            k+=1;
                        }
                        // console.log(results[min_distance_index].vehicle_no);
                        amb_vehicle_no = results[min_distance_index].vehicle_no
                        data.push({vehicle_no:results[min_distance_index].vehicle_no,x:results[min_distance_index].x,y:results[min_distance_index].y, 
                            base_fare:results[min_distance_index].base_fare, charge_per_km:results[min_distance_index].charge_per_km});
                        console.log('#####',data)
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
                                k+=1;
                            }
                            //Hospital Found
                            console.log(results[min_index]);
                        }
                        console.log('@@@@@@',data)
                        total_distance = min_dist;
                        var cost = data[0].base_fare + (min_dist*data[0].charge_per_km);
                        data.push({hid:results[min_index].ID,x:results[min_index].x,y:results[min_index].y,cost:parseInt(cost), distance:min_dist});
                        // console.log('data',data);
                        // res.render('results',{data:data});
                    //send optimised ambulance and hospital id
                        console.log('Ambulance number',amb_vehicle_no);
                        db.query(`select * from Ambulance_driver where vehicle_no='${amb_vehicle_no}'`,(err,results)=>{
                        if(err) console.log('this is the error', results);
                        else{
                            data.push({
                                contact_no:results[0].contact_no, 
                                driver_name:results[0].driver_name,
                                statement:'Ambulance according to disease is not available. Sending you the nearest Ambulance'
                            })
                            console.log('@@@@@@data',data)
                            res.render('results',{data:data});
                        }
                    });
                });

                }
        }
        });
    //     db.query(`Select * from Hospitals`,(err,results)=>{
    //         if(err) throw err;
    //         else{
    //             var min_dist=20000;
    //             var min_index=-1;
    //             var k=0;
    //             for (i of results){
    //                 x=findistance([i.x,i.y],[req.body.x,req.body.y])
    //                 if(x<min_dist){
    //                     min_dist=x;
    //                     min_index=k;
    //                 }
    //                 k+=1;
    //             }
    //             //Hospital Found
    //             console.log(results[min_index]);
    //         }
    //         console.log('@@@@@@',data)
    //         total_distance = min_dist;
    //         var cost = data[0].base_fare + (min_dist*data[0].charge_per_km);
    //         data.push({hid:results[min_index].ID,x:results[min_index].x,y:results[min_index].y,cost:parseInt(cost), distance:min_dist});
    //         // console.log('data',data);
    //         // res.render('results',{data:data});
    //     //send optimised ambulance and hospital id
    //         console.log('Ambulance number',amb_vehicle_no);
    //         db.query(`select * from Ambulance_driver where vehicle_no='${amb_vehicle_no}'`,(err,results)=>{
    //         if(err) console.log('this is the error', results);
    //         else{
    //             data.push({contact_no:results[0].contact_no, driver_name:results[0].driver_name})
    //             res.render('results',{data:data});
    //         }
    //     });
    // });

    }
});

app.get('/dashboard',ensureAuthenticated,(req,res)=> {
    console.log(req.user.username)
    db.query(`select a.status as status,a.vehicle_no as vehicle_no from Ambulance_loc a ,Ambulance_driver b where b.driver_name='${req.user.username}'
    and a.vehicle_no=b.vehicle_no`,(err,result)=>{
        if(err) console.log('Error');
        else{
            console.log(result)
            if(result.length==0)
                res.render('dashboard',{username:req.user.username})
            else
                res.render('dashboard',{username:req.user.username,status:result[0].status,vehicle_no:result[0].vehicle_no})
        }
    })
    
});

app.post('/dashboard/change_status',(req,res)=>{
    console.log(req.user.username)
    db.query(`update Ambulance_loc set status='Available' where Ambulance_loc.vehicle_no=(select 
        vehicle_no from Ambulance_driver where driver_name='${req.user.username}')`,(err,results)=>{
            if(err) console.log('err');
            else{
                console.log('updation done');
                res.json(JSON.stringify({'a':'done'}));
            }
        })  
})

app.post('/dashboard',(req,res)=>{
    console.log('POST request')
    console.log(req.body)
    res.send(JSON.stringify({'a':'b'}));
})


module.exports={app,optimizeAmbulanceLocation};

