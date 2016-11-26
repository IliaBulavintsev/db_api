
// Подключение к базе файл mysql.j
"use strict";
//var Promise = require('promise');
var mysql = require('mysql');
var pool = mysql.createPool({
    host: 'localhost',
    user: 'tp',
    password: 'password',
    database: 'api',
    connectionLimit: 100
});
var keys ={
  'Users':'email',
   'Forums':'name'
};
exports.query = function (sql, props, options) {
    return new Promise(function (resolve, reject) {
        pool.getConnection(function (err, connection) {
            connection.query(
                sql, props,
                function (err, res) {
                    if (err){
                        if(err.errno === exports.DB_ERRORS.DUPLICATE){
                            var key =  keys[options['table']];
                            var sql = 'SELECT id from ' + options['table'] + ' where ' + key+ ' = ' +'\'' + options['data'][key]+'\'';
                            connection.query(sql,{},
                              function(error,result){
                                  if(error){
                                      reject(error);
                                  }
                                  else{
                                    err.insertId = result[0].id;
                                    reject(err);
                                  }
                            });
                        }
                        else
                            reject(err);
                    }
                    else resolve(res);
                }
            );
            connection.release();
        });
    });
};
exports.queries = function (sqls, props) {
    return new Promise(function (resolve, reject) {
        var result =[];
        pool.getConnection(function (err, connection) {
            var last = sqls.length -1;
            var default_callback =function(err,res){
                if(err) reject(err);
                result.push(res);
            };
            for(var i=0;i < last;i++){
                connection.query(sqls[i],props,default_callback);
            }
            connection.query(sqls[last],props, function(err,res){
                default_callback(err,res);
                resolve(result);
            });
            connection.release();
        });
    });
};

exports.trasaction = function (queries_array,props){
    return new Promise(function (resolve, reject) {
        var default_callback =function(err,res){
            if(err) reject(err);
        };
        pool.getConnection(function (err, connection) {
            connection.query('START TRANSACTION;',props,default_callback);
            for(var i=0;i < queries_array.length;i++){
                connection.query(queries_array[i],props,default_callback);
            }
            connection.query('COMMIT;',props, function(err,res){
                if(err) reject(err);
                else resolve(res);
            });
            connection.release();
        });
    });
};
exports.format= function(sql,inserts){
    return mysql.format(sql,inserts);
};
exports.DB_ERRORS ={
    'DUPLICATE':1062
};
exports.insert = function(options){
    var columns = Object.keys(options['data']).length;
    var aux = function(columns){
        return  '('+new Array(columns).join(' ?,') + ' ?)';
    };

    var sql = 'INSERT INTO ' + options['table'] +' ( ' + Object.keys(options['data']).join(', ')  +')  values '+aux(columns);
    var inserts = [];
    for (let key in options['data']){
        inserts.push(options['data'][key]);
    }

    return exports.query( mysql.format(sql, inserts),{},options );
};
exports.delete =function(options){
    "use strict";
     var where =' where '+options['where'];
     var limit = (options['limit']) ? (' limit' + options['limit']) : '';
     var sql = 'delete from '+ options['table']+ ' ' + where + limit;
     return exports.query(sql);
};
exports.select = function(options){
    var columns = ((typeof options['columns']) ===  'string') ? options['columns'] : options['columns'].join(', ');
    var where  = (options['where']?(' where ' + options['where']):'');
    var orderby = options['order_by']?( (typeof(options['order_by']) === 'string') ? options['order_by'] : options['order_by'].join(', ')):'';
    orderby = orderby?' order by ' + orderby:'';
    var limit = ( options['limit'] ? ' limit '  + options['limit']:'');
    var sql = 'SELECT DISTINCT '+ columns + ' FROM ' +  options['from'] + where + orderby +limit;
    console.log(sql);
    return exports.query(sql,{},options);
};
exports.update = function(options){
    var where =' where '+options['where'];
    var set_c = ' set ' + options['set'];
    var sql ='update '+options['table'] + set_c + where;
    return exports.query(sql);
};

exports.tables =['Users','Posts','Forums','Threads',
                'Subscriptions', 'Followings'];
