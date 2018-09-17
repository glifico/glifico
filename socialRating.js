var started = false;
var maxSeconds = 600;
var nowSeconds = 0;
var outTime = false;
var myTimer;
var downloadeddata = [];
var next = false;
var records;

$.ajaxSetup( {
	async : false
});

$(document).ready( function() {
	init();
});

function init() {
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

		html='';
		html='You have a total of <b>'+data[0].nratings+'</b> ratings!';
		$("#totalratings").html(html);

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
			showDomanda();

		}else{
			alert("Before test please select your mandatory tongue")
			return;
		}
		startTest();
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
		var e = document.getElementById("select-language");
		var langF = e.options[e.selectedIndex].text;

		var url = 'getRatingTestToEvalutate.php?user='+ getUsername() + '&token=' + getToken()+ '&langF=' + langF;

		var req = createXHTMLHttpRequest() ;
		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				var data=JSON.parse(req.responseText);
				if(data.statuscode==200){
					showModal(data);
					return(true);
				}else if(data.statuscode==303){
					alert("Nothing to evaluate yet for this language, sorry..");
				}
			}else{
				$("#alertError").html("Nothing to evaluate yet, try later");
				$("#alertError").fadeIn().delay(10000).fadeOut();
				return(false);
			}
		}

		req.open("GET", url, true);
		req.send();

	}


	function showModal(data){
		downloadeddata = data;
		var html="";
		html+='<div>';

		html+='<h4>This was a translation from <b>' + data.LanguageF + '</b> to <b>' + data.LanguageT + '</b></h4>';
		html+='<span class="modal-text">' + data.OriginalText + '</span>';
		html+='<h5>' + 'It was translated as follows' + '</h5>';
		html+='<span class="modal-text">' + data.TranslatedText + '</span>';

		html+="<br><h4>You're asked to evaluate grammar and style</h4>";

		html+='</div>';
		html+='Grammar <b>mark</b>'
		html+='<div class="rating">';
		for (var i = 5; i > 0; i--) {
			html+='<span id="grammar'+ i +'" class="money"><i  class="fa fa-star fa-2x fa-fw" aria-hidden="true" data-rating="'+i+'" onclick="setRating(0,'+i+')"></i>   </span>';
		}
		html+='</div>';
		html+='Style <b>mark</b>'
		html+='<div class="rating">';
		for (var i = 5; i > 0; i--) {
			html+='<span id="style'+ i +'" class="money"><i  class="fa fa-star fa-2x fa-fw" aria-hidden="true" data-rating="'+i+'" onclick="setRating(1,'+i+')"></i>   </span>';
		}
		html+='</div>';
		html+='<br><br>';
		html+='<div id="bar-progress" class="progress"></div>';
		html+='<span id="rimanente"></span>';
		$("#skill-body").html(html);
		$('#skill-modal').modal('show');
	}


	var ratings={
		grammar: -1,
		style: -1,
	}

	function setRating(whichRating, mark){
		if(whichRating==0) {
			ratings.grammar=mark;
			for (var i = 1; i <=5; i++) {
				if(i<=mark){
					$("#grammar"+i).addClass('filled');
				}else{
					$("#grammar"+i).removeClass('filled');
				}
			}
		}
		else if(whichRating==1) {
			ratings.style=mark;
			for (var i = 1; i <=5; i++) {
				if(i<=mark){
					$("#style"+i).addClass('filled');
				}else{
					$("#style"+i).removeClass('filled');
				}
			}
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
		+ '%">';
		html += "</div>";

		$("#bar-progress").html(html);
		$("#rimanente").html("Seconds remaining: " + (maxSeconds - nowSeconds));

	}


	function finishTest() {
		console.log(ratings);
		console.log(data);


		if (confirm("Do you want to save the Rating?")) {

			var temp = {
				user : getUsername(),
				token: getToken(),
				downloadeddata : downloadeddata,
				ratings : ratings,
			};

			var stringPass = JSON.stringify(temp);
			var data = stringPass
			$.ajax( {
				type : "POST",
				dataType : "application/json",
				contentType : "application/json; charset=utf-8",
				data : data,
				url : "saveRatingEvaluation.php",
				complete : function(ret) {
					clearTimeout(myTimer);
					nowSeconds = 0;
					notify("Thank you for your precious rating!");
					$('#skill-modal').modal('hide');
					$('#congratulations').show();
					$("#alertOK").html("Rating stored correctly, thank you");
					$("#alertOK").fadeIn().delay(5000).fadeOut();
				},
				error : function(xhr) {
					if (xhr.status == 500) {
						notify("Error from server");
					}

				}
			});
		}
	}
