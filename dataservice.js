var restify = require('restify');
var http = require('http');

var server = restify.createServer();

server.use(restify.queryParser());
server.use(restify.bodyParser());

server.get('/transactiondata', function(req, res, next) {
  var tqid = req.params.tqid;

  var options = {
    host: 'bisapi08',
    port: 5017,
    path: '/transactions?transactionquoteids=' + tqid,
    headers: { Accept: 'application/json' }
  };
  
  callback = function(response) {
    var str = '';
    response.on('data', function(chunk) {
      str = str + chunk;
    });

    response.on('end', function() {
      var result = {
        results: JSON.parse(str)
      }
      //res.json(result);
      res.json(JSON.parse(str));
      return next();
    });
  }

  http.request(options, callback).end();
});

server.get('/componentdata', function(req, res, next) {
  var transid = req.params.transid;

  var options = {
    host: 'bisapi08',
    port: 5011,
    path: '/components?TransactionIds=' + transid,
    headers: { Accept: 'application/json' }
  };
  
  callback = function(response) {
    var str = '';
    response.on('data', function(chunk) {
      str = str + chunk;
    });

    response.on('end', function() {
      var result = {
        results: JSON.parse(str)
      }
      //res.json(result);
      res.json(JSON.parse(str));
      return next();
    });
  }

  http.request(options, callback).end();
});

server.listen(4000, function() {
  console.log('dataservice on port 4000');
});