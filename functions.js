/*
 * GLIFICO Functions
 */

/**
 * show or hide elements in all pages based on login and user type
 * 
 * getLogged() and getType() are from mylogin.js 
 * @returns void
 */
function onLoad(){
	console.log(document.cookie);
	var isLogged=false;
	var isAgency=false;
	
	if (getLogged()) {
		isLogged = true;
		$("#usernameTab").show();
		$("#usernameLoginRegister").hide();
	} else {
		$("#usernameTab").hide();
		$("#usernameLoginRegister").show();
	}

	if(getType()=="A"){
		isAgency=true;
	}
	
	if (!isAgency && isLogged) {
		console.log("should show");
		$("#li-rating").show();
		$("#li-trad").show();
		$("#li-skill").show();
	} else {
		$("#li-rating").hide();
		$("#li-trad").hide();
		$("#li-skill").hide();
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
