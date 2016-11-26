"use strict";
const db =require('../db');
class SubscriptionManager{
    static table(){
        return "Subscriptions";
    }
    static subscribe(user,thread,success,error){
        let insert_options = {
            data: {
                'user':   user,
                'thread': thread
            },
            table: this.table()
        };
        db.insert(insert_options).then(
            function(result){
                success(result)
            }).catch(function(err){
            error(err);
        });
    }
    static unsubscribe(user,thread,success,error){
        let where = 'user =? and thread=?';
        where=db.format(where,[user,thread]);
        let delete_options = {
            'where': where,
            table: this.table()
        };
        db.delete(delete_options).then(
            function(result){
                success(result)
            }).catch(function(err){
            error(err);
        });
    }
    static list_subscribers (thread, success, error){
        let options ={
            columns:['user'],
            from:   this.table(),
            where:  db.format('folowee = ?',[subject.email])
        };
        db.select(options).then(function(result){
            success(result);
        }).catch(function(err){
            error(err);
        })
    }
    static list_subscriptions (user, success ,error){
        let options ={
            columns:['thread'],
            from:   this.table(),
            where: db.format('user = ?',[user.email])
        };
        db.select(options).then(function(result){
            success(result);
        }).catch(function(err){
            error(err);
        })
    }
}
module.exports.SubscriptionManager =SubscriptionManager;
