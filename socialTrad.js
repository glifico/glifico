var maxpages = 0;
var actualPage = 0;
var started = false;
var maxSeconds = 600;
var nowSeconds = 0;
var outTime = false;
var myTimer;
var domande = [];
var domanda = [];

$.ajaxSetup( {
	async : false
});

$(document).ready( function() {
	init();
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
	html+='<i class="fa fa-linkedin"></i>';
	html+='</a>';
	html+='          <a href="https://www.facebook.com/sharer/sharer.php?u=www.glifico.com">';
	html+='<i class="fa fa-facebook"></i>';
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
			createTable();
			return(true);
		}else{
			mostraDialogTimed('errorPanel');
			return(false);
		}
	}

	req.open("GET", url, true);
	req.send();
}

function gotLanguages(data){
	// Combo box 1
	var html = "";
	html += '<select id="select-language" class="form-control">'
		html += '<option value="-"></option>'

			for (i = 0; i < data.length; i++) {
				html += '<option value="' + data[i].IdLanguageTo + '">'
				+ data[i].LanguageTo + '</option>'
			}
	html += '</select>'
		// Combo box 2
		var html2 = "";
	html2 += '<select id="select-language2" class="form-control">'
		html2 += '<option value="-"></option>'

			for (i = 0; i < data.length; i++) {
				html2 += '<option name="' + data[i].Language + '" value="'
				+ data[i].IdLanguageTo + '">' + data[i].LanguageTo
				+ '</option>'
			}
	html2 += '</select>'
		$('#span-combo-lingue').html(html);
	$('#span2').html(html2);

}

function getTesto(lang) {
	var url = "getRatingQuestions.php?user="+getUsername()+"&token="+getToken()+"&lang="+lang;

	console.debug("getTesto");

	var req = createXHTMLHttpRequest() ;
	req.onreadystatechange = function(){
		if (req.status == 200&req.readyState==4){
			var data=JSON.parse(req.responseText);
			domande = data;
			showDomanda();
			return(true);
		}else{
			mostraDialogTimed('errorPanel');
			return(false);
		}
	}

	req.open("GET", url, true);
	req.send();
}

function tryOut2() {
	console.debug("try");
	started = false;
	outTime = false;
	nowSeconds = 0;

	var e = document.getElementById("select-language");
	var lan = e.options[e.selectedIndex].text;


	e = document.getElementById("select-language2");
	var lan2 = e.options[e.selectedIndex].text;

	if (lan == lan2) {
		alert("Impossible insert the same language. Please change it");
		return;
	}
	if (lan != null && lan != "-" && lan2 != null && lan2 != "-") {
		var html = "";
		html = 'Are you ready? <br /><a class="btn btn-success" href="javascript:void(0)" onClick="startTest()">Let\'s go!</a>'
			$("#skill-body").html(html);
		$('#skill-modal').modal('show');
	}else{
		alert("Please complete both fields");
		return;
	}
}


function startTest() {
	e = document.getElementById("select-language");
	var lang = e.options[e.selectedIndex].text;

	getTesto(lang);
	if (!started) {
		started = true;
		myTimer = setInterval(mioTimer, 1000)

	}
	$("#submit-btn-trad").show();
}

function mioTimer() {
	nowSeconds++;
	if (nowSeconds >= maxSeconds) {
		clearTimeout(myTimer);
		outTime = true;
	}
	getProgress();
}

function showDomanda() {
	alert("You have 10 minutes to complete the translation! Good Luck.");
	var html = "";
	var domanda = domande[0];
	html += '<form>'
		html += '<div class="panel panel-default"><div class="modal-translator"> <font size="2" >' + domanda.text_to_translate;
	+'</font>  </div> </div>'
	html += '<br/>'

		html += '<br><div><center> <textarea rows="4" cols="110" id="textarea" placeholder="Please enter here the translation of the text here"></textarea></center>' + '</div>'
		var selected = "";
	var disabled = "";
	if (outTime) {
		disabled = "disabled"
	}
	html += '</form><br>'
		html += '<div class="progress" id="bar-progress">'
			html += '</div>'
				if (started) {
					html += '<span id="rimanente"></span>'
				}
	if (outTime) {
		html += '<div style="text-align:center;width:100%"><span id="scaduto" style="font-weight:bold;font-color:red>Tempo scaduto</span></div>'
	}

	$("#skill-body").html(html);
	$("#skill-body").fadeIn("show");
}


function finishTest() {
	if (confirm("Do you want to submit the test?")) {

		var traduzione = document.getElementById("textarea").value;
		var e = document.getElementById("select-language");
		var linguaF = e.options[e.selectedIndex].text;

		e = document.getElementById("select-language2");
		var linguaT = e.options[e.selectedIndex].text;
		var domanda = domande[0];
		var testo = domanda.text_to_translate;

		var temp = {
				user : getUsername(),
				token: getToken(),
				testo : testo,
				linguaF : linguaF,
				linguaT : linguaT,
				trad : traduzione,
				idtest: domanda.id,
		};
		var stringPass = JSON.stringify(temp);
		var data = stringPass;

		$.ajax( {
			type : "POST",
			dataType : "application/json",
			contentType : "application/json; charset=utf-8",
			data : data,
			url : "saveRatingTest.php",
			complete : function(ret) {
				var response=ret.responseText;
				clearTimeout(myTimer);
				nowSeconds = 0;
				$('#skill-modal').modal('hide');

				$("#alertOK").html("Test Completed!");
				$("#alertOK").fadeIn().delay(5000).fadeOut();

				createTable();
			},
			error : function(xhr) {
				if (xhr.status == 500) {
					$("#alertError").html("Error from server, please retry.");
					$("#alertError").fadeIn().delay(1000).fadeOut();
				}

			}
		});

	}
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
		html += "</div>"

			$("#bar-progress").html(html);
	$("#rimanente").html("Seconds remaining: " + (maxSeconds - nowSeconds))

}





function createTable(){

	var url = "getRatingTest.php?user=" + getUsername()+"&token="+getToken();

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
		html += '	<tr valign="middle">';
		html += '		<th';
		html += '			class="glifico-th-5">Language from</th>';
		html += '		<th';
		html += '			class="glifico-th-5">Language To</th>';
		html += '		<th';
		html += '			class="glifico-th-5">Grammar mark</th>';
		html += '		<th';
		html += '			class="glifico-th-5">Style mark</th>';
		html += '		<th';
		html += '			class="glifico-th-5">Share with friends</th>';
		html += '	</tr>';
		html += '</thead>';
		html += '<tbody>';
		for ( var i = 0; i < data.length; i++) {
			html += '<tr valign="middle">'
				html += '<td class="glifico-td-5">' + data[i].LanguageF + '</td>';
			html += '<td class="glifico-td-5">' + data[i].LanguageT + '</td>'
			if(data[i].Grammarmark == null){
				html += '<td class="glifico-td-5">' + '<font color="red"> <i> Not evalutated yet </i> </font>' + '</td>'
			}else{
				html += '<td class="glifico-td-5">' + getStars(data[i].Grammarmark) + '</td>'
			}
			if(data[i].Stylemark == null){
				html += '<td class="glifico-td-5">' + '<font color="red"> <i> Not evalutated yet </i> </font>' + '</td>'
			}else{
				html += '<td class="glifico-td-5">' + getStars(data[i].Stylemark) + '</td>'
			}
			html+='<td class="glifico-td-5 col-md-2">'+getSocial()+'</td>'
			html+='</tr>'
		}
		html += "</tbody>";
		html += "</table>";
		$('#tabella').html(html);
	}
}
