var casper = require('casper').create();
casper.start('http://google.fr/');

console.log('started');
casper.capture('g.png');

casper.thenEvaluate(function(term) {
	
	console.log('started1');
    document.querySelector('input[name="q"]').setAttribute('value', term);
    document.querySelector('form[name="f"]').submit();
	casper.capture('g1.png');
}, 'CasperJS2');

casper.then(function() {
	console.log('started2');
	this.capture('g2-before.png');
    // Click on 1st result link
    this.click('h3.r a');
	this.capture('g2-after.png');
	
});

casper.then(function() {
	this.capture('g3-before.png');
	console.log('started3');
    // Click on 1st result link
    this.click('h3.r a',10,10);
	this.capture('g3-after.png');
});

casper.then(function() {
	console.log('started4');
    // Click on 1st result link
    this.click('h3.r a',"50%","50%");
	casper.capture('g4.png');
});


casper.then(function() {
    console.log('clicked ok, new location is ' + this.getCurrentUrl());
});


casper.run();