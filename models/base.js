"use strict";
class Attribute {
    constructor(name,value){
        this.name = name;
        this.value = value;
    }

}
class Model {
    toJSON(){
        let result ={};
        for (let key in this){
            if (this[key] instanceof Attribute){
                result[this[key].name]=this[this[key].name];
            }
        }
        return result;
    }
    copy(object){
        for(let key in this){
            if(this[key].name in object){
                if(this[key] instanceof Attribute) {
                    this[this[key].name] = object[this[key].name];
                }
            }
        }

    }
    update(success,error,options){
        let update_options = {
            'set': options.set,
            'where': options['field']+'= ?'  ,
            'table': this.table
        };
        update_options['where'] = db.format(update_options['where'],[  this[options['field'] ] ]);
        db.update(update_options).then(function (result) {
            if(options['fetch']) {
                this.fetch(success, error);
            }
            else{
                success(result);
            }
        }.bind(this)).catch(function (err) {
            error(err);
        });
    }
}
exports.Attribute = Attribute;
exports.Model = Model;
