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


angular.module("search",[]).controller("search",function($scope){
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
		];

	ctrl.loadLanguages = function(){
		var req=createXHTMLHttpRequest();
		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				var ret = convertJSON(req.responseText);
				ctrl.Languages=ret;
			}
		}

		req.open("GET","getLanguages.php",true);
		req.send();
	};

	ctrl.createTable=function(){
		var html="";
		html+='<table class="table table-responsive">';
		html+='<thead class="thead-default">';
		html+='<tr class="row">';
		html+='<th class="col-md-2" style="text-align:center;">Translator</th>';
		html+='<th class="col-md-1" style="text-align:center;">From</th>';
		html+='<th class="col-md-1" style="text-align:center;">To</th>';
		html+='<th class="col-md-2" style="text-align:center;">Field</th>';
		html+='<th class="col-md-2" style="text-align:center;">Rating</th>';
		html+='<th class="col-md-2" style="text-align:center;">Price</th>';
		html+='<th class="col-md-2" style="text-align:center;"></th>';
		html+='</tr>';
		html+='</thead>';
		for (var i = 0; i < ctrl.documents.length; i++) {
			var doc=ctrl.documents[i];
			html+='<tr class="row '+ctrl.getClass(doc)+'">';
			html+='<td class="col-md-2">'+doc.FirstName+doc.LastName+'</td>';
			html+='<td class="col-md-1">'+doc.IdMothertongue+'</td>';
			html+='<td class="col-md-1">'+doc.IdMothertongue+'</td>';
			html+='<td class="col-md-2">'+doc.Field+'</td>';
			html+='<td class="col-md-3">'+doc.Rating+'</td>';
			html+='<td class="col-md-2">';
			html+='<div class="price">';
			html+='<span class="money '+(doc.Price>=1?'filled':'')+'"><i class="fa fa-usd" aria-hidden="true" data-rating="1" onclick="alert("you pushed 1")"></i></span>';
			html+='<span class="money '+(doc.Price>=2?'filled':'')+'"><i class="fa fa-usd" aria-hidden="true" data-rating="2" onclick="alert("you pushed 2")"></i></span>';
			html+='<span class="money '+(doc.Price>=3?'filled':'')+'"><i class="fa fa-usd" aria-hidden="true" data-rating="3" onclick="alert("you pushed 3")"></i></span>';
			html+='</div>';
			html+='</td>';
			html+='<td class="col-md-2"></td>';
			html+='<tr>';
		}
		html+='</table>';
		$("#table").html(html);
	}

	ctrl.setPrice=function(price){
		ctrl.selectedPrice=price;
	}

	ctrl.setRating=function(rat){
		ctrl.selectedPrice=rat;
	}
	
	ctrl.createForm=function(){
		var html="";
		html+='<label>From: </label>';
		html+='<select placeholder="Translate from" required>';
		for(var i=0; i<ctrl.Languages.length; i++){
			var element=ctrl.Languages[i];
			html+='<option value="'+element.Id+'">'+element.Language+'</option>';
		}
		html+='</select>';
		$("#formleft").html(html);

		var html="";
		html+='<label>To: </label>';
		html+='<select placeholder="Translate from" required>';
		for(var i=0; i<ctrl.Languages.length; i++){
			var element=ctrl.Languages[i];
			html+='<option value="'+element.Id+'">'+element.Language+'</option>';
		}
		html+='</select>';
		$("#formcenter").html(html);

		ctrl.createFormRight();
	}

	ctrl.createFormRight=function(){
		var html="";
		html+='<div class="rating">';
		for (var i=5; i>=1; i--){
			var classFilled='{{ctrl.selectedRating>='+i+'?"filled":""}}';
			html+='<span class="money'+classFilled+' "><i  class="fa fa-star fa-3x" aria-hidden="true" data-rating="'+i+'" data-ng-click="ctrl.setRating('+i+')"></i></span>';
		}
		html+='</div>';
		$("#formRating").html(html);
	}
	
	ctrl.search=function(){
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

	ctrl.$onInit=function(){
		ctrl.selectedPrice=0;
		ctrl.selectedRating=-1;

		ctrl.loadLanguages();
		ctrl.createForm();
	}
	
});



angular.element(document).ready(function() {
	console.log("registro search");
	angular.bootstrap(document.getElementById('search'), ['search']);
});
