$(document).ready(function () {
	$("#selectedtable").hide();
});

var selectedTr=[
	{
		isSelected: false,
		price: 0,
		total: 0,
	},
	{
		isSelected: false,
		price: 0,
		total: 0,
	}
	];

getPriceDollars=function(price){
	var html="";
	html+='<div class="price">';
	html+='<span class="money '+(price>=1?'filled':'')+'"><i class="fa fa-usd fa-fw" aria-hidden="true" data-rating="1"></i></span>';
	html+='<span class="money '+(price>=2?'filled':'')+'"><i class="fa fa-usd fa-fw" aria-hidden="true" data-rating="2"></i></span>';
	html+='<span class="money '+(price>=3?'filled':'')+'"><i class="fa fa-usd fa-fw" aria-hidden="true" data-rating="3"></i></span>';
	html+='</div>';
	return html;
}

selectTr=function(name, price, priceTr, totalTr, rowIndex){	
	if(!selectedTr[0].isSelected){
		$("#rowN"+rowIndex).css('background-color', '#40bc99');


		selectedTr[0].isSelected=true;
		selectedTr[0].price=price;

		$("#selectedtable").show();
		var html="";
		html+=getPriceDollars(price);

		$("#firstPrice").html(html);
		$("#firstName").html(name);
	}else if(!selectedTr[1].isSelected){
		$("#rowN"+rowIndex).css('background-color', '#40bc99');

		selectedTr[1].isSelected=true;
		selectedTr[1].price=price;

		var html="";
		html+=getPriceDollars(price);

		$("#secondPrice").html(html);
		$("#secondName").html(name);
	}
};

angular.module("search",[]).controller("search",function($scope){
	var ctrl=this;

	ctrl.getClass=function(doc){
		return "primary";
	}

	ctrl.initForm=function(){
		ctrl.loadLanguages();
	}

	ctrl.loadLanguages = function(){
		var req=createXHTMLHttpRequest();
		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				var ret = convertJSON(req.responseText);
				ctrl.Languages=ret;
				ctrl.loadFields();
				return(true);
			}else{
				return(false);
			}
		};

		req.open("GET","getLanguages.php",true);
		req.send();
	}

	ctrl.loadFields = function(){
		var req=createXHTMLHttpRequest();
		req.onreadystatechange = function(){
			if (req.status == 200&req.readyState==4){
				var ret = convertJSON(req.responseText);
				ctrl.Fields=ret;
				ctrl.createForm();
				return(true);
			}else{
				return(false);
			}
		};

		req.open("GET","getFields.php",true);
		req.send();
	}

	ctrl.selectTr=function(){
		console.log("selected");
	}

	ctrl.firstIsSelected=function(){
		return $scope.IsFirstSelected;
	}
	ctrl.secondIsSelected=function(){
		return $scope.IsSecondSelected;
	}

	ctrl.calculatePriceAg= function(priceClass,priceTr){
		var mb=ctrl.params.maxB;
		switch(priceClass){
		case 1:
			ctrl.priceAg = (mb*ctrl.params.multA).toFixed(2);
			break;
		case 2:
			ctrl.priceAg = (mb*ctrl.params.multB).toFixed(2);
			break;
		case 3:
			ctrl.priceAg = (priceTr*ctrl.params.multC).toFixed(2);
			break;
		}
		console.log(ctrl.priceAg);
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
				var name=doc.FirstName+doc.LastName;
				html+='<tr id="rowN'+i+'" class="row '+ctrl.getClass(doc)+'">';
				html+='<td class="col-md-2">'+name+'</td>';
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
				name="'"+name+"'";
				html+='<button type="button" class="btn btn-primary btn-sm" onclick="selectTr('+name+','+doc.Price+','+doc.PriceTr+','+i+','+i+')">Select translator</button>';
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
		html+='<select id="select-from" placeholder="Translate from" required>';
		for(var i=0; i<ctrl.Languages.length; i++){
			var element=ctrl.Languages[i];
			html+='<option value="'+element.Id+'">'+element.Language+'</option>';
		}
		html+='</select>';
		html+="<br>";
		html+='<label>To: </label>';
		html+='<select id="select-to" placeholder="Translate to" required>';
		for(var i=0; i<ctrl.Languages.length; i++){
			var element=ctrl.Languages[i];
			html+='<option value="'+element.Id+'">'+element.Language+'</option>';
		}
		html+='</select>';
		$("#formleft").html(html);

		var html="";
		html+='<label>Field: </label>';
		html+='<select id="select-field" placeholder="Field">';
		for(var i=0; i<ctrl.Fields.length; i++){
			var element=ctrl.Fields[i];
			html+='<option value="'+element.Id+'"';
			if(element.Id==97){
				html+=' selected="selected"';
			}
			html+='>'+element.Field+'</option>';
		}
		html+='</select>';
		$("#formcenter").html(html);

	}

	ctrl.search=function(){
		$("#table").html('<i class="fa fa-pulse fa-spin fa-4x" aria-hidden="true"></i>');

		var e = document.getElementById("select-to");
		ctrl.to = e.options[e.selectedIndex].text;

		var e = document.getElementById("select-from");
		ctrl.from = e.options[e.selectedIndex].text;

		var e = document.getElementById("select-field");
		ctrl.field = e.options[e.selectedIndex].text;

		var temp = {
				user: getUsername(),
				token: getToken(),
				from: ctrl.from,
				to: ctrl.to,
				price: ctrl.selectedPrice,
				rating: ctrl.selectedRating,
				field: ctrl.field,
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

	ctrl.calcultateFeasibility=function(){
		var timeDiff = Math.abs(ctrl.TrDeadline.getTime() - ctrl.today.getTime());
		var days = Math.ceil(timeDiff / (1000 * 3600 * 24));
		ctrl.MaxCh=days*10000;
		ctrl.UrgCh=days*8500;
		ctrl.days=days;
		if(ctrl.TrCharacters>=ctrl.MaxCh) {
			ctrl.feasibility=2;
			ctrl.feasibilityBack="red";
			ctrl.feasibilityColor="#FFF";
			$("#feasibility").html("Job too Demanding, please posticipate deadline");
		}else	if(ctrl.TrCharacters>=ctrl.UrgCh){
			ctrl.feasibility=1;
			ctrl.feasibilityBack="orange";
			ctrl.feasibilityColor="#FFF";
			$("#feasibility").html("Job will be set as urgent");
		}else{
			ctrl.feasibility=0;
			ctrl.feasibilityBack="red";
			ctrl.feasibilityColor="#FFF";
			$("#feasibility").html("");
		}
	}

	ctrl.startJob=function(){

	}

	ctrl.$onInit=function(){
		ctrl.selectedPrice=3;
		ctrl.selectedRating=0;
		ctrl.from="";
		ctrl.to="";
		ctrl.field="";
		ctrl.initForm();

		ctrl.TrCharacters=0;
		ctrl.priceAg=0;
		ctrl.today=new Date();
		ctrl.tomorrow=new Date(ctrl.today.getTime() + 24 * 60 * 60 * 1000);
		ctrl.TrDeadline=ctrl.tomorrow;
	}

});



angular.element(document).ready(function() {
	console.log("registro search");
	angular.bootstrap(document.getElementById('search'), ['search']);
});
