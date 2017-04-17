/**
 * 
 */
var admin = require("firebase-admin");
console.log("Running1");
var fs=require('fs');

var file=fs.createReadStream("confirmed.csv");

//var csv=require('csv');

var request = 	require('request');

var id="OneSignal_APP_ID";

var Key="OneSignal_REST_API_KEY";
admin.initializeApp({
	  credential: admin.credential.cert({
		    projectId: "Project_id",
		    clientEmail: "client_email",
		    privateKey: "-----BEGIN PRIVATE KEY-----\n<KEY>n-----END PRIVATE KEY-----\n"
		  }),
	  databaseURL: "Firebase_database_URL"
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
	
	feed.on("child_added", function(snapshot) {
		var new_feed=snapshot.val();
		var message={
				app_id: id,
				headings: {"en": "Feeds"},
				ios_badgeType: "Increase",
				ios_badgeCount: 1,
				contents: {"en": new_feed},
				included_segments: ["All"]					
		};
		sendNotification(message);
	}, function(error) {
		console.log("The read failed: "+error.code);
	});
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

	
	
