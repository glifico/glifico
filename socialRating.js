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
	var id = "";
	var url = 'getTranslatorData.php?user='+ getUsername() + '&token=' + getToken();
	
	$.get(url, function(data) {
		 id = data[0].IdMothertongue;
	});
	
	var url = 'getLanguageById.php?user='+ getUsername() + '&token=' + getToken()+ '&id=' + id;
		$.get(url, function(language) {
			
			var html = "";
			html += '<select id="select-language" class="form-control">'
			html += '<option value="-"></option>'

			for (i = 0; i < data.length; i++) {
				html += '<option value="' + data[i].Id + '">'
					+ data[i].Language + '</option>'
			}
			
			html += '</select>'
			$('#span-combo-lingue').html(html);
		});
	
}

function getTesto() {
	$(document).ready(
			function() {
				showDomanda();
			});
}

function tryOut3() {
	
	started = false;
	outTime = false;
	nowSeconds = 0;
	var lan = $("#select-language").val();

	if (lan != null && lan != "-") {
		var html = "";
		$("#skill-body").html(html);
	}else{
		alert("Before select your mandatory tongue")
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
var ciao = "";
var url = "";

function showDomanda() {
	var t= "";
	var n= "";
	t += '<div align="right"> Show results per page &#160; '
	t += '<select id="select-res" onchange="cambiaPageSize()">'
	t +='<option value="10" '+(pageSize==10 ? 'selected' : '')+' > 10&#160;'
	t +='<option value="25" '+(pageSize==25 ? 'selected' : '')+' > 25&#160;'
	t +='<option value="50" '+(pageSize==50 ? 'selected' : '')+' > 50'
	t +='</select>'
	t +='</div>'
		
	$("#titolo").html(t);
	
//	if($("#select-res").val()== null){
//		n= 10;
//	}else{
//		n = $("#select-res").val();
//	}
	
	var gil= "";
	var fin = "";
	var num = "";
	var urll = "rest.xsp?api=getRatingAlreadyDo&utente=" + sysIdUtente;
	$.get(urll, function(dataf) {
		num = dataf[0].numRecords
		gil = dataf[0].risultati;
		for(var c=0 ; c<=num; c++){
			if(c<num){
			fin = "" + gil[c].IdTraduzione + ",";
			alert(g[c].IdTraduzione)
			}else if(c=num){
			fin = "" + gil[c].IdTraduzione
			}
		}
	});	
	
	url = "rest.xsp?api=getTextArea&lingua="+ $("#select-language").val() + "&page="+actualPage+"&num=" + pageSize + "&idUtente=" + sysIdUtente;
$.get(url, function(data) {
		var html = "";
		var titolo = "";
		html += '<table style="width:100%" class="table" text-align="center">';
		html += '<thead>';
		html += '	<tr valign="middle">';
		html += '		<th';
		html += '			style="text-align:center;width:25%;height:32px;background-color:#EFEFEF">Starting text</th>';
		html += '		<th';
		html += '			style="text-align:center;width:25%;height:32px;background-color:#EFEFEF">Translation</th>';
		html += '		<th';
		html += '			style="text-align:center;width:20%;height:32px;background-color:#EFEFEF">Execution Date</th>';
		html += '		<th';
		html += '			style="text-align:center;width:10%;height:32px;background-color:#EFEFEF">Language From</th>';
		html += '		<th';
		html += '			style="text-align:center;width:10%;height:32px;background-color:#EFEFEF">Language To</th>';
		html += '		<th';
		html += '			style="text-align:center;width:25%;height:32px;background-color:#EFEFEF">Open IT!</th>';
		html += '	</tr>';
		html += '</thead>';
		html += "</tbody>";
		var numRecords = data[0].numRecords;
		records = data[0].risultati;
		var size = records.length
		var maxpages = parseInt(numRecords/pageSize);
		var test = numRecords/pageSize;
		if (test<1) {
			maxpages=1
		}
		if (numRecords % pageSize != 0) {
			maxpages++;
		}
		if(numRecords<pageSize) {
			maxpages=1;
		}
		
		
		titolo += '<center><h3> Select the translations you intend to evaluate by pressing the button under the "selected" column and then click open to view the translation completely and evaluate it</h3></center>'
		
		/*var start = 1;
		var max = 10;
		if (actualPage!=1) {
			start = (pageSize*(actualPage-1))+1;
			max = start + pageSize;
		}*/
		
		var start = 1;
		var max = pageSize;
		if (max>records.length) {
			max = records.length
		}
		for(var x = start; x <=max; x++){
			//if ()
			var record = records[x-1];
			var data1 = record.Data
			data1 = data1.replace("T"," ")
			data1 = data1.replace("Z","")
			data1 = data1.substring(0,data1.length-13)
			var testo = record.TestoP
			testo = testo.slice(0,150);
			testo = testo;
			var traduzione = record.Traduzione
			traduzione = traduzione.slice(0,50);
			traduzione = traduzione;
			var lingua1 = record.Language
			var lingua2 = record.Expr2
			html += '<tr valign="middle">'
			html += '<td style="text-align:center;width:25%;height:42px;border-top:1px solid #EFEFEF;border-bottom:1px solid #EFEFEF;border-left:1px solid #EFEFEF;border-right:1px solid #EFEFEF"><font text-align="justify">' + testo + '<b> ...</b></font></td>'
			html += '<td style="text-align:center;width:25%;height:42px;border-top:1px solid #EFEFEF;border-bottom:1px solid #EFEFEF;border-left:1px solid #EFEFEF;border-right:1px solid #EFEFEF">' + traduzione + '<b> ...</b></td>'
			html += '<td style="text-align:center;width:20%;height:42px;border-top:1px solid #EFEFEF;border-bottom:1px solid #EFEFEF;border-left:1px solid #EFEFEF;border-right:1px solid #EFEFEF">' + data1 + '</td>'
			html += '<td style="text-align:center;width:10%;height:42px;border-top:1px solid #EFEFEF;border-bottom:1px solid #EFEFEF;border-left:1px solid #EFEFEF;border-right:1px solid #EFEFEF">' +  lingua1 + '</td>'
			html += '<td style="text-align:center;width:10%;height:42px;border-top:1px solid #EFEFEF;border-bottom:1px solid #EFEFEF;border-left:1px solid #EFEFEF;border-right:1px solid #EFEFEF">' +  lingua2 + '</td>'
			html += '<td style="text-align:center;width:25%;height:42px;border-top:1px solid #EFEFEF;border-bottom:1px solid #EFEFEF;border-left:1px solid #EFEFEF;border-right:1px solid #EFEFEF">'
			html += '<span class="reverse" style="top:14px;cursor:pointer">'
			idDomanda = record.Id;
			html += '<i class="fa fa-external-link style="font-size:10px" onclick="mostraingrande(' + record.Id + ')" aria-hidden="true"></i></span></td>'
			html += '</tr>'
		}
		html += '<br/>'
		html += "</table>";
		var combo = "";
		combo += '<select style="width:60px" id="combo-pagina" onChange="cambiaPagina()">';
		for (var p=1;p<=maxpages;p++) {
			var selected = "";
			if (p==actualPage) {
				selected = "selected"
			}
			combo += '<option '+selected+' value="' + p + '">' + p + '</option>';
		}
		combo+= '</select>'
		var pages= "Page " + combo +"&nbsp;/&nbsp;" + maxpages + ""
		$('#tabella').hide();
		$('#tabella').html(html)
		$('#tabella').fadeIn("slow");
		$('#page').html(pages)
		
});		
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
//			ht += '<label for="input-7-xs" class="control-label">Extra Small Rating</label>'
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
//	
//	$.get(ciao, function(data){
//	ht += '<div class="panel panel-default"><div class="panel-heading"> <font>' + data[f].TestoP
//	ht += '</font>  </div> </div>'
//	ht += '<div class="panel panel-default"><div class="panel-heading"> <font>' + data[f].Traduzione
//	ht += '</font>  </div> </div>'
//	});	
//	
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