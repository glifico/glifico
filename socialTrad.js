var maxpages = 0;
var actualPage = 0;
var started = false;
var maxSeconds = 600;
var nowSeconds = 0;
var outTime = false;
var myTimer;
var domande = [];
var domanda = [];
var lingua = [];

$.ajaxSetup( {
	async : false
});

$(document).ready( function() {
	init();
});

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

function getTesto() {
	$(document).ready(
			function() {
				var url = "rest.xsp?api=getTesto&lingua="
						+ $("#select-language").val();
				$.get(url, function(data) {
					domande = data;
				});
				showDomanda();
			});

}

function tryOut2() {
	started = false;
	outTime = false;
	nowSeconds = 0;
	var lan = $("#select-language").val();
	var lan2 = $("#select-language2").val();

	if (lan == lan2) {
		alert("Impossible insert the same language. Please change it");
		return;
	}
	if (lan != null && lan != "-" && lan2 != null && lan2 != "-") {
		var html = "";
		html = 'Are you ready? <br /><a class="btn btn-default" href="javascript:void(0)" onClick="startTest()"> Go!</a>'
		$("#skill-body").html(html);
		$('#skill-modal').modal('show');
	}else{
		alert("Please complete both fields");
		return;
	}
}
function startTest() {
	getTesto();
	if (!started) {
		started = true;
		myTimer = setInterval(mioTimer, 1000)

	}
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
	html += '<div class="panel panel-default"><div class="panel-heading"> <font size="2" >' + domanda.Testo;
	+'</font>  </div> </div>'
	html += '<br/>'
	var url = "rest.xsp?api=getLanguage&lingua=" + $("#select-language2").val();
	$.get(url, function(data) {
		lingua = data
	});

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

	html += '&nbsp;<a class="btn btn-default" href="javascript:void(0)" onclick="finishTest()"><i class="fa fa-paper-plane"></i>&nbsp;Submit</a>'

	$("#skill-body").html(html);
	$("#skill-body").fadeIn("show");
}

function finishTest() {
	if (confirm("Do you want to submit the test?")) {

		var traduzione = document.getElementById("textarea").value;
		var linguaF = $("#select-language").val();
		var linguaT = $("#select-language2").val();
		var domanda = domande[0];
		var testo = domanda.Testo;

		var temp = {
			userId : sysIdUtente,
			testo : testo,
			linguaF : linguaF,
			linguaT : linguaT,
			tradu : traduzione	
		};
		var stringPass = JSON.stringify(temp);
		var data = stringPass
		$.ajax( {
			type : "POST",
			dataType : "application/json",
			contentType : "application/json; charset=utf-8",
			data : data,
			url : "rest.xsp?api=saveTranslation",
			complete : function(ret) {

				// clearTimeout(myTimer);
			// nowSeconds = 0;
			$('#skill-modal').modal('hide');
		},
		error : function(xhr) {
			if (xhr.status == 500) {
				showNotifica("danger", "Errore dal server");
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