var express = require('express');
var router = express.Router();
var fs = require('fs');
var path = require("path");

/* GET home page. */
router.get('/', function(req, res) {
  res.render('index', { title: 'Express' });
});



function create_json_dir() {
	var static_dir = path.join(__dirname.replace('routes',''), 'public/json');
	console.log('sss = ' + static_dir);

  var deferred = Q.defer();
	fs.readdir(static_dir,function(err, files){
		if(err){
			console.log(err);
			fs.mkdir(static_dir);
		}
		
		deferred.resolve();
	});
	
  return deferred.promise;
}


router.post('/config', function(req, res){
	// console.log(req)
	console.log(req.body);
	console.log(req.url);	
 	var obj = req.body;
	var static_dir = path.join(__dirname.replace('routes',''), 'public/json');

	
	fs.writeFile(static_dir + '/config.json' ,JSON.stringify(req.body), function(err){
	    console.log ('youxi!');
			
			res.set('Content-Type', 'text/html');
		  res.send(obj);
	});
});

module.exports = router;
