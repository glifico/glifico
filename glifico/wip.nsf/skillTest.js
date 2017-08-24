var maxpages=2;
var actualPage = 0;
var started = false;
var maxSeconds = 600;
var nowSeconds = 0;
var outTime = false;
var myTimer;
var domande = 
[
	{
		title:"Domanda 1'",
		risposte:[
		          {
		        	  risposta:"Risposta A",
		        	  scelta:false
		          },
		          {
		        	  risposta:"Risposta B",
		        	  scelta:false
		          },
		          {
		        	  risposta:"Risposta C",
		        	  scelta:false
		          }
		          ]
	},
	{
		title:"Domanda 2'",
		risposte:[
		          {
		        	  risposta:"Risposta A",
		        	  scelta:false
		          },
		          {
		        	  risposta:"Risposta B",
		        	  scelta:false
		          },
		          {
		        	  risposta:"Risposta C",
		        	  scelta:false
		          }
		          ]
	},
	{
		title:"Domanda 3'",
		risposte:[
		          {
		        	  risposta:"Risposta A",
		        	  scelta:false
		          },
		          {
		        	  risposta:"Risposta B",
		        	  scelta:false
		          },
		          {
		        	  risposta:"Risposta C",
		        	  scelta:false
		          }
		          ]
	}
]

function tryOut() {
	started = false;
	outTime = false;
	nowSeconds = 0;
	var lan = $("#select-language").val();
	if (lan != null && lan  != "-") {
		var html = "";
		html = 'Are you ready?<br /><a class="btn btn-default" href="javascript:void(0)" onClick="startTest()">Go!</a>'
		$("#skill-body").html(html);
		$('#skill-modal').modal('show');
	}
}
function startTest() {
	actualPage = 1;
	if (!started) {
		started = true;
		myTimer = setInterval(mioTimer, 1000)
	}
	showDomanda();
}
function mioTimer() {
	nowSeconds++;
	if (nowSeconds>=maxSeconds) {
		clearTimeout(myTimer);
		outTime = true;
		showDomanda();
	}
	getProgress();
}
function showDomanda() {
	
	$("#skill-body").hide();
	var html = "";
	var domanda = domande[actualPage-1];
	html += "<p><form id=\"myForm\">";
	html += domanda.title;
	html += "<br />"
	for (i=0;i<domanda.risposte.length;i++) {
		var risposta = domanda.risposte[i]
		var selected = "";
		var disabled = "";
		if (outTime) {
			disabled = "disabled"
		}
		if (risposta.scelta) {
			selected = 'checked="checked"';
		}
		html += '<input '+disabled+' '+selected+' type="radio" name="domanda_'+(actualPage-1)+'" value="'+(i)+'">&nbsp;'+risposta.risposta+'<br>'
	}
	prev = true;
	next = true;
	last = false;
	if (actualPage==1) {
		prev = false;
	}
	if (actualPage == domande.length) {
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
	if (started) {
		html += '<span id="rimanente"></span>';
	}
	if (outTime) {
		html += '<div style="text-align:center;width:100%"><span id="scaduto" style="font-weight:bold;font-color:red>Tempo scaduto</span></div>'
	}
	$("#skill-body").html(html);
	$("#skill-body").fadeIn("slow");
	
	getProgress();
}

function finishTest() {
	if (confirm("Do you want to submit the test?")) {
		clearTimeout(myTimer);
		nowSeconds = 0;
		$('#skill-modal').modal('hide');
	}
}

function nextDomanda() {
	var selezionato = $('input[name=domanda_'+(actualPage-1)+']:checked', '#myForm').val();
	if (selezionato != undefined) {
		domande[actualPage-1].risposte[parseInt(selezionato)].scelta = true;
	}
	actualPage++;
	showDomanda();
}
function prevDomanda() {
	var selezionato = $('input[name=domanda_'+(actualPage-1)+']:checked', '#myForm').val();
	if (selezionato != undefined) {
		domande[actualPage-1].risposte[parseInt(selezionato)].scelta = true;
	}
	actualPage--;
	if (actualPage<1)
		actualPage=1;
	showDomanda();
}

function getProgress() {
	var html = "";
	
	html += '<div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="'+nowSeconds+'" aria-valuemin="0" aria-valuemax="'+maxSeconds+'" style="width: '+parseInt((nowSeconds*100)/maxSeconds)+'%">'
	html +="</div>"
	
	$("#bar-progress").html(html);
	$("#rimanente").html("Secondi rimanenti: " + (maxSeconds-nowSeconds))
	
}