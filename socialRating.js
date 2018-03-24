var maxpages = 0;
var actualPage = 1;
var pageSize = 10;
var started = false;
var maxSeconds = 600;
var nowSeconds = 0;
var outTime = false;
var myTimer;
var data = [];
var lingua = [];
var next = false;
var records;
var idDomanda;

$.ajaxSetup( {
	async : false
});

$(document).ready( function() {
	init();
});

function init() {
	console.debug("init!");

	var id = "";
	var url = 'getTranslatorData.php?user='+ getUsername() + '&token=' + getToken();

	var req = createXHTMLHttpRequest() ;
	req.onreadystatechange = function(){
		if (req.status == 200&req.readyState==4){
			var data=JSON.parse(req.responseText);
			gotTranslatorData(data);
			return(true);
		}else{
			mostraDialogTimed('errorPanel');
			return(false);
		}
	}

	req.open("GET", url, true);
	req.send();

	function gotTranslatorData(data){

		var id = data[0].IdMothertongue;
		var url = 'getLanguageById.php?user='+ getUsername() + '&token=' + getToken()+ '&id=' + id;


		var req = createXHTMLHttpRequest() ;
		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				var data=JSON.parse(req.responseText);
				createSpan(data);
				return(true);
			}else{
				mostraDialogTimed('errorPanel');
				return(false);
			}
		}

		req.open("GET", url, true);
		req.send();

	}

	function createSpan(data){
		var html = "";
		html += '<select id="select-language" class="form-control">'
			html += '<option value="-"></option>'

				for (i = 0; i < data.length; i++) {
					html += '<option value="' + data[i].Id + '">'
					+ data[i].Language + '</option>'
				}

		html += '</select>'
			$('#span-combo-lingue').html(html);
	}

}

function getTesto() {
	$(document).ready(
			function() {
				showDomanda();
			});
}

function tryOut() {

	started = false;
	outTime = false;
	nowSeconds = 0;
	var lan = $("#select-language").val();

	if (lan != null && lan != "-") {
		var html = "";
		$("#skill-body").html(html);
		$("#modal-body").fadeIn("show");
		console.debug('tryout');
		showDomanda();
		
	}else{
		alert("Before test please select your mandatory tongue")
		return;
	}
	startTest();
}

function startTest() {
	getTesto();
	actualPage = 1;
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
	console.debug('showdomanda');
	
	var e = document.getElementById("select-language");
	var langF = e.options[e.selectedIndex].text;

	var url = 'getRatingTestToEvalutate.php?user='+ getUsername() + '&token=' + getToken()+ '&langF=' + langF;

	var req = createXHTMLHttpRequest() ;
	req.onreadystatechange = function(){
		if (req.status == 200&req.readyState==4){
			var data=JSON.parse(req.responseText);
			if(data.statuscode==503){
				alert("Nothing yet for this language, sorry");
				return false
			}else{
				showModal(data);	
			}
			return(true);
		}else{
			mostraDialogTimed('errorPanel');
			return(false);
		}
	}

	req.open("GET", url, true);
	req.send();

}

function showModal(data){
	console.debug('showmodal');
	console.debug(data);

	var html="";
	html+='<div>';

	html='testtest';
	html+='</div>';

	$("#modal-body").html(html);
	$("#skill-body").fadeIn("show");
}


function cambiaPagina() {
	var newPage = $("#combo-pagina").val();
	if (actualPage != newPage) {
		actualPage = newPage;
		showDomanda();
	}
}

function cambiaPageSize() {
	var newSize = $("#select-res").val();
	if (pageSize != newSize) {
		pageSize = newSize;
		showDomanda();
	}
}


function mostraingrande(x){

	var ht ="";
	for (var i=0;i<records.length;i++) {
		if (records[i].Id==x) {
			idDomanda= records[i].Id;
			ht += '<div class="panel panel-default">'
				ht += '  <div class="panel-heading">'
					ht += '    <font>' + records[i].TestoP + '</font>'
					ht += '  </div>'
						ht += '</div>'
							ht += '<div class="panel panel-default">'
								ht += '  <div class="panel-heading">'
									ht += '    <font>' + records[i].Traduzione+' </font>'
//									ht += '<label for="input-7-xs" class="control-label">Extra Small Rating</label>'
									ht += '<div style="text-align:center"><input id="input-rate" class="rating rating-loading" value="0" data-min="0" data-max="5" data-step="0.5" data-size="xs"></div>'
										ht += '<script>'
											ht += '$("#input-rate").rating({showCaption:false,emptyStar:\'<i class="fa fa-star-o"></i>\',filledStar:\'<i class="fa fa-star"></i>\',showClear:false});'
												ht += '</script>'
													ht += '  </div>'
														ht += '</div>'
		}
	}
	$('#skill-modal').modal('show');
	$("#skill-body").html(ht);

//	ciao = url
//	var f = x;
//	var ht ="";

//	$.get(ciao, function(data){
//	ht += '<div class="panel panel-default"><div class="panel-heading"> <font>' + data[f].TestoP
//	ht += '</font>  </div> </div>'
//	ht += '<div class="panel panel-default"><div class="panel-heading"> <font>' + data[f].Traduzione
//	ht += '</font>  </div> </div>'
//	});	

//	$('#skill-modal').modal('show');
//	$("#skill-body").html(ht);
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
	$("#rimanente").html("Seconds remaining: " + (maxSeconds - nowSeconds));

}
function finishTest() {
	//alert($("#input-rate").val())
	if (confirm("Do you want to save the Rating?")) {

		var valutazione = $("#input-rate").val(); 
		var domanda = idDomanda;
		var temp = {
				valutatoreid : sysIdUtente,
				idtrad : domanda,
				punteggio : valutazione
		};

		var stringPass = JSON.stringify(temp);
		var data = stringPass
		$.ajax( {
			type : "POST",
			dataType : "application/json",
			contentType : "application/json; charset=utf-8",
			data : data,
			url : "rest.xsp?api=saveRating",
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
		showDomanda();
	}
}