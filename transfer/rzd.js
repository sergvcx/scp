phantom.injectJs('settings.js');
//var casper = require('casper').create();


var casper = require('casper').create({
  verbose: true,
  logLevel: "error",
  //pageSettings: {
    //userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.97 Safari/537.11"
	//userAgent: 'Mozilla/6.0 (compatible; MSIE 6.0; Windows NT 5.1)'
  //}
});

casper.userAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X)');
//debug
//info
//warning
//error

function getRandomIntFromRange(min, max) {
  return Math.round(Math.random() * (max - min)) + min;
}

var fs = require('fs');
var xmlfile='69.xml';
var system = require('system');
//casper.userAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X)');
//casper.userAgent('Mozilla/6.0 (compatible; MSIE 6.0; Windows NT 5.1)');
//casper.options.viewportSize = {width: 1600, height: 950};
casper.options.viewportSize = {width: 1300, height: 950};
casper.start('https://rzd.ru/timetable/logon/ru', function() {
	phantom.outputEncoding="cp866";
    this.echo(this.getTitle());
	this.capture('badoo-start.png');
	
	
});

casper.then(function Login() {
	this.echo('Login...');
	this.capture('rzd-01-login.png');
	//<a href="https://badoo.com/signin/" class="link">Sign in</a>
	
	
	this.waitForSelector('#selfcare_logon_form', function(){
		this.echo('login form  is dettected');
		//this.click('a.link[href="https://badoo.com/signin/"]');
		//this.echo('signin is clicked');
	});
	
	//#selfcare_logon_form
	this.waitForSelector('#selfcare_logon_form', function(){
		this.echo('form is dettected');
		this.fill('#selfcare_logon_form', {
			'j_username': 'sergvcx',  
			'j_password': 'sergvcx'},
			true);
		this.echo('form is filled');
	});
	
	this.waitForSelector('#new_ticket_form > div:nth-child(1)', function(){
		this.capture('rzd-01-accepted.png');
		this.echo('login accepted');
		this.echo('filling from to...');
		this.sendKeys('#name0', 'МОСКВА');
		this.sendKeys('#name1', 'САНКТ-ПЕТЕРБУРГ');
		this.sendKeys('.detailsItem > input:nth-child(3)','09.12.2016');
		this.click('#Submit');
	});

	this.wait(4000,function(){
		this.capture('sleep.png');
		this.echo('sleep 4 sec');
	});
	
	//this.waitForSelector('#Part0', function(){
	this.waitForSelector('div.j-trains-count:nth-child(4)', function(){
		this.capture('rzd-02-variants.png');
		this.echo('filled');
		this.echo('variants apeared');
		var result=this.fetchText('div.j-trains-count:nth-child(4)');
		this.echo(result); // Показано 25 из 25 вариантов по прямому маршруту
		
		
		
		//this.querySelector('Поезд дальнего следования № 120В');
		
		
	});
	
	this.waitForSelector('div.j-trains-count:nth-child(4)', function(){
		this.capture('rzd-03-variants.png');
		this.echo('queryy');
		

	
	});
	
	
});

casper.then(function() {
	this.echo('THEN');
	//var nodes = this.evaluate(function(){
		this.echo('eval'); 
		//var arr = document.querySelectorAll('div');
		//var arr = document.getElementById('container');
		//this.echo('eval2'); 
		
		//var listItems = this.evaluate(function () {
		//	var arr=document.querySelectorAll('div');
		//	this.echo('***');	
		//	this.echo(arr.length);
		//});
		
		this.echo('===');
		
		var elements = this.getElementsInfo('.trlist__cell-pointdata__tr-num.train-num-0');
		//var elements = this.getElementsInfo('.trlist__trlist-row.trslot');
		
		//elements.forEach(function(element){
			//if (element.attributes["data-whatever"] === element.html) {
			//	casper.echo("data attribute and content are exactly equal");
			//} else {
			//	casper.echo("data attribute and content are different");
			//}
			//this.echo(element.text);
		//});
		this.echo(elements.length);
		for (var i = 0; i < elements.length; i++) { 
			var train = elements[i]; 
			this.echo('----------------------------');
			this.echo(i);
			//this.echo(train.children);
			this.echo(train.innerText);
			
			//var trainNo=train.text.replace("№ ","");
			//var trainNo=train.childeNodesren[2].children[0].text.replace("№ ","");
			//var trainNo=train.childNodes[2].childNodes[0].text.replace("№ ","");
			//this.echo(trainNo); 
			//this.echo(i);//train.length); 
			//if (trainNo=='120В') {
			//	this.info('found');
			//	this.click(train);
			//	break;
			//}
			//	console.log(err.textContent);
		}
	//});
});

casper.then(function() {
	this.waitForSelector('#continueButton', function(){
		this.capture('rzd-04-contine.png');
		this.echo('continue');
	
	});
});

function ClickPeopleNear() {
	this.capture('badoo-03-submit.png');
	this.echo('Waiting autorization...');

	this.wait(4000,function(){
		this.capture('badoo-05.png');
		this.echo('Login...end');
	});
	
	//<a href="/search" class="b-link app" rel="search"></a>
	this.waitForSelector('a.b-link.app[href="/search"]', function(){
		this.echo('FOUND a.b-link.app href=/search');
		this.click('a.b-link.app[href="/search"]');
		this.echo('CLICKED a.b-link.app href=/search');
	});
	
	this.wait(4000,function(){
		this.capture('badoo-06.png');
		this.echo('Near...end');
	});
	
	this.waitForSelector('a.b-link.user-card__link.app.js-folders-user-profile-link', function(){
		this.echo('FOUND a.b-link user-card__link app js-folders-user-profile-link');
		this.click('a.b-link.user-card__link.app.js-folders-user-profile-link');
		this.echo('CLICKED a.b-link user-card__link app js-folders-user-profile-link');
	});
	
	this.wait(1000,function(){
		this.capture('badoo-07.png');
		this.echo('in people...end');
	});
}

casper.then(ClickPeopleNear);

casper.then(function CollectPeople() {
	//<div class="user-card__img"> 
	//	<img src="//pcache-pv-eu1.badoocdn.com/p54/30114/8/6/9/533848383/d1326913/t1473584621/c_TvNxLcmXNqRBpsEbHtpMe6j9ih9606t3GZreddNvgJM/1326913977/dfs_180x180/sz___size__.jpg?cf=260%2C90%3B580%2C410&amp;t=30.1.0.00&amp;id=1326913977" width="190" height="190">  
	//	<div class="photo-counter"> 
	//		<i class="icon icon--white">
	//			<svg class="icon-svg"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-camera-contour"></use></svg>
	//		</i> 
	//	<span class="small">1</span> </div>  </div>
	//this.waitForSelector('div.user-card__img', function(){
	//	this.capture('FOUND badoo-07.png');
	//	this.click('div.user-card__img');
	//	this.capture('CLICKED badoo-07.png');
	//});
	//<a href="/profile/0528581231?from=search&amp;folder=25&amp;section_id=3&amp;p=1" class="b-link user-card__link app js-folders-user-profile-link" target="_blank" rel="profile-view"></a>
	var counter=1000;
	var numTimes=1000;
	
	
	//this.waitForSelector('span.b-link.js-next-button', function(){
	//	this.click('span.b-link.js-next-button');
	//});
	
	if (fs.exists(xmlfile)){
		fs.remove(xmlfile);
	}
	fs.write(xmlfile,'<?xml version="1.0" ?>\n','a');
	fs.write(xmlfile,'<?xml-stylesheet type="text/xsl" href="badoo.xsl"?>\n','a');
	fs.write(xmlfile,'<table name="badoo">\n','a');
  
	this.repeat(numTimes, function() {
		//<span class="b-link js-next-button"></span>	
		var delay = getRandomIntFromRange(1000, 5000);
		 
		this.waitForSelector('span.b-link.js-next-button', function(){
			this.capture('badoo='+counter+'.png');
			var imgPreview='preview-'+counter+'.png';
			this.echo(imgPreview);
			this.capture(imgPreview, {
				top: 110,
				left: 334,
				width: 900,
				height: 150
			});
			//<span class="ellipsis">Кати</span>
			//<h1 class="profile-header__name"> <span class="ellipsis">Наталья</span> <span class="profile-header__age">, 29</span> <span class="b-link js-profile-header-name"></span> </h1>
			var name=this.fetchText('h1.profile-header__name span.ellipsis');
			//<span class="profile-header__age">, 28</span>
			var age=this.fetchText('span.profile-header__age').replace(",","");
			
			//<div class="scale scale--sm js-profile-score" data-score="8.65" data-delimiter="," data-digits-count="2" data-line-width="7" data-size="70" data-style="LIGHT" data-timing="0" data-background="https://badoocdn.com/v2/-/-/i/hotornot_v2/ui/scale.9.png"><canvas width="70" height="70" class="scale-display " style="width: 70px; height: 70px;"></canvas><b class="scale-value no-dps">8,65</b></div>
			
			var score=this.getElementAttribute('div.scale.scale--sm.js-profile-score','data-score');
			if (score==null){
				score="10";
			}

			this.echo(score);
			var url=this.getCurrentUrl();
			
			//<div class="section-editable">  Хочет пойти на свидание с мужчиной в возрасте от 22 до 37   </div>
			var want=this.fetchText('div.section-editable').replace(/&/g,"*").replace(/"/g,"'");
			//<span class="profile-section__txt">Только живое общение. Дублирую еще раз: Если Вы не готовы к общению вне сайта, писать мне совершенно не стоит) Только русские. Выше 184 см) (Без обид, мой рост 180) P. S. Не нужно придумывать, что Вы из Москвы, если находитесь в Пскове и утверждать, что Ваш Range Rover разбился вчера "под списание". Если Вы не знаете, где находится Моховая, Никитская или произносите ЦАО с ударением на последнюю букву, а еще искажаете звук "г" и продолжаете утверждать, что Вы-житель столицы, закройте этот профиль)))) Закончила МГИМО, учусь в аспирантуре МГУ, люблю охоту, спорт, Петербург, Сочи, квадрики, литературу, рамные автомобили, гироскутер, путешествия и основную сцену Александринки☺ Не люблю пафос, а также ложь и хитрость. ☺Остальное в Инста: Fourth_estate</span>
			var info =this.fetchText('span.profile-section__txt').replace(/&/g,"*").replace(/"/g,"'");

			if (score>6.2){
				fs.write(xmlfile,'<girl img="'+imgPreview+'"  name="'+name+'"  age="'+age+'" score="'+score+'" url="'+url+'" want="'+want+'">\n','a');
				fs.write(xmlfile,info,'a');
				fs.write(xmlfile,'</girl>\n','a');
			}
			
			if (score!=10){
				if (score>6.5){
					this.echo("I like girl");
					//<span class="b-link js-profile-header-vote" data-choice="yes"></span>		
					this.click('span.b-link.js-profile-header-vote[data-choice="yes"]');
				}
			}
			
			
			this.echo('FOUND span.b-link.js-next-button');
			this.click('span.b-link.js-next-button');
			this.echo('CLICKED span.b-link.js-next-button');
			++counter;
		}, function(){
			//<form method="post" action="" class="js-captcha-form"> <div class="simple-promo__content"> <h1>РџРѕРґС‚РІРµСЂРґРёС‚Рµ, С‡С‚Рѕ РІС‹ РЅРµ СЂРѕР±РѕС‚, Рё РІРІРµРґРёС‚Рµ СЃР»РѕРІРѕ СЃ РєР°СЂС‚РёРЅРєРё</h1>  <div class="simple-promo-captcha"> <div class="checkcode js-error-wrap js-captcha-code"> <label for="checkcode" class="checkcode__img"><img id="check_code_img" src="https://badoo.com/reg_code.phtml?rt=o%3AHPdx6u2CDP9o&amp;reload=1&amp;u=captcha_7&amp;f=gif&amp;r=328&amp;t=1.30.1.0.00.340" width="125" height="32" alt=""></label> <input type="text" name="checkcode" id="checkcode" class="input checkcode__input js-captcha-input" placeholder="Р’РІРµРґРёС‚Рµ СЃРёРјРІРѕР»С‹" value="" tabindex="" autocomplete="off">  <div class="nowrap input-hint"> <i class="icon input-hint__icon"> <svg class="icon-svg"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-refresh"></use></svg> <span class="b-link js-reset-captcha"></span> </i> <span class="grey p-link">РџРѕРєР°Р·Р°С‚СЊ РґСЂСѓРіРёРµ СЃРёРјРІРѕР»С‹</span> </div> </div> </div> </div> <div class="simple-promo__buttons"> <button type="submit" class="btn btn--blue"> <span class="btn-txt">РџСЂРѕРґРѕР»Р¶РёС‚СЊ</span> </button> </div> </form>
			fs.write('WARING:'+counter+'.html',this.getHTML() , 'w');
			this.echo('WARNING:'+counter);
			this.capture('waring='+counter+'.png');
			this.waitForSelector('form.js-captcha-form', function(){
				this.capture('captcha.png');
				this.echo('Captcha detected. Open Captcha.png and enter checkcode:');
				var Captcha = system.stdin.readLine();
				this.fill('form.js-captcha-form', {
					'checkcode': Captcha
					},true);
				this.wait(1000,function(){
					this.echo('Captcha entered');});
			}, ClickPeopleNear,
				//function(){
				//this.capture('Error='+counter+'.png');
				//fs.write('ERROR-WTF.html',this.getHTML() , 'w');
				//div class="ovl-frame js-ovl-wrap"><div class="js-ovl-content"> <div class="ovl-body"> <div class="ovl-content"> <p class="x-large">Этот аккаунт используется на другом устройстве.<br>Нажмите «Продолжить», если это одно из ваших устройств, или «Отключить», чтобы выйти из своего аккаунта на другом устройстве.</p> </div> <div class="ovl-buttons"> <div class="btn btn--blue"> <span class="btn-txt">Продолжить</span> <span class="b-link js-continue"></span> </div> <div class="btn btn--white"> <span class="btn-txt">Отключить</span> <span class="b-link js-deactivate"></span> </div> </div>
				//this.echo('WTF');
				//ClickPeopleNear();
				//}
			3000);
		}, 
		3000);
		this.wait(delay,function(){
			this.capture('badoo='+counter+'=.png');
			this.echo('sleept='+delay);
		});
	});
});

casper.then(function Finish() {
	fs.write(xmlfile,'</table>','a');
});

casper.run();
