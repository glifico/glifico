var maxpages = 0;
var actualPage = 0;
var started = false;

var maxSeconds = 400;
//Se aggiorni qui aggiorna il testo!
var nowSeconds = 0;
var outTime = false;
var myTimer;
var domande = [];
$.ajaxSetup( {
	async : false
});

$(document).ready( function() {
	init();
});


$(document).ready( function() {
	result();
});


getStars=function(price){
	var html="";
	html+='<div class="price">';
	html+='<span class="money '+(price>=1?'filled':'')+'"><i  class="fa fa-star fa-fw" aria-hidden="true" data-rating="1"></i></span>';
	html+='<span class="money '+(price>=2?'filled':'')+'"><i  class="fa fa-star fa-fw" aria-hidden="true" data-rating="2"></i></span>';
	html+='<span class="money '+(price>=3?'filled':'')+'"><i  class="fa fa-star fa-fw" aria-hidden="true" data-rating="3"></i></span>';
	html+='<span class="money '+(price>=4?'filled':'')+'"><i  class="fa fa-star fa-fw" aria-hidden="true" data-rating="4"></i></span>';
	html+='<span class="money '+(price>=5?'filled':'')+'"><i  class="fa fa-star fa-fw" aria-hidden="true" data-rating="5"></i></span>';
	html+='</div>';
	return html;
}

getSocial=function(){
	var html='';
	html+='<font size="5px">';
	//html+='<a href="https://twitter.com/home?status=I%20rate%20myself%20on%20Glifico!%0A%23glifico">';
	//html+='<i class="fa fa-twitter"></i>';
	//html+='</a>';
	html+=' <a href="https://www.linkedin.com/shareArticle?mini=true&url=https%3A//www.glifico.com&title=Glifico&summary=I%20rate%20myself%20on%20Glifico!&source=">';
	html+='<i class="fab fa-linkedin"></i>';
	html+='</a>';
	html+='          <a href="https://www.facebook.com/sharer/sharer.php?u=www.glifico.com">';
	html+='<i class="fab fa-facebook"></i>';
	html+='</a>';
	html+='</font>';
	return html;
}


function init() {

	var url = "getTranslatorLanguages.php?user="+getUsername()+"&token="+getToken();

	var req = createXHTMLHttpRequest() ;
	req.onreadystatechange = function(){
		if (req.status == 200&req.readyState==4){
			var data=JSON.parse(req.responseText);
			gotLanguages(data);
			return(true);
		}else{
			mostraDialogTimed('errorPanel');
			return(false);
		}
	}



	req.open("GET", url, true);
	req.send();

//	var data=[
//	JSON.stringify({
//	"LanguageTo":"Italian",
//	"IdLanguageTo":"it"
//	})
//	];

	function gotLanguages(data){

		var html = "";
		html += '<select id="select-language" class="form-control">';
		html += '<option value="-"></option>';

		for (i = 0; i < data.length; i++) {
			html += '<option value="' + data[i].IdLanguageTo + '">'
			+ data[i].LanguageTo + '</option>';
		}
		html += '</select>';
		$('#span-combo-lingue').html(html);
		document.getElementById('span-combo-lingue').innerHtml=html;
	}
}

function result(){
	var url = "getTest.php?user=" + getUsername()+"&token="+getToken();

	var req = createXHTMLHttpRequest() ;
	req.onreadystatechange = function(){
		if (req.status == 200&req.readyState==4){
			var data=JSON.parse(req.responseText);
			gotData(data);
			return(true);
		}else{
			mostraDialogTimed('errorPanel');
			return(false);
		}
	}
	req.open("GET",url,true);
	req.send();


	function gotData(data){


		var html = "";
		html += '<table style="width:100%" class="table">';
		html += '<thead>';
		html += '	<tr class ="row" valign="middle">';
		html += '		<th';
		html += '			class="glifico-th-5 col-md-2">Language</th>';
		html += '		<th';
		html += '			class="glifico-th-5 col-md-2">Last Execution Date</th>';
		html += '		<th';
		html += '			class="glifico-th-5 col-md-2">Status</th>';
		html += '		<th';
		html += '			class="glifico-th-5 col-md-3">Rating</th>';
		html += '		<th';
		html += '			class="glifico-th-5 col-md-2">Share with friends</th>';
		html += '	</tr>';
		html += '</thead>';
		html += '<tbody>';
		for ( var i = 0; i < data.length; i++) {
			var classe="";
			if (data[i].TotTest == null||data[i].TotTest <1) {
				classe=' class="danger"'
			}
			html += '<tr class ="row" valign="middle"  '+classe+'>'

			var lang = data[i].Language
			html += '<td class="glifico-td-5 col-md-2"> <b>'
				+ lang
				+ '</b> </td>'
				if (data[i].TotTest == null) {
					html += '<td class="glifico-td-5 col-md-2">Not done yet</td>'
						html += '<td class="glifico-td-5 col-md-2">' + '<font color="red"> <i> Not Done </i> </font>' + '</td>'
						html += '<td class="glifico-td-5 col-md-3"></td>'
						html += '<td class="glifico-td-5 col-md-2"></td>'
				} else {
					var data1 = data[i].DataTest
					data1 = data1.replace("T"," ")
					data1 = data1.replace("Z","")
					data1 = data1.substring(0,data1.length-3)
					html += '<td class="glifico-td-5 col-md-2">' + data1 + '</td>'
					html += '<td class="glifico-td-5 col-md-2">' + '<font color="#008000"> <b>Done</b></font>' + '</td>'
					html += '<td class="glifico-td-5 col-md-3">'
						+ '<font color="black" size="5px"><b>'
						+ getStars(data[i].TotTest)
						+ '</b></font>' + '</td>'
						html+='<td class="glifico-td-5 col-md-2">'+getSocial()+'</td>'
				}

			html += '</tr>'
		}
		html += "</tbody>";
		html += "</table>";
		$('#tabella').html(html);
	}

}

function getDomande() {
	var e = document.getElementById("select-language");
	var lang = e.options[e.selectedIndex].text;

	var url = "getDomande.php?user="+getUsername()+"&token="+getToken()+"&lang=" + lang;

	var req = createXHTMLHttpRequest() ;
	req.onreadystatechange = function(){
		if (req.status == 200&req.readyState==4){
			var data=JSON.parse(req.responseText);
			maxpages = data.length;
			actualPage = 1;
			domande = data
			showDomanda();
			return(true);
		}else{
			mostraDialogTimed('errorPanel');
			return(false);
		}
	}
	req.open("GET",url,true);
	req.send();

}

function tryOut() {

	started = false;
	outTime = false;
	nowSeconds = 0;
	var lan = $("#select-language").val();
	if (lan != null && lan != "-") {
		var html = "";
		html = 'Are you ready?<br /><a class="btn btn-success" href="javascript:void(0)" onClick="startTest()">Let\'s go!</a>'
			$("#skill-body").html(html);
		$('#skill-modal').modal('show');
	}else{
		alert("Please complete the field");
		return;
	}

}

function startTest() {
	actualPage = 1;
	getDomande();
	if (!started) {
		started = true;
		myTimer = setInterval(mioTimer, 1000)
	}
	getProgress();
}

function mioTimer() {
	nowSeconds++;
	if (nowSeconds >= maxSeconds) {
		clearTimeout(myTimer);
		outTime = true;
		$("#scaduto").html("Time is up");
	}
	getProgress();
}

function showDomanda() {
	$("#skill-body").hide();

	var html = "";
	var domanda = domande[actualPage - 1];
	html += "<p><form id=\"myForm\">";
	html += actualPage + ". " + domanda.question;
	html += "<br />";

	// risposta 1
	var selected = "";
	var disabled = "";
	if (outTime) {
		disabled = "disabled"
	}
	if (domanda.scelta != undefined && domanda.scelta == 1) {
		selected = 'checked="checked"';
	}
	html += '<input ' + disabled + ' ' + selected
	+ ' type="radio" name="domanda_' + (actualPage - 1)
	+ '" value="1">&nbsp;' + domanda.answer1 + '<br>'

	// risposta 2
	var selected = "";
	var disabled = "";
	if (outTime) {
		disabled = "disabled"
	}
	if (domanda.scelta != undefined && domanda.scelta == 2) {
		selected = 'checked="checked"';
	}
	html += '<input ' + disabled + ' ' + selected
	+ ' type="radio" name="domanda_' + (actualPage - 1)
	+ '" value="2">&nbsp;' + domanda.answer2 + '<br>'

	// risposta 3
	var selected = "";
	var disabled = "";
	if (outTime) {
		disabled = "disabled"
	}
	if (domanda.scelta != undefined && domanda.scelta == 3) {
		selected = 'checked="checked"';
	}
	html += '<input ' + disabled + ' ' + selected
	+ ' type="radio" name="domanda_' + (actualPage - 1)
	+ '" value="3" >&nbsp;' + domanda.answer3 + '<br>'
	html += '<input type="hidden" name="domanda_' + (actualPage - 1)
	+ '1"value="' + domanda.id + '">';
	prev = true;
	next = true;
	last = false;
	if (actualPage == 1) {
		prev = false;
	}
	if (actualPage == maxpages) {
		next = false;
		last = true;
	}
	html += '<span style="float:right">';
	if (prev) {
		html += '<a class="btn btn-default" href="javascript:void(0)" onclick="prevDomanda()"><i class="fa fa-arrow-left"></i>&nbsp;Previous</a>&nbsp;'
	}
	if (next) {
		html += '&nbsp;<a class="btn btn-default" href="javascript:void(0)" onclick="nextDomanda()">Next&nbsp;<i class="fa fa-arrow-right"></i></a>'
	}
	if (last) {
		html += '&nbsp;<a class="btn btn-primary" href="javascript:void(0)" onclick="finishTest()"><i class="fa fa-paper-plane"></i>&nbsp;Submit</a>'
	}
	html += "</span>"
		html += "</form></p><br /><br />";

	html += '<div class="progress" id="bar-progress">'
		html += '</div>'

			html += '<span id="rimanente"></span>';

	html += '<div style="text-align:center;width:100%;background:red;"><span id="scaduto" style="font-weight:bold;font-size:30px;color:#FFF"></span></div>';

	$("#skill-body").html(html);
	if(outTime) $("#scaduto").html("Time is up");
	$("#skill-body").fadeIn("slow");
}

function finishTest() {
	domande[actualPage-1].scelta=$('input[name='+'domanda_' + (actualPage - 1)+ ']:checked').val();

	if(outTime){
		alert("Sorry, time is ended");
		return;
	}

	if (confirm("Do you want to submit the test?")) {
		var temp = {
				user : getUsername(),
				token: getToken(),
				document : domande
		};

		var stringPass = JSON.stringify(temp);
		var data = stringPass;

		$.ajax( {
			type : "POST",
			dataType : "application/json",
			contentType : "application/json; charset=utf-8",
			data : data,
			url : "saveSkillTest.php",
			complete : function(ret) {
				var response=ret.responseText;
				//console.debug(response);
				clearTimeout(myTimer);
				nowSeconds = 0;
				$('#skill-modal').modal('hide');

				var result=(JSON.parse(response.replace(/\\/,"")))['score'];
				alert("Test completed with a result of "+result+"/"+domande.length);
				notify("Result:"+result+"/"+domande.length);
				$("#alertOK").html("Test Completed!");
				$("#alertOK").fadeIn().delay(5000).fadeOut();
			},
			error : function(xhr) {
				if (xhr.status == 500) {
					$("#alertError").html("Error from server, please retry.");
					$("#alertError").fadeIn().delay(1000).fadeOut();
				}

			}
		});
		result();
	}
}

function nextDomanda() {
	domande[actualPage-1].scelta=$('input[name='+'domanda_' + (actualPage - 1)+ ']:checked').val();
	actualPage++;
	showDomanda();
}

function prevDomanda() {
	actualPage--;
	if (actualPage < 1)
		actualPage = 1;
	showDomanda();
}

function getProgress() {
	var html = "";

	html += '<div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="'
		+ nowSeconds
		+ '" aria-valuemin="0" aria-valuemax="'
		+ maxSeconds
		+ '" style="width: '
		+ parseInt((nowSeconds * 100) / maxSeconds)
		+ '%">'
		html += "</div>";

	$("#bar-progress").html(html);
	$("#rimanente").html("Seconds remaining: " + (maxSeconds - nowSeconds))

}
