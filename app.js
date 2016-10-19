var express = require('express');
var path = require('path');
//var favicon = require('serve-favicon');
var logger = require('morgan');
//var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var router = require('./api/router');
var response = require('./response');

var app = express();
var PORT =3000;

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));


//app.use(function(req,res){
//  "use strict";
//  if(req.body) {
//    console.log('request');
//    console.log(req.body);
//  }
//  req.next();
//});
app.use('/db/api', router);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not supports');
  err.status = 404;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    //console.log(err.stack);
    res.status(err.status || 200 );
    res.json(response.err_response(err));
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 200);
  res.json(response.err_response(err));
});

app.listen(PORT);
module.exports = app;
