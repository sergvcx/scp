phantom.injectJs('settings.js');
var casper = require('casper').create();
var fs = require('fs');
casper.userAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X)');
//casper.userAgent('Mozilla/6.0 (compatible; MSIE 6.0; Windows NT 5.1)');
casper.start('http://badoo.com/search', function() {
	phantom.outputEncoding="cp866";
    this.echo(this.getTitle());
	this.capture('badoo-start.png');
});

casper.then(function Enter() {
	this.echo('Enter...');
	//<a href="https://badoo.com/ru/signin/?f=top" class="btn btn--sm btn--white"> <span class="btn-txt">Войти</span> </a>
	//this.waitForSelector('a.btn.btn--sm.btn--white', function(){
	//	this.capture('badoo-00.png');
	//	this.click('a.btn.btn--sm.btn--white');
	//	this.capture('badoo-01.png');
	//});
	//<i class="icon icon--xsm icon--white"><svg class="icon-svg"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-mail-circle"></use></svg></i>
	//<a href="https://badoo.com/signin/" class="b-link"></a>
	this.wait(4000,function(){
		this.echo('Enter...end');
	});
	
	//<div class="btn btn--sm btn--vdgrey btn--social external-provider-extended"> 
	//	<i class="icon icon--xsm icon--white">
	//		<svg class="icon-svg">
	//			<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-mail-circle"></use>
	//		</svg>
	//	</i> 
	//	<span class="btn-txt">Войти</span> 
	//	<a href="https://badoo.com/signin/" class="b-link"></a> 
	//</div>
	
	// <a href="https://badoo.com/dating/page-3/" class="b-link js-pages"></a>
	this.waitForSelector('i.icon.icon--xsm.icon--white', function(){
		this.echo('click...');
		this.capture('badoo-00.png');
		
		//this.click('i.icon.icon--xsm.icon--white');
		//this.click('div.btn.btn--sm.btn--vdgrey.btn--social.external-provider-extended');
		//this.click('#https://badoo.com/signin.a'); - CRASH
		//this.click('a[href="https://badoo.com/signin/"]');  - no emotions
		//this.click("a[href='https://badoo.com/signin/']"); // - no emotions
		//this.click('a[href^="https://badoo.com/signin"]'); // - no emotions
		//this.click("a[href^='https://badoo.com/signin']"); // - no emotions
		//this.click('div> span'); // - no emotions 
		//this.click('div.sidebar-content.js-sidebar-wrapper.js-search-people-wrapper > div > div.scroll_ > div > div.js-scroller > div.sidebar-content_.js-nav.js-search-people-nav > div > div.js-sidebar-user > div > div.sidebar-nav__buttons > div > div.btn.btn--sm.btn--vdgrey.btn--social.external-provider-extended > a'); // - no emotions
		//this.click('#sidebar > div.sidebar-content.js-sidebar-wrapper.js-search-people-wrapper > div > div.scroll_ > div > div.js-scroller > div.sidebar-content_.js-nav.js-search-people-nav > div > div.js-sidebar-user > div > div.sidebar-nav__buttons > div > div.btn.btn--sm.btn--vdgrey.btn--social.external-provider-extended > span'); // NO EMOTIONS
		
		//this.clickLabel('Войти'); // - no emotions
		//this.clickLabel('Войти','span.btn-txt'); // crash
		//this.clickLabel('Войти','span'); // crash
		//this.clickLabel('Войти','div span'); // crash
		
		
		var x = require('casper').selectXPath;
		//this.click(x("//span[contains(text(),'Войти')]")); // - no emotions
		//this.click(x('//span[contains(text(),"Войти")]')); // - no emotions
		//this.click(x('//span[text()="Войти"]')); // crash
		//this.click(x('//span[text()="123"]')); // crash
		// 
		this.capture('badoo-01.png');
		this.echo('click...end');
	});
	this.wait(4000,function(){
		this.capture('badoo-02.png');
	});
});

casper.then(function Login() {
	this.echo('Login...');
	this.capture('badoo-03-login.png');
	this.wait(4000,function(){
		this.capture('badoo-04.png');
		this.echo('Login...end');
	});
	//this.waitForSelector('form', function(){
	//	this.fill('form.no_autoloader.form.js-signin', {
	//		'email': email, 
	//		'password': password},
	//		true);
	//	this.evaluate(function () {
	//		$('form.no_autoloader.form.js-signin').submit();
	//	});
	//	this.wait(2000,function(){});
	//	//this.echo('submit');
	//});
	var fname = '8888.html';
	fs.write(fname, this.getHTML() , 'w');

});

//casper.start('http://badoo.com/search', function() {
	//phantom.outputEncoding="cp866";
    //this.echo(this.getTitle());
	//this.capture('badoo-start.png');
//});


casper.then(function Submit() {
	this.capture('badoo-03-submit.png');
	this.echo('Waiting autorization...');
	//<a href="/search" class="b-link app" rel="search"></a>
	//<b class="sidebar-menu__item-txt sidebar__el-hidden">Люди рядом</b>
	//<span class="photo-gallery__link photo-gallery__link--next js-gallery-next"> <i class="icon icon--white photo-gallery__arrow photo-gallery__arrow--right"
	//<span class="b-link js-profile-header-vote" data-choice="yes"></span>
	//this.waitForSelector('span.b-link.js-profile-header-vote', function(){
this.waitForSelector('b.sidebar-menu__item-txt.sidebar__el-hidden', function(){
//		this.echo('submited');
	//	this.capture('badoo-04-after-submit.png');
		//<b class="sidebar-menu__item-txt sidebar__el-hidden">Люди рядом</b>
		//<div class="sidebar-menu__item search_"> 
		//  <i class="icon icon--xsm"> 
		//this.click('b.sidebar-menu__item-txt.sidebar__el-hidden');
		//this.click('div.sidebar-menu__item.search_.active'); // div=error
		//this.click('svg.icon-svg');//"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-sidebar-nearby"></use></svg>
		//<b class="sidebar-menu__item-txt sidebar__el-hidden">Люди рядом</b>
		//this.click('svg.icon-svg');//"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-sidebar-nearby"></use></svg>
		//<div class="sidebar-menu__item search_ active"> <i class="icon icon--xsm"> <svg class="icon-svg"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-sidebar-nearby"></use></svg> <a href="/search" class="b-link app" rel="search"></a> </i> <b class="sidebar-menu__item-txt sidebar__el-hidden">Люди рядом</b> </div>
		//this.click('i.icon.icon--xsm');
		
	},function(){
		//this.echo('TIMEOUT: submit ');
		//this.capture('badoo-05-timeout-submit.png');
	},2000);
	
	//<a href="/search?page=2" class="b-link js-pages app" rel="search"></a>   слудующие
	this.waitForSelector('a.b-link.js-pages.app', function(){
		this.echo('Next loaded');
		this.capture('badoo-06-next.png');
	},function(){
		this.echo('TIMEOUT: next ');
		this.capture('badoo-07-timeout-submit.png');
	},10000);
	
	
	
});




casper.run();
