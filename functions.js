/*
 * GLIFICO Functions
 */

/**
 * show or hide elements in all pages based on login and user type
 * 
 * getLogged() and getType() are from mylogin.js 
 * @returns void
 */
var isLogged=false;

function onLoad(){
	console.log(document.cookie);

	var isAgency=false;
	var isTranslator=false;

	
	if (getLogged()) {
		isLogged = true;
		$("#usernameTab").show();
		$("#usernameLoginRegister").hide();
	} else {
		isAgency=false;
		isTranslator=false;
		$("#usernameTab").hide();
		$("#usernameLoginRegister").show();
	}

	if(getType()=="A"){
		isAgency=true;
	}else if (getType()=="T"){
		isTranslator=true;
	}

	if(isLogged){
		$("#MegaNavbarLeft").hide();
		if(isAgency){
			showAgencyStuff();
			hideTranslatorStuff();
		}else{
			hideAgencyStuff();
		}
		
		if(isTranslator){
			showTranslatorStuff();
			hideAgencyStuff();
		}else{
			hideTranslatorStuff();
		}
	}else{
		$("#MegaNavbarLeft").show();
		hideTranslatorStuff();
		hideAgencyStuff();
	}

	if(Notification.permission!="denied") Notification.requestPermission();
}

function notify(text){
	if(Notification.permission=="granted"){
		var options = {
				body: text,
				icon: "favicon288.ico"
		}
		var not = new Notification("Glifico",options);
		setTimeout(not.close.bind(not), 3000); 
	}
}

function showTranslatorStuff(){
	$("#li-trad").show();
	$("#li-tests").show();
	$("#li-skill").show();
	$("#li-jobs").show();
	$("#li-rating").show();
}

function showAgencyStuff(){
	$("#li-pay").show();
	$("#li-search").show();
}

function hideTranslatorStuff(){
	$("#li-rating").hide();
	$("#li-trad").hide();
	$("#li-tests").hide();
	$("#li-skill").hide();
	$("#li-jobs").hide();
}

function hideAgencyStuff(){
	$("#li-pay").hide();
	$("#li-search").hide();
}


function shouldBeTranslator(){
	//before deMorgan law if(!(isLogged&&!isAgency)){
	if(!getLogged()||isAgency()){
		alert("Please login as Translator");
	}
}

function shouldBeAgency(){
	//before deMorgan law if(!(isLogged&&isAgency)){
	if(!getLogged()||!isAgency()){
		alert("Please login as Agency");
	}
}

function createXHTMLHttpRequest() {
	try { return new ActiveXObject("Msxml2.XMLHTTP") ; } catch (e) {}
	try { return new ActiveXObject("Microsoft.XMLHTTP") ; } catch (e) {}
	try { return new XMLHttpRequest() ; } catch (e) {}
	alert("XMLHttpRequest is not supported on this browser!");
	return null;
}

function doRegistrazione(tipoRegistrazione){
	if(tipoRegistrazione=="T"){
		mostraDialogTimed('RT_errorPanel');
	}else if(tipoRegistrazione=="A"){
		mostraDialogTimed('RA_errorPanel');
	}

}

function mostraDialogTimed(nomeDialog,timeToShow){
	if(timeToShow==undefined){
		timeToShow=5000;
	}
	$("#"+nomeDialog).fadeTo(timeToShow, 500).slideUp(500, function(){
		$("#"+nomeDialog).slideUp(500);
	});
}

//Create Base64 Object
function base64_encode (data) {
	return Base64.encode(data)
}

function base64_decode (data) {
	return Base64.decode(data)
}



function convertJSON(obj) {
	var s = '';
	if(typeof(obj)==typeof(s)){
		return eval("(" + obj + ")");
	}else{
		return obj;
	}
}


//@Left equivalent
function strLeft(sourceStr, keyStr){
	return (sourceStr.indexOf(keyStr) == -1 | keyStr=='') ? '' : sourceStr.split(keyStr)[0];
}

//@Right equivalent
function strRight(sourceStr, keyStr){
	idx = sourceStr.indexOf(keyStr);
	return (idx == -1 | keyStr=='') ? '' : sourceStr.substr(idx+ keyStr.length);
}

//@RightBack equivalent
function rightBack(sourceStr, keyStr){
	arr = sourceStr.split(keyStr);
	return (sourceStr.indexOf(keyStr) == -1 | keyStr=='') ? '' : arr.pop()
}

//@LeftBack equivalent
function leftBack(sourceStr, keyStr){
	arr = sourceStr.split(keyStr)
	arr.pop();
	return (keyStr==null | keyStr=='') ? '' : arr.join(keyStr)
}

//@Middle equivalent
function middle(sourceStr, keyStrLeft, keyStrRight){
	return strLeft(strRight(sourceStr,keyStrLeft), keyStrRight);
}
