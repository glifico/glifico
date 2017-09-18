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
	};
}
	logReq.open("GET", "https://glifico.herokuapp.com/login.php"+poststring , false);
	logReq.send();
}


var cookie_name = "username";

function saveTheCookie(value) {
	var today = new Date(); // Actual date
    var expire = new Date(); // Expiration of the cookie

    var number_of_days = 10; // Number of days for the cookie to be valid (10 in this case)

    expire.setTime( today.getTime() + 60 * 60 * 1000 * 24 * number_of_days ); // Current time + (60 sec * 60 min * 1000 milisecs * 24 hours * number_of_days)

    document.cookie = cookie_name + "=" + escape(value) + "$; expires=" + expire.toGMTString();
	console.log("cookie set");
}


function getLogged(){
	var storedText = document.cookie;
	return /username=[a-zA-Z0-9]{4,}[$][;\s]{0,1}/g.test(storedText); 
}


function getUsername() {
    var return_value = null;

    var pos_start = document.cookie.indexOf(cookie_name+"=");

    if (pos_start != -1) { // Cookie already set, read it
    	pos_start=cookie_name.length+1;
	var pos_end=document.cookie.indexOf("$", pos_start); // Find ";" after the start position
        if (pos_end == -1) pos_end = document.cookie.length;
        return_value = unescape( document.cookie.substring(pos_start, pos_end) );
    }

    return return_value; // null if cookie doesn't exist, string otherwise
}

function logout() {
    document.cookie = cookie_name + "=; expires=" + new Date;
	location.href="index.html";
}