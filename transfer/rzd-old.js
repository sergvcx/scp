var utils  = require("utils");
var fs     = require('fs');
var system = require('system');
var casper = require('casper').create({
  verbose: true,
  logLevel: "warning",
  
//debug
//info
//warning
//error
});
casper.options.viewportSize = {width: 1300, height: 950};
casper.userAgent('Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36');
//casper.userAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X)');
//casper.userAgent('Mozilla/6.0 (compatible; MSIE 6.0; Windows NT 5.1)');
//casper.options.viewportSize = {width: 1600, height: 950};
casper.options.waitTimeout = 20000;
phantom.outputEncoding="cp866";
casper.start();


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


var ticket;
var auth;
var bank;
var passenger;

//casper.echo("Casper CLI passed args:");
//require("utils").dump(casper.cli.args);
//
//casper.echo("Casper CLI passed options:");
//require("utils").dump(casper.cli.options);


casper.then(function config() {
	this.echo('[configuration]');
	fs.write('sms.txt', "", 'w');
	if (this.cli.has("ticket")){
		
		var json_config=this.cli.get("ticket");
		this.echo('[ticket]:'+json_config);
		ticket = require(json_config);
		
		this.echo("  "+ticket['train']);  
		this.echo("  "+ticket['departure']);
		this.echo("  "+ticket['arrival']);
		this.echo("  "+ticket['class']);
		this.echo("  "+ticket['wagon']);
		this.echo("  "+ticket['bed']);
		this.echo("  "+ticket['seat']);
	}
	
	if (this.cli.has("date")){
		ticket['date']=this.cli.get("date");
	}
	this.echo("  "+ticket['date']);

	if (this.cli.has("auth")){
		var json_config=this.cli.get("auth");
		auth = require(json_config);
		this.echo('[auth]:'+json_config);  
		this.echo("  "+auth['username']);  
		this.echo("  "+auth['password']);
	}

	if (this.cli.has("bank")){
		var json_config=this.cli.get("bank");
		bank = require(json_config);
		this.echo('[bank]:'+json_config);  
		this.echo("  "+bank['card']);  
		this.echo("  "+bank['month']);
		this.echo("  "+bank['year']);
		this.echo("  "+bank['fio']);
		this.echo("  "+bank['ccc']);
	}
	
	if (this.cli.has("pass")){
		var json_config=this.cli.get("pass");
		passenger = require(json_config);
		this.echo('[passanger]:'+json_config);  
		this.echo("  "+passenger['firstname']);  
		this.echo("  "+passenger['lastname']);
		this.echo("  "+passenger['birthdate']);
		this.echo("  "+passenger['passport']);
		this.echo("  "+passenger['sex']);
	}
	
	this.echo('[end config]');
});



casper.open('http://rzd.ru', function() {
	
    this.echo(this.getTitle());
	this.capture('rzd-00-start.png');
});


casper.then(function KudaGo() {
	this.echo('[1] Waiting kuda-go form page ...');
	this.capture('rzd-00-1-kuda.png');
	//this.waitForSelector('#new_ticket_form > div:nth-child(1)', function(){
		
	this.waitForSelector('div.all_forma', function(){
	//this.waitForSelector('#tab0_Output', function(){
		this.echo('Kuda-go form page is detected! Filling...');
		//this.sendKeys('input.jroute-field.box-form__input.gradient','БЕРЕЩИНО');
		//this.sendKeys('#date0', date); // BULLSHIT
		
		this.capture('rzd-01-00.png');
		
		//this.page.sendEvent("keypress", casper.page.event.key.Tab);
		//this.wait(4000,function(){
		this.waitUntilVisible('#date0',function(){
			//var element = this.getElementInfo('#date0');
			//this.echo(this.getElementAttribute('#date0', 'class'));
			//this.echo(element.text);
			//this.echo(element);
			//this.page.sendEvent("keypress", casper.page.event.key.Tab);
			this.sendKeys('#name0', ticket['departure']);
			this.sendKeys('#name1', ticket['arrival']);
		
			this.capture('rzd-01-01.png');
			this.click('#date0'); // Обязательно
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
			this.capture('rzd-01-02.png');
			this.sendKeys('#date0',ticket['date']); // !! works
			this.capture('rzd-02-03.png');
			this.page.sendEvent("keypress", this.page.event.key.Tab);
		});
		
	},function(){
		this.echo('[ERROR-1] Waiting kuda-go form page ');
		this.capture('rzd-02-error.png');
		this.exit();
		//this.goto('RESTART');
	},10000);
	this.capture('rzd-02-zexit.png');
});

	
casper.then(function kudaGoSubmit() {
	this.echo('[2-1] Waiting kuda-go submit button...');
	this.capture('rzd-02-01-aenter.png');
	//this.waitForSelector('#new_ticket_form > div:nth-child(1)', function(){
	
	this.waitForSelector('#Submit', function(){
		this.echo('Kuda-go submit is detected!');
		this.echo(this.getElementAttribute('#Submit1', 'class'));
		//*[@id="date0"]
		this.capture('rzd-02-01-button.png');
		this.click('#Submit');
	},function(){
		this.echo('[ERROR-2-1] Waiting kuda-go buttob  ');
		this.capture('rzd-02-1-error.png');
		this.exit();
		//this.goto('RESTART');
	},10000);
	this.capture('rzd-02-1-zexit.png');
});


casper.then(function pageTrainList() {
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
		//this.exit();
		this.goto('RESTART');
	},20000);
	this.capture('rzd-03-zexit.png');
});

var trains;


casper.then(function pageTrainList() {
	//this.echo(trains.length);
	//this.echo(trains[0].getAttribute('class'));
	this.capture('rzd-03-enter.png');
	this.echo('[3] Waiting for list of trains page ...');
	this.waitForSelector('div.trlist__cell-pointdata__tr-num.train-num-0', function(){
		this.capture('rzd-03-list-of-trains.png');
		this.echo('List of trains page detected');
		var result=this.fetchText('div.j-trains-count.trlist__train-count');
		this.echo(result); // Показано 25 из 25 вариантов по прямому маршруту
		
		var elements = this.getElementsInfo('.trlist__cell-pointdata__tr-num.train-num-0');
		this.echo("Найдено "+elements.length+" поездов:");
		for (var i = 0; i < elements.length; i++) { 
			var train = elements[i]; 
			this.echo('------------'+i+'----------------');
			this.echo(train.text);
			var train_row = i+1;
			//this.echo(train.getAttribute('class')); //ERROR
			//this.echo(train.visible);
			
			
			if (train.text.indexOf(ticket['train']) !== -1){ 	// Если это искомый поезд
				var selector = '#Part0 > div:nth-child(6) > table > tbody > tr:nth-child(' + train_row +') > td:nth-child(1) > input.j-train-radio';
				this.click(selector);
			}
		}
	},function(){
		this.echo('[ERROR-3]:Timeout');
		this.capture('rzd-03-timeout.png');
		fs.write('rzd-03-timeout.html',this.getHTML() , 'w');
		this.exit();
	},20000);

});



casper.then(function submitTrain() {
	this.echo('[4] Waiting for Submit Train');
	
	//this.waitForSelector('#continueButton > span.btn-ie-mid', function(){
	this.waitUntilVisible('#continueButton > span.btn-ie-mid', function(){
		this.capture('rzd-04-poezd-submit.png');
		this.echo('[Click continue...]');
		this.click('#continueButton > span.btn-ie-mid');
	},function(){
		this.echo('[ERROR-4] Timeout ');
		this.capture('rzd-04-timeout.png');
		fs.write('rzd-04-timeout.html',this.getHTML() , 'w');
		this.exit();
	},20000);
	
	
});

var wagon_row_found=[0,0,0,0];

casper.then(function scanWagons() {
	this.echo('[5] Waiting for wagons..')
	this.waitForSelector('#Main > div > div > table.pass_cars_table', function(){
		this.capture('rzd-05-wagons.png');
		this.echo('Detected wagons!');
		var elements = this.getElementsInfo('tr.j-car-item');
		for (var i = 0; i < elements.length; i++) { 
			var element = elements[i]; 
			//this.echo('----------------------------');
			//this.echo('table raw = '+i);
			//this.echo(wagon.text);
			var wagon_radio_row = i+2;
			//this.echo(ticket['class'].length);
			for(var t=0; t<ticket['class'].length; t++){
				if (element.text.indexOf(ticket['class'][t]) !== -1){
					
					//this.echo('clicked Плацкартный '+wagon_index);
					this.echo('found '+ticket['class'][t] + ' at '+ wagon_radio_row);
					wagon_row_found[t]=wagon_radio_row;
				}	
			}
		}
	});
});


casper.then(function selectWagon() {
	this.capture('rzd-06.png');
	this.echo('[6] select wagon..');
	var found_wagons=0;
	for(var t=0; t<ticket['class'].length; t++){
		found_wagons+= wagon_row_found[t];
	}
	if (found_wagons==0){
		this.echo('*********** NO TICKETS *************************');
		this.exit();
	}
	else {
		this.echo('************* YOHOOO! CATCH TICKETS!!! ********************');
	}
			
	for(var t=0; t<ticket['class'].length; t++){
		if (wagon_row_found[t]>0){
			var selector = 	'#Main > div > div > table.pass_cars_table > tbody > tr:nth-child('+wagon_row_found[t]+') > td.trlist__cell-pointdata.tac > input[type="radio"]';
			if(casper.exists(selector)){
				//this.echo('[Click wagon radio...]'+selector);
				this.echo('Click wagon radio...');
				this.click(selector);
			}
			else {
				this.echo('[ERROR6-6] selector not found:' + selector);
				this.exit();
			}
			return;
		}
	}
						
});



casper.then(function submitWagon() {
	this.capture('rzd-07-select-wagon.png');
	this.echo('[7] Waiting for continueButton ');

	this.waitForSelector('#continueButton > span.btn-ie-mid', function(){
		this.capture('rzd-07-contine.png');
		this.echo('Wagon continue detected! clicked.');
		this.click('#continueButton > span.btn-ie-mid');
		fs.write('rzd-07-continue.html',this.getHTML() , 'w');
	},function(){
		this.echo('[ERROR-7] Timeout ');
		this.capture('rzd-07-timeout.png');
		fs.write('rzd-07-timeout.html',this.getHTML() , 'w');
		this.exit();
	},10000);
});


casper.then(function loginRZD() {
	this.echo('[8] Waiting for login page...');
	this.capture('rzd-08-login-waiting.png');
	this.waitForSelector('#selfcare_logon_form', function(){
		this.echo('Login form is detected');
		this.fill('#selfcare_logon_form', {
			'j_username': auth['username'],  
			'j_password': auth['password']},
			true);
		this.echo('form is filled');
	});
});


casper.then(function fillPassenger() {
	this.echo('[9] Waiting for passanger... ');
	this.capture('rzd-09.png');
	//this.waitForSelector('#formGeneral', function(){
	this.waitUntilVisible('#formGeneral', function(){
		this.capture('rzd-09-start.png');
		this.echo('Passenger form detected!');
		
		this.evaluate(function(sex){
			var checkbox=document.getElementsByName("insCheck");
			for(var i=0; i<checkbox.length; i++){
				checkbox[i].checked=false;
			}
			
			var combo=document.getElementsByName("gender");
			for(var i=0; i<combo.length; i++){
				//this.echo(sex); BULLSHIT
				if (sex=="Ж" || sex=="ж" || sex=="F" || sex=="f"){
					combo[i].value=1;
				}
				else {
					combo[i].value=2;
				}
			}
			
			var combog=document.getElementsByName("plGender");
			for(var i=0; i<combog.length; i++){
				combog[i].value="С";
			}
		},passenger['sex']
		);

		this.fill('#formGeneral', {
			'lastName' : passenger['lastname'],  
			'firstName': passenger['firstname'],
			'birthdate': passenger['birthdate'],
			'docNumber': passenger['passport']
			},
			false);
		this.page.sendEvent("keypress", this.page.event.key.Tab);
		this.capture('rzd-09-03.png');	
	},function(){
		this.echo('[ERROR-9] Timeout ');
		this.capture('rzd-09-timeout.png');
		fs.write('rzd-09-timeout.html',this.getHTML() , 'w');
		this.exit();
	},20000);
});



casper.then(function submitPassenger() {
	this.echo('[10] Waiting for submit passanger... ');
	this.capture('rzd-10.png');
	this.waitForSelector('button.btn.btn-color-red.btn-icon.btn-icon-right.btn-icon-red', function(){
		this.capture('rzd-10-start.png');
		this.echo('Click continue');
		this.click('button.btn.btn-color-red.btn-icon.btn-icon-right.btn-icon-red');
	});
});


casper.then(function agreePay() {
	this.echo('[11] Waiting for agree payment... ');
	this.capture('rzd-11.png');
	//this.waitUntilVisible('div.pass_IU_Reservation__cost-total', function(){
	this.waitUntilVisible('#Ref', function(){
		this.capture('rzd-11-start.png');
		this.echo('I agree..');
		//this.evaluate(function(){
		//	var checkbox=document.getElementsByClassName("marR15"); 
		//	for(var i=0; i<checkbox.length; i++){
		//		checkbox[i].checked=true;
		//		this.echo('---');
		//	}
		//});
		this.click("input.fle.marR15"); 
	},function timeoutAgree(){
		this.echo('[ERROR-11]:timeout');
		this.capture('rzd-11-timeout.png');
		this.exit();
	},15000);
});


/*
casper.waitForSelectorText = function(selector, text, then, onTimeout, timeout){
    this.waitForSelector(selector, function _then(){
        this.waitFor(function _check(){
            var content = this.fetchText(selector);
            if (utils.isRegExp(text)) {
                return text.test(content);
            }
            return content.indexOf(text) !== -1;
        }, then, onTimeout, timeout);
    }, onTimeout, timeout);
    return this;
};

casper.waitForSelectorAttribute = function(selector, attribute, value, then, onTimeout, timeout){
    this.waitForSelector(selector, function _then(){
        this.waitFor(function _check(){
            var content = this.getElementAttribute(selector,attribute); 
            return (content==value);
        }, then, onTimeout, timeout);
    }, onTimeout, timeout);
    return this;
};
*/
casper.then(function submitPay() {
	this.echo('[12] Waiting for submit payment... ');
	this.capture('rzd-12.png');
	this.waitForSelector('#Ref', function(){
		this.echo('Проверка данных пассажиров found ');
		//this.echo(this.getElementAttribute('#Ref', 'disabled'));
		this.waitFor(
			function checkNotDisabled(){
				return this.evaluate(function(){
					return !(document.getElementById("Ref").hasAttribute("disabled"));
				});
				
			}, 
			function pressPayButton(){
				this.capture('rzd-12-2-click.png');
				this.echo('Click pay');
				this.click('#Ref');
			},
			function onTimeout(){
				this.capture('rzd-12-3-click.png');
				this.echo('[ERROR-12] Timeout');
			},
			10000
		);
	});
});


casper.then(function  VTB24() {
	this.echo('[13] Waiting for VTB24... ');
	this.capture('rzd-13.png');
	this.waitForSelector('#mF', function(){
		this.echo('VTB Form detected');
		//this.sendKeys('div.input-wrap.exp', json['month']+json['year']);
		this.fill('#mF', {
			'pan-decor':bank['card'],  
			'fio':  	bank['fio'],
			'cvv2': 	bank['ccc'],
			'expMon':  	bank['month'],
			'ExpYear': 	bank['year']
			},
			false);
		
		
		this.echo('form is filled');
	});
});

casper.then(function  submitVTB24() {
	this.echo('[14] Waiting for VTB24... ');
	this.capture('rzd-14.png');
	this.waitForSelector('#OK', function(){
		this.capture('rzd-14-click.png');
		this.echo('Click');
		this.click('#OK');
	});
});

casper.then(function  enterPIN() {
	this.echo('[15] Waiting for SMS... ');
	this.capture('rzd-15.png');
	this.waitForSelector('#DynamicPassword', function(){
		var PIN="";
		this.waitFor(
			function checkSMS(){
				PIN=fs.read('sms.txt');
				return (PIN!="")
			},
			function enterCode(){
				this.echo('invalidating sms.txt...');
				fs.write('sms.txt', "", 'w');
				this.capture('rzd-15-sms.png');
				this.echo('Enter SMS-code='+ PIN);
				
				this.sendKeys('#DynamicPassword',PIN);
				this.capture('rzd-15-sms.png');
				this.click('#btnSubmit');

			},
			function timeoutSMS(){
				this.echo('[ERROR-15] timeout  PIN='+PIN);
				this.exit();
			},
			5*60*1000
			);
		
		
		
	});
});





casper.then(function out() {
	this.echo(' [99] DEBUG');
	this.wait(10000,function(){
		this.capture('rzd-99-debug.png');
		this.echo('debug.');
		fs.write('rzd-11-continue.html',this.getHTML() , 'w');
	});
});
	

casper.run();
