phantom.injectJs('rzd-ini.js');
//var casper = require('casper').create();


function reportErrors(f) {
  var ret = null;
  try {
    ret = f();
  } catch (e) {
    casper.echo("ERROR: " + e);
    casper.exit();
  }
  return ret;
}

var casper = require('casper').create({
  verbose: true,
  logLevel: "error",
  
  //pageSettings: {
    //userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.97 Safari/537.11"
	//userAgent: 'Mozilla/6.0 (compatible; MSIE 6.0; Windows NT 5.1)'
  //}
});

//casper.userAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X)');
casper.userAgent('Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36');

casper.options.waitTimeout = 20000;
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
// <a class="orng" href="https://pass.rzd.ru/main-pass/secure/ru">Вход</a>
//casper.start('https://rzd.ru/timetable/logon/ru', function() {
	//casper.start('https://pass.rzd.ru/main-pass/secure/ru', function() {
	casper.start('http://pass.rzd.ru/main-pass/public/ru', function() {
	phantom.outputEncoding="cp866";
    this.echo(this.getTitle());
	this.capture('rzd-00-start.png');
});
/*
casper.then(function Login() {
	this.echo('[1] Waiting for login page...');
	this.capture('rzd-01-login-waiting.png');
	//<a href="https://badoo.com/signin/" class="link">Sign in</a>
	
	
	//#selfcare_logon_form
	this.waitForSelector('#selfcare_logon_form', function(){
		this.echo('login form  is detected');
		this.fill('#selfcare_logon_form', {
			'j_username': username,  
			'j_password': password},
			true);
		this.echo('form is filled');
	});
});
*/
casper.then(function() {
	this.echo(' [6] wait For continueButton...');
	//this.waitForSelector('#continueButton > span.btn-ie-mid', function(){
	//	this.capture('rzd-06-contine.png');
	//	this.click('#continueButton > span.btn-ie-mid');
	//	this.echo('Wagon continue detected! clicked.');
	//
	//},function(){
	//	this.echo('[ERROR-6] Timeout ');
	//	this.capture('rzd-06-timeout.png');
	//	fs.write('rzd-06-timeout.html',this.getHTML() , 'w');
	//	this.exit();
	//},20000);
});


casper.then(function KudaGo() {
	this.echo('[2] Waiting kuda-go form page ...');
	this.capture('rzd-02-aenter.png');
	//this.waitForSelector('#new_ticket_form > div:nth-child(1)', function(){
	this.waitForSelector('#tab0_Output', function(){
		this.echo('Kuda-go form page is detected!');
		this.sendKeys('#name0', departure);
		//this.page.sendEvent("keypress", casper.page.event.key.Tab);
		this.sendKeys('#name1', arrival);
		//this.sendKeys('input.jroute-field.box-form__input.gradient','БЕРЕЩИНО');
		
		//this.page.sendEvent("keypress", casper.page.event.key.Tab);
		this.wait(4000,function(){
			var element = this.getElementInfo('#date0');
			this.echo(this.getElementAttribute('#date0', 'class'));
			//this.echo(element.text);
			this.echo(element);
			this.capture('sleep.png');
			this.echo('sleep 4 sec in date');
			this.click('#date0'); // Обязатьлено
			this.page.sendEvent("keypress", this.page.event.key.Backspace);
			this.page.sendEvent("keypress", this.page.event.key.Backspace);
			this.page.sendEvent("keypress", this.page.event.key.Backspace);
			this.page.sendEvent("keypress", this.page.event.key.Backspace);
			this.page.sendEvent("keypress", this.page.event.key.Backspace);
			this.page.sendEvent("keypress", this.page.event.key.Backspace);
			this.page.sendEvent("keypress", this.page.event.key.Backspace);
			this.page.sendEvent("keypress", this.page.event.key.Backspace);
			this.page.sendEvent("keypress", this.page.event.key.Backspace);
			this.page.sendEvent("keypress", this.page.event.key.Backspace);
			
			this.sendKeys('div.box-form__datetime__date-holder',date); // !! works
			
			this.page.sendEvent("keypress", this.page.event.key.Tab);
			this.echo('Kuda-go form filled ');
		});
		
	},function(){
		this.echo('[ERROR-2] Waiting kuda-go form page ');
		this.capture('rzd-02-error.png');
		this.exit();
	},10000);
	this.capture('rzd-02-zexit.png');
});

//casper.then(function a3() {
//	this.wait(4000,function(){
//		this.capture('rzd-02-02.png');
//		this.echo('sleep 4 sec');
//	});
//});
	
casper.then(function KudaGoSubmit() {
	this.echo('[2-1] Waiting kuda-go submit button...');
	this.capture('rzd-02-01-aenter.png');
	//this.waitForSelector('#new_ticket_form > div:nth-child(1)', function(){
	this.waitForSelector('#BoxSubmit', function(){
		this.echo('Kuda-go submit is detected!');
		//*[@id="date0"]
		this.capture('rzd-02-01-button.png');
		this.click('#Submit');
	},function(){
		this.echo('[ERROR-2-1] Waiting kuda-go buttob  ');
		this.capture('rzd-02-1-error.png');
		this.exit();
	},10000);
	this.capture('rzd-02-1-zexit.png');
});

//casper.then(function a3() {
//	this.wait(4000,function(){
//		this.capture('debug.png');
//		this.echo('sleep 4 sec');
//	});
//});
	
casper.then(function a3() {
	this.capture('rzd-03-enter.png');
	this.echo('[3] Waiting for list of trains page ...');
	this.waitForSelector('div.trlist__cell-pointdata__tr-num.train-num-0', function(){
		this.capture('rzd-03-list-of-trains.png');
		this.echo('List of trains page detected');
		var result=this.fetchText('div.j-trains-count.trlist__train-count');
		this.echo(result); // Показано 25 из 25 вариантов по прямому маршруту
		//this.querySelector('Поезд дальнего следования № 120В');
	},function(){
		this.echo('[ERROR-3] Timeout');
		this.capture('rzd-03-tiemout.png');
		fs.write('rzd-03-timeout.html',this.getHTML() , 'w');
		this.exit();
	},20000);
	this.capture('rzd-03-zexit.png');
});

var trains;
casper.then(function a31() {
	this.echo('[31] started')
    var verbs = casper.evaluate(function () {
        return [].map.call(__utils__.findAll('div.trlist__cell-pointdata__tr-num.train-num-0'), function (e) { return e.innerHTML; });
    });
    console.log(JSON.stringify(verbs, null, 2));
	
	trains = this.evaluate(function() {
        //var elements = __utils__.findAll('tr.trlist__trlist-row.trslot');
		var elements = __utils__.findAll('div.trlist__cell-pointdata__tr-num.train-num-0');
		//this.echo(elements.length); //ERROR
        return elements.map(function(e) {
            //return e.getAttribute('href');
			//return e.parentElement.firstElementChild.innerHTML ;
			//return e.parentElement.children[1].innerHTML ;
			return e.innerHTML ;
			
        });
    });
	this.echo('=====================');
	
	
});


casper.then(function a32() {
	this.echo(trains.length);
	//this.echo(trains[0].getAttribute('class'));
	
	console.log(JSON.stringify(trains[0], null, 2));
	this.echo('======== end a31  =============');
	
	this.echo('[32] started');
	//var nodes = this.evaluate(function(){
		//var arr = document.querySelectorAll('div');
		//var arr = document.getElementById('container');
		//this.echo('eval2'); 
		
		//var listItems = this.evaluate(function () {
		//	var arr=document.querySelectorAll('div');
		//	this.echo('***');	
		//	this.echo(arr.length);
		//});
		
		// Usage:
// optionally change the scope as final parameter too, like ECMA5
//var divs = document.querySelectorAll('div');
//[].forEach.call(divs, function(div) {
  // do whatever
  //	this.echo('*');
  //div.style.color = "red";
//});


		

//	var myNodeList = document.querySelectorAll('.trlist__cell-pointdata__tr-num.train-num-0');
	//	forEach(myNodeList, function (index, value) {
		//console.log(index, value); // passes index + value back!
	//	this.echo('*')
	//});

		this.echo('===');
		
		var elements = this.getElementsInfo('.trlist__cell-pointdata__tr-num.train-num-0');
		//var elements = this.getElementsInfo('.trlist__trlist-row.trslot');
		//var elements = this.getElementsInfo('#Part0 > div:nth-child(6) > table > tbody > tr:nth-child(7) > td:nth-child(1)');
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
			//this.echo(train);
			//require('utils').dump(train);
			this.echo(train.text);
			var trainid = i+1;
			//this.echo(train.getAttribute('class')); //ERROR
			//this.echo(train.visible);
			
			
			if (train.text.indexOf(train_id) !== -1){
				
				this.echo('clicked');
				this.echo('clicked'+trainid);
				//this.click('#Part0 > div:nth-child(6) > table > tbody > tr:nth-child(' + trainid +') > td:nth-child(1) > input.j-train-radio');
				var selector = '#Part0 > div:nth-child(6) > table > tbody > tr:nth-child(' + trainid +') > td:nth-child(1) > input.j-train-radio';
				if(!casper.exists(selector)){
					this('selector '+ selector+' doesnt exist');
				}
				this.echo(selector);
				
				this.waitForSelector(selector, function(){
					this.echo('found selector');
					this.click(selector);
				});
				this.echo('clicked');
				break;
				
			}
			
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
	//this.exit();
});

//casper.then(function a3() {
//	
//	this.echo('a3 started')
//	this.waitForSelector('#Part0 > div:nth-child(6) > table > tbody > tr:nth-child(3) > td:nth-child(1) > input.j-train-radio', function(){
//		this.capture('POEZD.png');
//		this.echo('POEZD');
//		this.click('#Part0 > div:nth-child(6) > table > tbody > tr:nth-child(3) > td:nth-child(1) > input.j-train-radio');
//	});
	
	
//});


casper.then(function SubmitTrain() {
	this.echo('a4 started')
	this.echo('[4] Waiting for Submit Train')
	
	
	this.waitForSelector('#continueButton > span.btn-ie-mid', function(){
		this.capture('rzd-04-poezd-submit.png');
		this.echo('Detected Clicked submit train. Clicked');
		this.click('#continueButton > span.btn-ie-mid');
	},function(){
		this.echo('[ERROR-4] Timeout ');
		this.capture('rzd-04-timeout.png');
		fs.write('rzd-04-timeout.html',this.getHTML() , 'w');
		this.exit();
	},20000);
	
	
});


casper.then(function SelectWagon() {
	
	this.echo('[5] Waiting for Wagons..')
	
	//#Main > div > div > table.pass_cars_table
	this.waitForSelector('#Main > div > div > table.pass_cars_table', function(){
		this.capture('rzd-05-wagons.png');
		this.echo('Detected wagons!');

		//#Main > div > div > table.pass_cars_table > tbody > tr:nth-child(2)		
		//var eelements = this.getElementsInfo('tr');
		//var eelements = this.getElementsInfo('tr.j-car-item.trlist__trlist-subhead');
		var eelements = this.getElementsInfo('tr.j-car-item');
		//var elements = this.getElementsInfo('.trlist__trlist-row.trslot');
		//var elements = this.getElementsInfo('#Part0 > div:nth-child(6) > table > tbody > tr:nth-child(7) > td:nth-child(1)');
		//elements.forEach(function(element){
			//if (element.attributes["data-whatever"] === element.html) {
			//	casper.echo("data attribute and content are exactly equal");
			//} else {
			//	casper.echo("data attribute and content are different");
			//}
			//this.echo(element.text);
		//});
		//this.echo('number of wagons='+eelements.length);
		var selector='111';
		for (var i = 0; i < eelements.length; i++) { 
			var wagon = eelements[i]; 
			this.echo('----------------------------');
			this.echo('table raw = '+i);
			this.echo(wagon.text);
			var wagon_index = i+2;
				
			if (wagon.text.indexOf('Плацкартный') !== -1){
				
				this.echo('clicked Плацкартный '+wagon_index);
				//this.click('#Part0 > div:nth-child(6) > table > tbody > tr:nth-child(' + trainid +') > td:nth-child(1) > input.j-train-radio');
				//#Main > div > div > table.pass_cars_table > tbody > tr:nth-child(3)
				//#Main > div > div > table.pass_cars_table > tbody > tr:nth-child(5)
				//#Main > div > div > table.pass_cars_table > tbody > tr:nth-child(9)
				
				//var selector = '#Main > div > div > table.pass_cars_table > tbody > tr:nth-child('+wagon_index+') > td.trlist__cell-pointdata.tac > input[type="radio"]';
				//var selector = '#Main > div > div > table.pass_cars_table > tbody > tr:nth-child('+wagon_index+') > td.trlist__cell-pointdata.tac';
				selector = '#Main > div > div > table.pass_cars_table > tbody > tr:nth-child(7) > td.trlist__cell-pointdata.tac > input[type="radio"]';
				
				//#Main > div > div > table.pass_cars_table > tbody > tr:nth-child(7) > td.trlist__cell-pointdata.tac > input[type="radio"]
				
				//this.echo('wagon clicked');
				//break;
			}
		}
		if(casper.exists(selector)){
			this.echo('click '+selector);
			this.click(selector);
			fs.write('rzd-05-continue.html',this.getHTML() , 'w');
		}
		else {
			this('selector '+ selector+' doesnt exist');
		}
	});
});


casper.then(function SubmitTrain1() {
	//this.echo('TEST1')

});


casper.then(function SubmitTrain2() {
	this.echo('TEST2')

});


casper.then(function TEST() {
	this.echo(' [6] Waiting for  ... #continueButton > span.btn-ie-mid ');
	this.wait(1000,function(){
		this.capture('rzd-06-contine.png');
		this.click('#continueButton > span.btn-ie-mid');
		this.echo('Wagon continue detected! clicked.');
		fs.write('rzd-06-continue.html',this.getHTML() , 'w');
	});


//	this.waitForSelector('#continueButton > span.btn-ie-mid', function(){
//		this.capture('rzd-06-contine.png');
//		this.click('#continueButton > span.btn-ie-mid');
//		this.echo('Wagon continue detected! clicked.');
//		fs.write('rzd-06-continue.html',this.getHTML() , 'w');
//	
//	},function(){
//		this.echo('[ERROR-6] Timeout ');
//		this.capture('rzd-06-timeout.png');
//		fs.write('rzd-06-timeout.html',this.getHTML() , 'w');
//		this.exit();
//	},20000);
});


casper.then(function Login() {
	this.echo('[1] Waiting for login page...');
	this.capture('rzd-01-login-waiting.png');
	//<a href="https://badoo.com/signin/" class="link">Sign in</a>
	
	
	//#selfcare_logon_form
	this.waitForSelector('#selfcare_logon_form', function(){
		this.echo('login form  is detected');
		this.fill('#selfcare_logon_form', {
			'j_username': username,  
			'j_password': password},
			true);
		this.echo('form is filled');
	});
});


casper.then(function TEST() {
	this.echo(' [7] Waiting for passanger... ');

	this.waitForSelector('#formGeneral', function(){
		this.capture('rzd-07.png');
		//this.click('#continueButton > span.btn-ie-mid');
		
		
		this.echo('Passenger form detected!');
		
		this.evaluate(function() {
			document.querySelector('select.pass-field.trlist-pass__pass-field-box.trlist-pass__pass-field').selectedIndex = 1; //it is obvious
		});
		this.capture('rzd-07-01.png');
	
		this.click('input.pass-field');
		this.wait(100, function() {
			this.test.assert(this.evaluate(function () {
				//return document.getElementById('coucou').checked;
				document.querySelector('input.pass-field').cheked=true;
			}));
		});
  
		this.capture('rzd-07-02.png');
		
		this.fill('#formGeneral', {
			'lastName': 'Мушкаев',  
			'firstName': 'Сергей',
			'birthdate': '31.08.1977',
			'docNumber': '4509512486',
			},
			false);
		this.capture('rzd-07-03.png');	
		//#PassList > div.pass-list > div:nth-child(1) > div > div > div:nth-child(1) > input
		
		//fs.write('rzd-06-continue.html',this.getHTML() , 'w');
	
	},function(){
		this.echo('[ERROR-7] Timeout ');
		this.capture('rzd-07-timeout.png');
		fs.write('rzd-07-timeout.html',this.getHTML() , 'w');
		this.exit();
	},20000);
});

casper.then(function TEST11() {
	this.echo(' [8] DEBUG');
	this.wait(1000,function(){
		this.capture('rzd-08-debug.png');
		this.echo('debug.');
		fs.write('rzd-06-continue.html',this.getHTML() , 'w');
	});
});
	

casper.run();
