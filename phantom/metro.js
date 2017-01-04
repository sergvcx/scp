phantom.injectJs('settings.js');
var casper = require('casper').create();
var fs = require('fs');
//casper.userAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X)');
casper.userAgent('Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36');


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
		this.echo('Входим...');
	},function(){
		this.echo('ERROR:No selector');
	}
	,10000);
	
	
	
},10000);

casper.then(function(){
	this.echo('Wellcome');
	this.echo('Waitinf for span.icon.icon-troika...');
	fs.write('metro2.html', this.getHTML() , 'w');
	this.capture('metro2.png');
	this.waitForSelector('span.icon.icon-troika', function(){
		this.echo('Fuck of metro adverstment - Ready !');
		//this.wait(3000,function(){
		this.capture('metro3.png');
		fs.write('metro3.html', this.getHTML() , 'w');
	},
	function(){
		this.echo('Not found  !');
		this.capture('metro-03-not found.png');
		fs.write('metro-03.html', this.getHTML() , 'w');
	},10000
	);
});	


casper.run();