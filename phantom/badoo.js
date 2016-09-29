console.log('Start');

var page = require('webpage').create();


//page.onResourceReceived = function(response) {
//    if (response.stage !== "end") return;
//    console.log('Response (#' + response.id + ', stage "' + response.stage + '"): ' + response.url);
//};
//page.onResourceRequested = function(requestData, networkRequest) {
//   console.log('Request (#' + requestData.id + '): ' + requestData.url);
//};
page.onUrlChanged = function(targetUrl) {
    console.log('New URL: ' + targetUrl);
};
page.onLoadFinished = function(status) {
    console.log('Load Finished: ' + status);
};
page.onLoadStarted = function() {
    console.log('Load Started');
};
page.onNavigationRequested = function(url, type, willNavigate, main) {
    console.log('Trying to navigate to: ' + url);
};




page.open('https://loveplanet.ru', function(status) {
//page.open('http://module.ru', function(status) {	
  //console.log("Status: " + status);
  phantom.outputEncoding="cp866";
  var title = page.evaluate(function() {
	 // var arr = document.getElementsById('old_browser');
	 var arr = document.getElementsByClassName('gbut_grd_gray gnl_but30 w90 fbold');
	 arr[0].click();
  //gbut_grd_gray gnl_but30 w90 fbold");
	//	console.log("found: " + arr.length);// == 1){
	//return arr.length;
	 return document.title; 
  });
  console.log('page title is ' + title);
  //document.getElementsByClassName("login-form");
  //var arr = document.getElementsByClassName("height_full");//gbut_grd_gray gnl_but30 w90 fbold");
  		//console.log('Hello, world!');
		//}
		
  //if (status === "success") {
	console.log('sleeping...');
	//sleep(1);
	console.log('stop');
	page.render('example.png');
	//var ua = page.evaluate(function() {
		
	//}
	//var ua = page.evaluate(function() {
		//document.getElementById('myagent').textContent;
		//var arr = document.getElementsByClassName("gbut_grd_gray gnl_but30 w90 fbold");
		//if (arr.length == 1){
		//	console.log('Hello, world!');
		//}
    //}
  //}
  console.log('The end!');
  phantom.exit();
});