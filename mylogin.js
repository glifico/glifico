function doDominoLogin() {
	var username=document.getElementById('textinput').value
	var password=document.getElementById('passwordinput').value
	var logReq = createXHTMLHttpRequest() ;

	var poststring="?user="+username+"&password="+password;
	logReq.onreadystatechange = function(){
		if (logReq.status == 200&&logReq.readyState==4){
			if(JSON.parse(logReq.responseText)["statuscode"]==200){
				var user=JSON.parse(logReq.responseText)["user"];
				var token=JSON.parse(logReq.responseText)["token"];
				saveTheCookie(user, token);
				console.log("logged");
				location.href=location.href;
				return(true);
			}else{
				mostraDialogTimed('errorPanel');
				return(false);
			}
			//Todo
			/*
			 * if response = username already present
			 */
		};
	}
	logReq.open("GET", "https://glifico.herokuapp.com/login.php"+poststring , true);
	logReq.send();
}


var maincookie = "maincookie";

function saveTheCookie(user, token) {
	var today = new Date(); // Actual date
	var expire = new Date(); // Expiration of the cookie

	var number_of_days = 10; // Number of days for the cookie to be valid (10 in this case)

	expire.setTime( today.getTime() + 60 * 60 * 1000 * 24 * number_of_days ); // Current time + (60 sec * 60 min * 1000 milisecs * 24 hours * number_of_days)

	var object={};
	object.user=user;
	object.token=token;

	document.cookie = maincookie + "=" + (JSON.stringify(object)) +"$; expires=" + expire.toGMTString();
	console.log("cookie set");
}


function getLogged(){
	var return_value = false;

	var pos_start = document.cookie.indexOf(maincookie+"=");

	if (pos_start != -1) { // Cookie already set, read it
		pos_start+=maincookie.length+1;
		var pos_end=document.cookie.indexOf("$", pos_start); // Find ";" after the start position
		if (pos_end == -1) pos_end = pos_start;
		if(pos_end-pos_start<2){
			return false;
		}else{
			var string=(document.cookie.substring(pos_start, pos_end));
			var testToken = JSON.parse(string)['token'];
			return_value=/[a-zA-Z0-9]{8}[$]{0,1}[;\s]{0,1}/g.test(testToken);
		}
	}
	return return_value; 
}


function getUsername() {
	var return_value = null;

	var pos_start = document.cookie.indexOf(maincookie+"=");

	if (pos_start != -1) { // Cookie already set, read it
		pos_start=maincookie.length+1;
		var pos_end=document.cookie.indexOf("$", pos_start); // Find ";" after the start position
		if (pos_end == -1) pos_end = pos_start;
		//JSON object has at list two {}
		if(pos_end-pos_start<2){
			return null;
		}else{
			var string=unescape( document.cookie.substring(pos_start, pos_end))
			return_value = JSON.parse(string)['user'];
		}
	}
	return return_value; // null if cookie doesn't exist, string otherwise
}


function logout() {
	document.cookie = maincookie + "=; expires=" + new Date;
	location.href="index.html";
}