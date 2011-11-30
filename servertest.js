var http = require('http');
http.createServer(function (req, res) {
    setTimeout(function(){
        res.writeHead(200, {'Content-Type': 'text/plain'});
        res.end('Hello World\n');
    },60*1000); //60 seconds
}).listen(1337);
console.log('running server');