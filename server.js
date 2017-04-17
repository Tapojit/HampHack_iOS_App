/**
 * 
 */


//const express = require('express');
//const app = express();
//
//app.get('/', (req, res) => {
//  res.send('Hello World!');
//});
//
//const server = app.listen(8080, () => {
//  const host = server.address().address;
//  const port = server.address().port;
//
//  console.log(`Example app listening at http://${host}:${port}`);
//});













var admin = require("firebase-admin");
console.log("Running1");
var fs=require('fs');

var file=fs.createReadStream("confirmed.csv");

//var csv=require('csv');

var request = 	require('request');

var id="40807fb8-174d-48f1-9431-d4e5a0bf1e3e";

var Key="MmI2NWI3MzEtZjYxNS00ZWM1LWFjYjUtODczNzRlODY2ZDIx";
//var serviceAccount = require('/home/tapojit/Desktop/Hello World-73861094b52f.json');
admin.initializeApp({
	  credential: admin.credential.cert({
		    projectId: "hello-world-d1075",
		    clientEmail: "firebase-adminsdk-zov07@hello-world-d1075.iam.gserviceaccount.com",
		    privateKey: "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCcfULYCh5qlQ/t\nSNGA+guD851OcvEa4L1TZ/991zdBIygru6t8vrvbkGKEdW965ER2SFA3usGh0RLX\nWVLoKrd7mz8QGmzjHPsiE+1jpsm3Y2M/efEVWgs7ndq24Bmfxdv6q5Bz++WAAv3Q\ntyunTnVVePOKEX98mteX2z2IcFtvcoUvjC8juSh1xoAF6wUhE8itrVNticF2IcWv\nZPmISvAdp7wnPjHt2OU6c0J0gGMNUWDPZfzprC5MTeevebtFJV+qtPy1XU+wQwF1\n1hFJM6H+PUbKciW2BH7F+PZWvFhQgwWraM1nmGsZITmwtm1QvZ5iA3+UgbgXLm3F\nJwDC8gM/AgMBAAECggEBAI3x+Q3pr8lRyI6dfJuXM5bPBSNBk32j2Vesf81vyAjn\nkOqKYnTWtaPlhddMhoBcSdVYpprGZhkXghWgSlmZVbFjEoLS1W30vb8dgDjh8xrL\nphzPyWRqtsGu39L914BbgrwPnwn1tSi2jfAiFhC+VCPhgFb+pDssYN632UrHT8j4\nFp7e1iextFchUJErMVXkaEkdmhRaMquuhSvKax6fn4mwyOYRvFCmYwnUgCPDr7Eh\nM4jHr8Wc6V1ZGHxk4j+y0s8whDABGTPd31O2oI+pBZjb5Nvg51YHC3YmmMppc3OV\nSA+8/osKK7MY7Xvt5WU4R/jVyQzDVyTzVPgkd15aeRECgYEAzisE2pVEH2eG5Ftf\n1cBUB+QBA1L85NIAHyVxQm27PVaUljn9eMTqFdWQnLVAnj6Q9A1KHTZJ5hJx9iyE\nPkRMFU6V3GxB9JF/8ceRXPAP1Uv4TXzVqnZkL0qNguljRCT1wKtuQkJ+2tf3hpxJ\nymlgEAujBMd+lwCY0SDlQsESk50CgYEAwlBKKEi6Ys6BlXixiTSTJXT5h9ipIixb\nHKMWCsyNLJEAe0bKFFnnDSFPkwwjB67WUNx8HI23iV9f8d3sC7usnzschOPf2DEj\nHYX8edKVO/DIo8uyJ59OCLa13Keas2Q/Q6+1/hnA7xo9Gg9fDFQ3Vesa0cMzU8PY\n5VhUCbyVQYsCgYAnVd3fNouA0mfSOfzW85MUzlPDJppJrieHycUKP5Vx5osC/p11\n5VwkPlMREyP5DUbqyX5ShIEk/G/x4Bx7JNy/U/cTzzPmTbxzjPgXG1ZqA8ykPCUo\nGN6Uh0zopU7jOYoJ8KtgyP8bEgmQDVGm5OQHK7E2wDlO5jZB8FzNl7jLoQKBgBFc\nGPP2Y2h2aI9RBBNs9gRvqedgDOQ3sEAjtdFrKuWjYragwWcGDSVYJ4LMn8iM7yq0\nOAZZBt+n/KtgFzmJH8fuAQNCVHo9EZUOplq/3INJZLN1fEob6l3O7Pp0otaKCzjh\n1tGHvXvfDTxpySUR1QvBAFljJg/CvHro5EEmbvM3AoGBAJXb1/z8QshozKIqb/vO\nhnO6i/iZjlahNWXXplJ4pFR0pvtNOlcRpHe78fD8c0GGJs/Xg+Rix1WYhqY9hywZ\nLwJZkapVUnGM0VgQwrWaCTCcysqY5m4aKCyRznToxPWDEwscpn8lqg/ZXoW2zeGS\nOC+n5xoEq5AoLzftQen+aaXe\n-----END PRIVATE KEY-----\n"
		  }),
	  databaseURL: "https://hello-world-d1075.firebaseio.com/"
	});

var db = admin.database();
var announ=db.ref("HampHack/Announcements");
var feed=db.ref("HampHack/Feeds");

var sendNotification = function(data) {
	  var headers = {
	    "Content-Type": "application/json; charset=utf-8",
	    "Authorization": "Basic " + Key
	  };
	  
	  var options = {
	    host: "onesignal.com",
	    port: 443,
	    path: "/api/v1/notifications",
	    method: "POST",
	    headers: headers
	  };
	  
	  var https = require('https');
	  var req = https.request(options, function(res) {  
	    res.on('data', function(data) {
	      console.log("Response:");
	      console.log(JSON.parse(data));
	    });
	  });
	  
	  req.on('error', function(e) {
	    console.log("ERROR:");
	    console.log(e);
	  });
	  
	  req.write(JSON.stringify(data));
	  req.end();
	};


function listenForNotificationRequests() {
	announ.on("value", function(snapshot){
		var announcements = snapshot.val();
		
		if (announcements!=="null"){
			var message={
					app_id: id,
					headings: {"en": "Announcements"},
					ios_badgeType: "Increase",
					ios_badgeCount: 1,
					contents: {"en": announcements},
					included_segments: ["All"]					
			};
			sendNotification(message);
		}
		
		
	}, function(error) {
		console.log("The read failed: " +error.code);
	});
	
//	feed.on("child_added", function(snapshot) {
//		var new_feed=snapshot.val();
//		var message={
//				app_id: id,
//				headings: {"en": "Feeds"},
//				ios_badgeType: "Increase",
//				ios_badgeCount: 1,
//				contents: {"en": new_feed},
//				included_segments: ["All"]					
//		};
//		sendNotification(message);
//	}, function(error) {
//		console.log("The read failed: "+error.code);
//	});
	}

console.log("Running A-ok!");
listenForNotificationRequests();

//var reg=db.ref("HampHack/QR/Registration");
//var up={};
//var csvStream = csv
//	.parse()
//    .on("data", function(data){
//    	if (data[0]!==""){
//    		var part=data[1];
//    		var punctuationless = part.replace(/[.,\/#!$%\^&\*;:{}=\-_`~()]/g,"");
//    		var finalString = punctuationless.replace(/\s{2,}/g," ");
//    		up[finalString]=false;
//    	}
//    	
//    })
//	.on("end", function(){
//	     console.log("done");
//	     console.log(up);
//	     reg.update(up);
//	});
//	
//file.pipe(csvStream);

	
	
