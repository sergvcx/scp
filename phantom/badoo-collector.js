phantom.injectJs('settings.js');
var casper = require('casper').create();
var fs = require('fs');
casper.userAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X)');
//casper.userAgent('Mozilla/6.0 (compatible; MSIE 6.0; Windows NT 5.1)');
casper.start('http://badoo.com', function() {
	phantom.outputEncoding="cp866";
    this.echo(this.getTitle());
	this.capture('badoo-start.png');
});

casper.then(function Enter() {
	this.echo('Enter...');
	//<a href="https://badoo.com/ru/signin/?f=top" class="btn btn--sm btn--white"> <span class="btn-txt">Войти</span> </a>
	this.waitForSelector('a.btn.btn--sm.btn--white', function(){
		this.capture('badoo-00.png');
		this.click('a.btn.btn--sm.btn--white');
		this.capture('badoo-01.png');
	});
});

casper.then(function Login() {
	this.echo('Login...');
	this.capture('badoo-02-login.png');
	this.waitForSelector('form', function(){
		this.fill('form.no_autoloader.form.js-signin', {
			'email': email, 
			'password': password},
			true);
		this.evaluate(function () {
			$('form.no_autoloader.form.js-signin').submit();
		});
		//this.echo('submit');
	});
	
});

casper.then(function Submit() {
	this.capture('badoo-03-submit.png');
	this.echo('Submit...');
	//<a href="/search" class="b-link app" rel="search"></a>
	//<b class="sidebar-menu__item-txt sidebar__el-hidden">Люди рядом</b>
	//<span class="photo-gallery__link photo-gallery__link--next js-gallery-next"> <i class="icon icon--white photo-gallery__arrow photo-gallery__arrow--right"
	this.waitForSelector('span.photo-gallery__link.photo-gallery__link--next.js-gallery-next', function(){
		this.echo('submited');
		this.capture('badoo-04-after-submit.png');
	},function(){
		this.echo('TIMEOT: submit ');
		this.capture('badoo-05-timeout-submit.png');
	},20000);
	
});


casper.then(function() {
	var numTimes = 5000, count = 1;
	var x = require('casper').selectXPath;
	this.echo('..');
	//this.waitTimeOut(2000);
	var novoice=false;
	this.repeat(numTimes, function() {
		this.echo('-----------');
		this.echo('count='+count);
		if (!this.exists('html.js.safari.ovl-fading')){
			this.echo('I like '+count);
			this.capture('badoo='+count+'.png');
			var fname='page='+count+'.html';
			fs.write(fname, this.getHTML() , 'w');
		}//}
		// проверяем второй раз , что не появился оверлей
		//if (!this.exists('div.ovl-frame.js-ovl-wrap')){
		if (!this.exists('html.js.safari.ovl-fading')){
			this.click('span.b-link.js-profile-header-vote');
			++count;
			this.echo('Zzzz...');
			this.wait(1000,function(){
				this.echo('Wakeup...');
			});
		}
		else {
		//this.waitForSelector('div.ovl-frame.js-ovl-wrap', 
			this.echo('Overlay detected='+count);	
			this.capture('Overlay10='+count+'.png');
			//this.capture('Overlay11='+count+'.png');
			//this.capture('Overlay12='+count+'.png');
			//this.waitWhileVisible('div.ovl-frame.js-ovl-wrap', 
			
			// Пусть вас видят чаще
			this.waitForSelector('span.p-link.js-ovl-close', 
				function(){
					this.echo('span.p-link.js-ovl-close SELECTOR='+count);	
					if (this.exists(x('//span[text()="Нет, спасибо"]'))) {
						this.echo('Нет, спасибо='+count);	
						this.click('span.p-link.js-ovl-close');
					}
				},
				function() {
					this.echo('No 3000='+count);
					fs.write('page=='+count+'.html', this.getHTML() , 'w');
				},
				3000
			);
			
			// <i class="icon icon--white js-ovl-close">  [Close icon]
			this.waitForSelector('i.icon.icon--white.js-ovl-close', 
				function () {
					this.echo('i.icon.icon--white.js-ovl-close SELECTOR='+count);	
					if (this.exists(x('//p[text()="У вас закончились голоса. Хотите проголосовать ещё 600 раз сегодня?"]'))) {
						--count;
						this.echo('У вас закончились голоса='+count);	
						this.echo('ZZZzzzzz....10 min, --count='+count);	
						
						this.wait(60000,
							function(){	
								this.click('i.icon.icon--white.js-ovl-close');
							}
						);
					}
					// <h1>Повысьте свои шансы!</h1>
					else if (this.exists(x('//h1[text()="Повысьте свои шансы!"]'))) {
						this.echo('Повысьте свои шансы! ='+count);	
						this.click('i.icon.icon--white.js-ovl-close');
					}
					else if (this.exists(x('//h1[text()="Нравится Badoo?"]'))) {
						this.capture('Nra='+count+'.png');
						this.echo('Нравится Badoo! ='+count);	
						this.click('i.icon.icon--white.js-ovl-close');
					}
					else {
						this.capture('Hren='+count+'.png');
						this.echo('У вас какая то хрень='+count);
						this.click('i.icon.icon--white.js-ovl-close');
					}
				},
				function() {
					this.echo('No 3001='+count);
					fs.write('page==='+count+'.html', this.getHTML() , 'w');
			
				},
				3001
			);
			
			this.waitWhileVisible('div.ovl-frame.js-ovl-wrap',
				function() {
					this.echo('Overlay Disapeared='+count);
					this.capture('Disapeared='+count+'.png');
					this.wait(2000,function(){'Sleep after disapeared'});
				},
				function() {
					this.echo('PROMBLEM: Overlay dows not disapeared!',+count);
					fs.write('page='+count+'.html', this.getHTML() , 'w');
					this.capture('Error10='+count+'.png');
					this.capture('Error11='+count+'.png');
					this.capture('Error12='+count+'.png');
				},
				10000
			);
		}
		
	});
	
});

casper.run();


//	//<span class="p-link js-ovl-close">Нет, спасибо</span>
			//	if (this.exists('span.p-link.js-ovl-close')) {
			//		if (this.exists(x('//span[text()="Нет, спасибо"]'))) {
			//			this.echo('Нет, спасибо='+count);	
			//			this.click('span.p-link.js-ovl-close');
			//			this.waitUntilVisible('span.p-link.js-ovl-close', function() {
			//				this.echo('Нет, спасибо Disapeared!');
			//			});
            //
			//			//this.wait(3000,function(){
			//			//	this.echo('Closed ovl in 3 sec');	
			//			//});
			//		}
			//	}
            //
			//	if (this.exists('i.icon.icon--white.js-ovl-close')) {
			//		if (this.exists(x('//p[text()="У вас закончились голоса. Хотите проголосовать ещё 600 раз сегодня?"]'))) {
			//			this.echo('У вас закончились голоса='+count);	
			//			this.echo('ZZZzzzzz....10 min');	
			//			this.click('i.icon.icon--white.js-ovl-close');
			//				this.wait(600000,function(){
			//				this.echo('Closed ovl in 10 min');	
			//			});
			//		}
			//		// <h1>Повысьте свои шансы!</h1>
			//		else if (this.exists(x('//h1[text()="Повысьте свои шансы!"]'))) {
			//			this.echo('Повысьте свои шансы! ='+count);	
			//			this.click('i.icon.icon--white.js-ovl-close');
			//		}
			//		else {
			//			this.echo('У вас какая то хрень='+count);
			//			this.click('i.icon.icon--white.js-ovl-close');
			//		}
			//		this.wait(3000,function(){
			//			this.echo('Closed ovl in 3 sec');	
			//		});
			//	}
            //
			//	//<div class="btn btn--blue"> 
			//	//	<span class="btn-txt">Продолжить</span> 
			//	//	<span class="b-link js-continue"></span> 
			//	//</div>
			//	
		    //
			//	//this.waitForSelector('i.icon.icon--white.js-ovl-close', 
			//	//	function(){
			//	//		this.capture('overlay='+count+'.png');
			//	//		var x = require('casper').selectXPath;
			//	//		
			//	//		if (this.exists(x('//p[text()="У вас закончились голоса. Хотите проголосовать ещё 600 раз сегодня?"]'))) {
			//	//			this.echo('У вас закончились голоса='+count);	
			//	//			this.echo('ZZZzzzzz....');	
			//	//			this.wait(60000,function(){
			//	//				this.echo('Wake up!');	
			//	//			});
			//	//		}
			//	//		else {
			//	//			this.echo('У вас какая то хрень='+count);
			//	//		}
			//	//		this.click('i.icon.icon--white.js-ovl-close');
			//	//		//this.echo('Повысьте свои шансы! '+count);
			//	//	}, 
			//	//	function (){
			//	//		this.echo('I like '+count);
			//	//		this.capture('badoo='+count+'.png');
			//	//		this.click('span.b-link.js-profile-header-vote');
			//	//		++count;
			//	//		//this.echo('my timeout');
			//	//	},1000);
			//	////this.echo('end wait for overlay..');
			//	//else {
			//	//}
			//});
			//this.then(function() {
			//	this.capture('badoo='+count+'.png');
			//	this.echo('I like '+count);
			//	this.capture('badoo='+count+'.png');
			//	this.click('span.b-link.js-profile-header-vote');
			//	++count;
			//});
			//this.echo('end wait for love..');
			