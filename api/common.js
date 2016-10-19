/**
 * Created by danil on 21.03.16.
 */
"use strict";
var express = require('express');
var router = express.Router();
var db = require('../db');
var response = require('../response');

router.use('/clear',function(req,res){
    //var clear_query = \n';
    var i=0;
    var queries =['SET foreign_key_checks = 0'];
    for (var j=0; j<db.tables.length;j++){
        queries.push("TRUNCATE " + db.tables[j]+" ;");
    }
    queries.push('SET foreign_key_checks = 1');
    db.queries(queries).then(function(result){
        res.send('{"code":0,"response":"OK"}');
    }).catch(function(err){
        req.next(err);
    });
});

router.use('/status',function(req,res){
    var tables =['Users;','Forums;','Threads;','Posts;'];
    var params = ['user','forum','thread','post'];
    var queries = [];
    for(var i=0;i<tables.length;i++){
        queries.push('SELECT COUNT(*) as ans FROM ' + tables[i]);
    }
    db.queries(queries).then(function(result){
       var resp ={};
       for(var i=0;i<params.length;i++){
           resp[params[i]]=result[i][0]['ans'];
       }
       /*response.user =   result[0][0].ans;
       response.forum =  result[1][0].ans;
       response.thread = result[2][0].ans;
       response.post =   result[3][0].ans;*/
       res.json(response.ok(resp));
    }).catch(function(err){
        req.next(err);
    });
});
module.exports = router;