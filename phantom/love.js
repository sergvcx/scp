phantom.injectJs('settings.js');
var casper = require('casper').create();

//this.userAgent('Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)');
casper.start('http://loveplanet.ru', function() {
	phantom.outputEncoding="cp866";
    this.echo(this.getTitle());
	this.capture('love-start.png');
});

casper.then(function() {
	this.capture('love-00.png');
	this.click('a.gbut_grd_gray.gnl_but30.w90.fbold span');
	this.capture('love-01.png');
});

casper.then(function() {
	
	this.capture('love-10.png');
	//*[@id="anketa"]
	//test.assertExists('form[id="anketa"]', "main form is found");
	//this.fill('form[id="anketa"]', {
    //    dlg_login_log: "qwe",
    //     dlg_login_pas: "qwe"
    // }, true);
	 
	//this.fillSelectors('form#user-login', {
    //    'input[name = name ]' : 'abc@gmail.com',
    //    'input[name = pass ]' : 'pwd'
    //}, true);
	//this.waitForSelector("form input[name='login']", function() {
	//	this.fillSelectors('form#user-login', {
	//		'input[name = login]' : 'abc@gmail.com',
	//		'input[name = password ]' : 'pwd'
    //}, true);
	//casper.waitForSelector('form', function(){
	//	this.fill('form', {
	//		'login': 'abc@gmail.com', 
	//		'password': 'pwd'},
	//		true);
	//});
	//this.echo('I am out of selector');
	this.waitForSelector('form', function(){
		this.fill('form', {
			'login': email, 
			'password': password},
			true);
	});
		
	this.capture('love-11.png');
	
	//this.click('input.button.login');
	
	//#dlg_login > ul.reset.line.lab_w43 > li:nth-child(4) > div > button
	
	this.echo('filled');
});

casper.then(function() {
	this.echo('submit');
	this.evaluate(function () {
        $('form#anketa').submit();
    });
	
	this.capture('love-20.png');

});	

casper.then(function() {
	
	//body > div.height_full > div.head > div > ul > li:nth-child(1) > a
	
	this.echo('preexit');
	//this.wait(5000,function(){
	//	this.echo('exit');
	//	this.capture('love-30.png');
	//});
	this.waitForSelector('div.height_full', function(){
		this.echo('exit');
		this.capture('love-30.png');
	});
	

});	

casper.then(function() {
	this.capture('love-40.png');
	this.click('a.hm_icon');
	this.capture('love-41.png');
});

casper.then(function() {
//	this.capture('love-50.png');
	//for(var i=1; i<=5; i++){    
	var numTimes = 500, count = 501;

	this.repeat(numTimes, function() {
		//this.thenEvaluate(function(count) {
		//	nextPage(count);
		//}, ++count);
		this.wait(2000,function(){
			this.echo('I like '+count);
			this.waitForSelector('a.gbut_grd_green.gnl_but36.w190', function(){
				this.click('a.gbut_grd_green.gnl_but36.w190');
			});
			
			this.capture('love='+count+'.png');
			++count;
		});

		
		
	});
	
});



//casper.then(function() {
//	this.capture('love-50.png');
//	this.waitForSelector('a.gbut_grd_green.gnl_but36.w190', function(){
//		this.echo('I like it');
//		this.click('a.gbut_grd_green.gnl_but36.w190');
//		this.capture('love-51.png');
//	});
//	
//	
//});
//
//casper.then(function() {
//	this.capture('love-60.png');
//	this.waitForSelector('a.gbut_grd_green.gnl_but36.w190', function(){
//		this.echo('I like it');
//		this.click('a.gbut_grd_green.gnl_but36.w190');
//		this.capture('love-61.png');
//	});
//});


casper.then(function() {
	
	//body > div.height_full > div.head > div > ul > li:nth-child(1) > a
	
	this.echo('prefinal');
	this.wait(5000,function(){
		this.echo('final');
		this.capture('love-99.png');
	});

});	

	 
	//this.sendKeys('#dlg_login_log','sergvcx@mail.ru');
	//this.sendKeys('#dlg_login_pas','hifly1');
	//dlg_login > ul.reset.line.lab_w43 > li:nth-child(4) > div > button
	//this.capture('love-11.png');
	
//});


casper.run();