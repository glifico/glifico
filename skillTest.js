var maxpages = 0;
var actualPage = 0;
var started = false;

var debug=false;

//were 600 before debug
if(debug){
	var maxSeconds = 10;
}else{
	var maxSeconds = 100;
}
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

function init() {

	if(!debug){
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
	}else{
		var data=[
			JSON.stringify({
				"LanguageTo":"Italian",
				"IdLanguageTo":"it"
			})
			];

		gotLanguages(data);
	}

	function gotLanguages(data){

		var html = "";
		html += '<select id="select-language" class="form-control">';
		html += '<option value="-"></option>';

		for (i = 0; i < data.length; i++) {
			html += '<option value="' + JSON.parse(data[i]).IdLanguageTo + '">'
			+ JSON.parse(data[i]).LanguageTo + '</option>';
		}
		html += '</select>';
		$('#span-combo-lingue').html(html);
		document.getElementById('span-combo-lingue').innerHtml=html;
	}
}

function result(){
	var url = "getTest.php?user=" + getUsername()+"&token="+getToken();

//	var req = createXHTMLHttpRequest() ;
//	req.onreadystatechange = function(){
//	if (req.status == 200&req.readyState==4){
//	var data=JSON.parse(req.responseText);
//	console.log(data);
//	gotData(data);
//	return(true);
//	}else{
//	mostraDialogTimed('errorPanel');
//	return(false);
//	}
//	}
//	req.open("GET",url,true);
//	req.send();

	var data=[
		{
			"Language":"Italian",
			"DataTest":"25/09/2017T12:000Z",
			"TotTest":5
		},
		{
			"Language":"Japanese",
			"DataTest":"25/09/2017T12:000Z",
		},
		];

	gotData(data);



	function gotData(data){


		var html = "";
		html += '<table style="width:100%" class="table">';
		html += '<thead>';
		html += '	<tr valign="middle">';
		html += '		<th';
		html += '			style="text-align:center;width:25%;height:32px;background-color:#EFEFEF">Language</th>';
		html += '		<th';
		html += '			style="text-align:center;width:25%;height:32px;background-color:#EFEFEF">Last Execution Date</th>';
		html += '		<th';
		html += '			style="text-align:center;width:25%;height:32px;background-color:#EFEFEF">Status</th>';
		html += '		<th';
		html += '			style="text-align:center;width:25%;height:32px;background-color:#EFEFEF">Rating</th>';
		html += '	</tr>';
		html += '</thead>';
		html += '</tbody>';
		for ( var i = 0; i < data.length; i++) {
			var classe="";
			if (data[i].TotTest == null) {
				classe=' class="danger"'
			}
			html += '<tr valign="middle"  '+classe+'>'

			var lang = data[i].Language
			html += '<td style="text-align:center;width:25%;height:42px;border-top:1px solid #EFEFEF;border-bottom:1px solid #EFEFEF;border-left:1px solid #EFEFEF;border-right:1px solid #EFEFEF"> <b>'
				+ lang
				+ '</b> </td>'
				if (data[i].TotTest == null) {
					html += '<td style="text-align:center;width:25%;height:42px;border-top:1px solid #EFEFEF;border-bottom:1px solid #EFEFEF;border-left:1px solid #EFEFEF;border-right:1px solid #EFEFEF">Not done yet</td>'
						html += '<td style="text-align:center;width:25%;height:42px;border-top:1px solid #EFEFEF;border-bottom:1px solid #EFEFEF;border-left:1px solid #EFEFEF;border-right:1px solid #EFEFEF">' + '<font color="red"> <i> Not Done </i> </font>' + '</td>'
						html += '<td style="text-align:center;width:25%;height:42px;border-top:1px solid #EFEFEF;border-bottom:1px solid #EFEFEF;border-left:1px solid #EFEFEF;border-right:1px solid #EFEFEF"><img src=images/00.png style="max-width:100px" />'+ '</td>'
				} else {
					var data1 = data[i].DataTest
					data1 = data1.replace("T"," ")
					data1 = data1.replace("Z","")
					data1 = data1.substring(0,data1.length-7)
					html += '<td style="text-align:center;width:25%;height:42px;border-top:1px solid #EFEFEF;border-bottom:1px solid #EFEFEF;border-left:1px solid #EFEFEF;border-right:1px solid #EFEFEF">' + data1 + '</td>'
					html += '<td style="text-align:center;width:25%;height:42px;border-top:1px solid #EFEFEF;border-bottom:1px solid #EFEFEF;border-left:1px solid #EFEFEF;border-right:1px solid #EFEFEF">' + '<font color="#008000"> <b>Done </b></font>' + '</td>'
					var totString = (data[i].TotTest + "")
					if(totString.lenght = 1){
						totString = totString + '0';
					}
					html += '<td style="text-align:center;width:25%;height:42px;border-top:1px solid #EFEFEF;border-bottom:1px solid #EFEFEF;border-left:1px solid #EFEFEF;border-right:1px solid #EFEFEF">'
						+ '<font color="blue"><b><img src=images/'
						+ totString.replace(".", "")
						+ '.png style="max-width:100px" />'
						+ '</b></font>' + '</td>'
				}

			html += '</tr>'
		}
		html += "</tbody>";
		html += "</table>";
		$('#tabella').html(html);
	}

}

function getDomande() {
	var url = "getDomande.php?user="+getUsername()+"&token="+getToken()+"&lang=" + $("#select-language").text;

	console.log($("#select-language").text);
	
	var req = createXHTMLHttpRequest() ;
	req.onreadystatechange = function(){
		if (req.status == 200&req.readyState==4){
			var data=JSON.parse(req.responseText);
			console.log(data);
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
		html = 'Are you ready?<br /><a class="btn btn-default" href="javascript:void(0)" onClick="startTest()">Go!</a>'
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
	console.log("mioTimer");
	if (nowSeconds >= maxSeconds) {
		console.debug("should exit");
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
		html += '&nbsp;<a class="btn btn-default" href="javascript:void(0)" onclick="finishTest()"><i class="fa fa-paper-plane"></i>&nbsp;Submit</a>'
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
	domande[actualPage-1].Scelta=$('input[name='+'domanda_' + (actualPage - 1)+ ']:checked').val();

	if(outTime){
		notify("Sorry, time is ended");
		return;
	}

	if (confirm("Do you want to submit the test?")) {
		var temp = {
				//userId : sysIdUtente,
				document : domande
		};
		var stringPass = JSON.stringify(temp);
		var data = stringPass;
		console.log(stringPass);
		$.ajax( {
			type : "POST",
			dataType : "application/json",
			contentType : "application/json; charset=utf-8",
			data : data,
			url : "rest.xsp?api=saveTest",
			complete : function(ret) {

				clearTimeout(myTimer);
				nowSeconds = 0;
				$('#skill-modal').modal('hide');
			},
			error : function(xhr) {
				if (xhr.status == 500) {
					showNotifica("danger", "Errore dal server");
				}

			}
		});
		result();
	}
}

function nextDomanda() {
	domande[actualPage-1].Scelta=$('input[name='+'domanda_' + (actualPage - 1)+ ']:checked').val();	
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