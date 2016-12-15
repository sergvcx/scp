phantom.injectJs('settings.js');
var casper = require('casper').create();
var fs = require('fs');
casper.userAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X)');


//casper.start('http://ya.ru', function() {
casper.start(metro, function Open() {
	phantom.outputEncoding="cp866";
    this.echo(this.getTitle());
	this.capture('metro0.png');
});



casper.then(function Enter() {
	
	
	this.capture('metro0.png');
	fs.write('metro0.html', this.getHTML() , 'w');
	
	//	<a href="#" id="btnStart" class="preloader"></a>
	// <button id="btnDefault" type="submit" class="btn">Войти в Интернет</button>
	//this.waitForSelector('a.preloader', function(){
	this.waitForSelector('button.btn', function(){
		this.capture('metro1.png');
		//this.click('a.preloader');
		this.click('button.btn');
		this.capture('metro2.png');
		this.echo('Войти');
		fs.write('metro1.html', this.getHTML() , 'w');
	},function(){
		this.echo('ERROR:No selector');
	}
	,10000);
	
	this.then(function(){
		this.echo('Wellcome');
		this.capture('metro2.png');
		fs.write('metro2.html', this.getHTML() , 'w');
		this.wait(3000,function(){
			this.capture('metro3.png');
			fs.write('metro3.html', this.getHTML() , 'w');
		});
	});
	
	
	
	
},10000);

//casper.start('http://ya.ru', function() {
//casper.start('http://ya.ru', function test() {
//	phantom.outputEncoding="cp866";
 //   this.echo(this.getTitle());
//	this.capture('metro5.png');
//	fs.write('metro5.html', this.getHTML() , 'w');
//});

casper.run();