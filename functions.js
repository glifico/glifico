/*
 * GLIFICO Functions
 */
function onLoad(){
	console.log(document.cookie);
	console.debug(getLogged());
	if (getLogged()) {
		console.debug("set logged to true");
		isLogged = true;
		$("#usernameTab").show();
		$("#usernameLoginRegister").hide();
	} else {
		$("#usernameTab").hide();
		$("#usernameLoginRegister").show();
	}

	if (!isAgenzia && isLogged) {
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

function doDominoLogin() {
	var username=document.getElementById('textinput').value
	var password=document.getElementById('passwordinput').value
	var logReq = createXHTMLHttpRequest() ;

	var poststring="?user="+username+"&password="+password;
	logReq.onreadystatechange = function(){
		if (logReq.status == 200){
		if(JSON.parse(logReq.responseText)["statuscode"]==200){
			var user_value=username;
			saveTheCookie(user_value);
			console.log("logged");
			location.href=location.href;
			return(true);
		}else{
			mostraDialogTimed('errorPanel');
			return(false);
		}
	} else {
		mostraDialogTimed('errorPanel');
		return(false);
	};
}
	logReq.open("GET", "https://glifico.herokuapp.com/login.php"+poststring , false);
	logReq.send();
}


var cookie_name = "maincookie";

function saveTheCookie(value) {
	var today = new Date(); // Actual date
    var expire = new Date(); // Expiration of the cookie

    var number_of_days = 10; // Number of days for the cookie to be valid (10 in this case)

    expire.setTime( today.getTime() + 60 * 60 * 1000 * 24 * number_of_days ); // Current time + (60 sec * 60 min * 1000 milisecs * 24 hours * number_of_days)

    document.cookie = cookie_name + "=" + escape(value) + "; expires=" + expire.toGMTString();
	console.log("cookie set");
}


function getLogged(){
	var storedText = document.cookie;
	console.debug("getlogged");
	console.debug(/maincookie=[a-zA-Z0-9]{4,}/.test(storedText));
	return /maincookie=[a-zA-Z0-9]{4,}[;\s]/.test(storedText); 
}


function getUsername() {
    var return_value = null;

    var pos_start = document.cookie.indexOf("=");

    if (pos_start != -1) { // Cookie already set, read it
    	pos_start++;
        var pos_end = document.cookie.indexOf(";", pos_start); // Find ";" after the start position

        if (pos_end == -1) pos_end = document.cookie.length;
        return_value = unescape( document.cookie.substring(pos_start, pos_end) );
    }

    return return_value; // null if cookie doesn't exist, string otherwise
}

function logout() {
    document.cookie = cookie_name + "=; expires=" + new Date;
	location.href="index.html";
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
