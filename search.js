$(document).ready(function () {

});

//$.ajax( {
//type : "POST",
//dataType : "application/json",
//contentType : "application/json; charset=utf-8",
//data : data,
//url : "setJobOngoing.php",
//complete : function(ret) {
//var response=ret.responseText;
//$("#alertOK").html("Job finished!");
//$("#alertOK").fadeIn().delay(2000).fadeOut();
//$("#jobModal").hide();
//location.href=location.href;
//},
//error : function(xhr) {
//if (xhr.status == 500) {
//$("#alertError").html("Error from server, please retry.");
//$("#alertError").fadeIn().delay(1000).fadeOut();
//}

//}
//});

//}


angular.module("search",[]).controller("search",function(){
	var ctrl=this;

	ctrl.getClass=function(doc){
		return "primary";
	}

	ctrl.getToolTip=function(doc){
		return "";
	}

	ctrl.documents=[
		{
			"job":"ppp",
			"price":"oooo"
		}
		]

	ctrl.createTable=function(){
		var html="";
		html+='<table class="table table-responsive">';
		html+='<thead class="thead-default">';
		html+='<tr class="row">';
		html+='<th class="col-md-6" style="text-align:center;">Translator</th>';
		html+='<th class="col-md-6" style="text-align:center;">From</th>';
		html+='<th class="col-md-6" style="text-align:center;">To</th>';
		html+='<th class="col-md-6" style="text-align:center;">Field</th>';
		html+='<th class="col-md-6" style="text-align:center;">Rating</th>';
		html+='<th class="col-md-6" style="text-align:center;">Price</th>';
		html+='<th class="col-md-6" style="text-align:center;"></th>';
		html+='</tr>';
		html+='</thead>';
		for (var i = 0; i < ctrl.documents.length; i++) {
			var doc=ctrl.documents[i];
			html+='<tr class="row '+ctrl.getClass(doc)+'">';
			html+='<td class="col-md-6">'+doc.FirstName+doc.LastName+'</td>';
			html+='<td class="col-md-6">'+doc.IdMothertongue+'</td>';
			html+='<td class="col-md-6">'+doc.IdMothertongue+'</td>';
			html+='<td class="col-md-6">'+doc.Field+'</td>';
			html+='<td class="col-md-6">'+doc.Rating+'</td>';
			html+='<td class="col-md-6">';
			html+='<div class="price">';
			html+='<span class="money '+(doc.Price>=1?'filled':'')+'"><i class="fa fa-usd" aria-hidden="true" data-rating="1" onclick="alert("you pushed 1")"></i></span>';
			html+='<span class="money '+(doc.Price>=2?'filled':'')+'"><i class="fa fa-usd" aria-hidden="true" data-rating="2" onclick="alert("you pushed 2")"></i></span>';
			html+='<span class="money '+(doc.Price>=3?'filled':'')+'"><i class="fa fa-usd" aria-hidden="true" data-rating="3" onclick="alert("you pushed 3")"></i></span>';
			html+='</div>';
			html+='</td>';
			html+='<td class="col-md-6"></td>';
			html+='<tr>';
		}
		html+='</table>';
		$("#table").html(html);
	}

	ctrl.$onInit=function(){
		var url = "getTranslators.php?user=" + getUsername()+"&token="+getToken();

		var req = createXHTMLHttpRequest();
		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				var data=JSON.parse(req.responseText);
				ctrl.documents=data;
				ctrl.createTable();
				return(true);
			}else{
				mostraDialogTimed('errorPanel');
				return(false);
			}
		}
		req.open("GET",url,true);
		req.send();
	}
});



angular.element(document).ready(function() {
	console.log("registro search");
	angular.bootstrap(document.getElementById('search'), ['search']);
});
