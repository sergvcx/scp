var casper = require('casper').create();

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
			'login': 'sergvcx@mail.ru', 
			'password': 'hifly1'},
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
	this.echo('preexit');
	this.wait(5000,function(){
		this.echo('exit');
		this.capture('love-30.png');
	});

});	

	 
	//this.sendKeys('#dlg_login_log','sergvcx@mail.ru');
	//this.sendKeys('#dlg_login_pas','hifly1');
	//dlg_login > ul.reset.line.lab_w43 > li:nth-child(4) > div > button
	//this.capture('love-11.png');
	
//});


casper.run();