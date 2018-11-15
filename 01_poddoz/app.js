const http = require('http');
const os = require('os');
const fs = require('fs');

console.log("Poddoz server starting...");

var express = require('express');
var app = express();

app.get('/', function(request, response) {
  console.log("Received request from " + request.connection.remoteAddress + " at /");
  response.writeHead(200);
  response.end("At / Poddoz says its name is " + os.hostname() + "\n");
});

app.get('/cheese', function(request, response) {
  console.log("Received request from " + request.connection.remoteAddress + " at /cheese");
  response.writeHead(200);
  response.end("At /cheese Poddoz says its name is " + os.hostname() + "\n");
});

app.get('/wine', function(request, response) {
  console.log("Received request from " + request.connection.remoteAddress + " at /wine");
  response.writeHead(200);
  response.end("At /wine Poddoz says its name is " + os.hostname() + "\n");
});

app.get('/healthy', function(request, response) {
  console.log("Received liveness request from " + request.connection.remoteAddress + " at /healthy");
  response.writeHead(200);
  response.end("Poddoz says it's happily running on " + os.hostname() + "\n");
});

app.get('/ready', function(request, response) {
  console.log("Received readiness request from " + request.connection.remoteAddress + " at /ready");
  response.writeHead(200);
  response.end("Poddoz says it's ready on " + os.hostname() + "\n");
});

app.get('/end', function(request, response) {
  console.log("Received end request from " + request.connection.remoteAddress + " at /ready");
  response.writeHead(200,{'content-type':'image/jpg'});
  fs.createReadStream('/image/demo.jpg').pipe(response);
});

app.get('/env', function(request, response) {
  console.log("Received request from " + request.connection.remoteAddress + " at /");
  console.log(process.env);
  response.writeHead(200);
  let output = "The list of environment variables is: \n";
  for (var variable in process.env) {
      output += variable + ": " + process.env[variable] + "\n";
  }
  response.end(output + "\n");
});

const PORT = process.env.PORT || 8080;
app.listen(PORT);
