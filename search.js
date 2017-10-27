$(document).ready(function () {

});


angular.module("search",[]).controller("search",function($scope){
	var ctrl=this;

	ctrl.getClass=function(doc){
		return "primary";
	}


	ctrl.loadLanguages = function(){
		var req=createXHTMLHttpRequest();
		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				var ret = convertJSON(req.responseText);
				ctrl.Languages=ret;
				ctrl.createForm();
				return(true);
			}else{
				return(false);
			}
		};

		req.open("GET","getLanguages.php",true);
		req.send();
	};

	ctrl.calculatePriceAg= function(priceClass,priceTr){
		var mb=ctrl.params.maxB;
		switch(priceClass){
		case 1:
			return (mb*ctrl.params.multA).toFixed(2);
			break;
		case 2:
			return (mb*ctrl.params.multB).toFixed(2);
			break;
		case 3:
			return (priceTr*ctrl.params.multC).toFixed(2);
			break;
		}
	}


	ctrl.createTable=function(){
		var html="";
		if (ctrl.documents.length>0){
			html+='<table class="table table-responsive">';
			html+='<thead class="thead-default">';
			html+='<tr class="row">';
			html+='<th class="col-md-2" style="text-align:center;">Translator</th>';
			html+='<th class="col-md-1" style="text-align:center;">Mothertongue</th>';
			html+='<th class="col-md-2" style="text-align:center;">Field</th>';
			html+='<th class="col-md-2" style="text-align:center;">Rating</th>';
			html+='<th class="col-md-2" style="text-align:center;">Price</th>';
			html+='<th class="col-md-2" style="text-align:center;"></th>';
			html+='</tr>';
			html+='</thead>';
			for (var i = 0; i < ctrl.documents.length; i++) {
				var doc=ctrl.documents[i];
				//doc.Price is class {1,2,3}
				//doc.PriceTr is Translator defined price for pair
				var priceAg = ctrl.calculatePriceAg(doc.Price, doc.PriceTr);
				html+='<tr class="row '+ctrl.getClass(doc)+'">';
				html+='<td class="col-md-2">'+doc.FirstName+doc.LastName+'</td>';
				html+='<td class="col-md-1">'+doc.Mothertongue+'</td>';
				html+='<td class="col-md-2">'+doc.Field+'</td>';
				html+='<td class="col-md-2">';
				html+='<div class="price">';
				html+='<span class="money '+(doc.Rating>=1?'filled':'')+'"><i  class="fa fa-star fa-fw" aria-hidden="true" data-rating="1"></i></span>';
				html+='<span class="money '+(doc.Rating>=2?'filled':'')+'"><i  class="fa fa-star fa-fw" aria-hidden="true" data-rating="2"></i></span>';
				html+='<span class="money '+(doc.Rating>=3?'filled':'')+'"><i  class="fa fa-star fa-fw" aria-hidden="true" data-rating="3"></i></span>';
				html+='<span class="money '+(doc.Rating>=4?'filled':'')+'"><i  class="fa fa-star fa-fw" aria-hidden="true" data-rating="4"></i></span>';
				html+='<span class="money '+(doc.Rating>=5?'filled':'')+'"><i  class="fa fa-star fa-fw" aria-hidden="true" data-rating="5"></i></span>';
				html+='</div>';
				html+='</td>';
				html+='<td class="col-md-2">';
				html+='<div class="price">';
				html+='<span class="money '+(doc.Price>=1?'filled':'')+'"><i class="fa fa-usd fa-fw" aria-hidden="true" data-rating="1"></i></span>';
				html+='<span class="money '+(doc.Price>=2?'filled':'')+'"><i class="fa fa-usd fa-fw" aria-hidden="true" data-rating="2"></i></span>';
				html+='<span class="money '+(doc.Price>=3?'filled':'')+'"><i class="fa fa-usd fa-fw" aria-hidden="true" data-rating="3"></i></span>';
				html+='</div>';
				html+='</td>';
				html+='<td class="col-md-2">';
				html+='<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#TrModal"';
				html+=' data-price="'+priceAg+'"';
				html+=' data-id="'+doc.id+'"';
				html+=' data-currency="'+"EUR - EURO"+'"';
				html+='>Select translator</button>';
				html+='</td>';
				html+='<tr>';
			}
			html+='</table>';
		}else{
			html+="No pair found for this search, please try another";
		}
		$("#table").html(html);
	}

	ctrl.setPrice=function(price){
		ctrl.selectedPrice=price;
	}

	ctrl.setRating=function(rat){
		if(ctrl.selectedRating==1){
			ctrl.selectedRating=0;
		}else{
			ctrl.selectedRating=rat;
		}
	}

	ctrl.createForm=function(){
		var html="";
		html+='<label>From: </label>';
		html+='<select id="select-from" placeholder="Translate from" data-ng-model="ctrl.from" required>';
		for(var i=0; i<ctrl.Languages.length; i++){
			var element=ctrl.Languages[i];
			html+='<option value="'+element.Id+'">'+element.Language+'</option>';
		}
		html+='</select>';
		$("#formleft").html(html);

		var html="";
		html+='<label>To: </label>';
		html+='<select id="select-to" placeholder="Translate from" data-ng-model="ctrl.to" required>';
		for(var i=0; i<ctrl.Languages.length; i++){
			var element=ctrl.Languages[i];
			html+='<option value="'+element.Id+'">'+element.Language+'</option>';
		}
		html+='</select>';
		$("#formcenter").html(html);

		ctrl.createFormRight();
	}

	ctrl.createFormRight=function(){

	}

	ctrl.search=function(){
		$("#table").html('<i class="fa fa-pulse fa-spin fa-4x fa-fw"></i>');

		var e = document.getElementById("select-to");
		ctrl.to = e.options[e.selectedIndex].text;

		var e = document.getElementById("select-from");
		ctrl.from = e.options[e.selectedIndex].text;

		var temp = {
				user: getUsername(),
				token: getToken(),
				from: ctrl.from,
				to: ctrl.to,
				price: ctrl.selectedPrice,
				rating: ctrl.selectedRating,
		};

		var stringPass = JSON.stringify(temp);
		var data = stringPass;

		$.ajax( {
			type : "POST",
			dataType : "application/json",
			contentType : "application/json; charset=utf-8",
			data : data,
			url : "getTranslators.php",
			complete : function(ret) {
				var response=ret.responseText;
				var data=convertJSON(response);
				ctrl.documents=data.data;
				ctrl.params=data.params;
				ctrl.createTable();
			},
			error : function(xhr) {
				if (xhr.status == 500) {
					$("#alertError").html("Error from server, please retry.");
					$("#alertError").fadeIn().delay(1000).fadeOut();
				}

			}
		});

	}

	ctrl.$onInit=function(){
		ctrl.selectedPrice=3;
		ctrl.selectedRating=0;
		ctrl.from="";
		ctrl.to="";
		ctrl.loadLanguages();

		ctrl.TrCharacters=0;
		ctrl.Trdeadline=null;
		ctrl.TrDay=new Date();
	}

});



angular.element(document).ready(function() {
	console.log("registro search");
	angular.bootstrap(document.getElementById('search'), ['search']);
});
