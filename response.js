
exports.ok = function(data){
    "use strict";
    console.log('response: ');
    //console.log(data.toJSON());
    return {'code':0,'response':data};
};
exports.already_exists = function(user){
    "use strict";
    return {'code':5 , 'response' :'User with email ' + user.email + 'already exists'};
};
exports.not_found = function(user){
    "use strict";
    return {'code':3 , 'response' :'Not found'};
};
exports.err_response = function(err){
    "use strict";
    let response_code = 4;
    if(err.type === "not_found"){
        response_code = 1;
    }
    else if(err.type === "semantic_error"){
        response_code = 3;
    }
    else if(err.type === "user_already_exists"){
        response_code=5;
    }
    else if(err instanceof SyntaxError){
        response_code =2 ;
    }
    return {code:response_code,response:err.message};
};
