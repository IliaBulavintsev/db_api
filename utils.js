/**
 * Created by danil on 06.04.16.
 */
"use strict";
const EventEmitter = require('events');
const db = require ('./db');

exports.array_fetch= function (array, success,error,options){
    let counter = array.length;
    let emiter = new EventEmitter();
    emiter.on('fetch_success',function(event){
        counter--;
        if(!counter){
            emiter.removeAllListeners('fetch_success');
            success(array);
        }
    });
    for(let i =0; i< array.length; i++){
        array[i].fetch(function(result){
            emiter.emit('fetch_success');
        },function(err){
            emiter.removeAllListeners('fetch_success');
            error(err);
        },options);
    }
};

exports.get_list = function(success, error ,options){
    let where =' ' + options.equals;
    if(options['since'])
        where += ' and ' + options.since;
    let select_options ={
        columns:options.columns,
        from:   options.table,
        where: db.format(where,[options.user ])
    };
    if(!options['explicit_order']) {
        select_options['order_by'] = options['order_field'] + ((options['order'] === 'asc') ? ' asc ' : ' desc ' );
    }
    else{
        select_options['order_by'] = options['explicit_order'];
    }
    if (options['limit'])
        select_options['limit'] = options['limit'];
    db.select(select_options).then(function(result){
        let objects =new Array(result.length);
        for(let i=0; i< objects.length; i++){
            objects[i]= new options.class();
            objects[i][options.primary_key] = result[i][options.pk_res];
        }
        if(objects.length)
            exports.array_fetch(objects,success,error,options['fetch_options']);
        else
            success(objects);
    }).catch(function(err){
        error(err);
    });
};
const POSIBLE_RELATED ={
    "Forums":{"user":''},
    "Threads":{'user':'','forum':''},
    "Posts":{'user':'','forum':'','thread':''}
};
exports.check_related = function(related,table){
    let res;
    if(related) {
        if(related instanceof  Array) {
            for (let i = 0; i < related.length; i++) {
                if(!(related[i] in POSIBLE_RELATED[table])){
                    res = new Error("Table "+ table +" not supports related=" + related[i]);
                    res.type='semantic_error';
                    break;
                }
            }
        }
        else if(!(related in POSIBLE_RELATED[table])){
            res = new Error("Table "+ table +" not supports related=" + related);
            res.type='semantic_error';
        }
    }
    return res;
};
exports.related_set=function(related){
    let related_set = new Set();
    if(related) {
        if(related instanceof  Array) {
            for (let i = 0; i < related.length; i++) {
                related_set.add(related[i]);
            }
        }
        else{
            related_set.add(related);
        }
    }
    return related_set;
};
exports.response_list=function(req,res,options){
    req.query.related = exports.related_set(req.query.related);
    options['manager'].options['method'](
        function(result){
            res.json(response.ok(result))
        },
        function(err){
            req.next(err);
        },req.query);
};