"use strict";
const User = require('./user').User;
//const Thread = require('./models').Thread;
const Attribute = require('./base').Attribute;
const db = require('../db');
const Model = require('./base').Model;
const utils = require('../utils');

class Forum extends Model  {
    constructor() {
        super();
        this.table = 'Forums';
        this._id = new Attribute('id', '');
        this._name = new Attribute('name', '');
        this._short_name = new Attribute('short_name', '');
        this._user = new Attribute('user', '');
    }

    get id() {
        return this._id.value;
    }

    get name() {
        return this._name.value;
    }

    get short_name() {
        return this._short_name.value;
    }

    get user() {
        return this._user.value;
    }

    set id(value) {
        this._id.value = value;
    }

    set name(value) {
        this._name.value = value;
    }

    set short_name(value) {
        this._short_name.value = value;
    }

    set user(value) {
        this._user.value = value;
    }

    toJSON() {
        return {
            id: this.id,
            name: this.name,
            short_name: this.short_name,
            user: this.user
        };
    }
    //copy(object){
    //    for(let key in this){
    //        if(key in object){
    //            this[key] = object[key];
    //        }
    //    }
    //}
    fetch(success, error, options) {
        let sql = 'SELECT * FROM Forums WHERE short_name = ?';
        sql = db.format(sql,[this.short_name]);
        db.query(sql).then(function (result) {
            if(result.length) {
                this.id = result[0].id;
                this.name = result[0].name;
                this.user = result[0].user;
                if (options['related'] && options['related'].has('user')) {
                    this.user = new User();
                    this.user.email = result[0].user;
                    this.user.fetch(success, error);
                }
                else
                    success(result);
            }
            else{
                let e = new Error('Forum with shortname' + this.short_name + ' not found!');
                e.type ='not_found';
                error(e);
            }
        }.bind(this)).catch(function (err) {
            error(err);
        });
    }
       save(success, error, options) {
        let insert_options = {
            data: {
                'name': this.name,
                'short_name': this.short_name,
                'user': this.user
            },
            table: this.table
        };
        db.insert(insert_options).then(function (result) {
            this.id = result.insertId;
            success(result);
        }.bind(this)).catch(function (err) {
            error(err);
        });
    }
}
module.exports.Forum= Forum;
