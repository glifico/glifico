$(document).ready(function () {
	$("#selectedtable").hide();
	$("#fieasibility").hide();
});


var client = filestack.init('AY86cSRLQTreZccdDlJimz',{
	policy: "eyJoYW5kbGUiOiIiLCJleHBpcnkiOjE1MDYxNjEyMDh9=",
})

var jobUploaded=false;
var urlUploaded="";

showPicker=function() {
	client.pick({
		accept: ['.pdf','.odt','.doc','.docx','.txt'],
		maxFiles: 1,
		onClose(){

		}
	}).then(function(result) {
		notify("Document uploaded");
		jobUploaded=true;
		urlUploaded=result.filesUploaded[0]["url"];
		$("#spanUpload").html('<i class="fa fa-check" aria-hidden="true"></i>');
		$(".btn-upload").prop("disabled",true);
	},function(result){
		alert("Error while uploading");
	});

};


var selectedTr=[
	{
		name:"",
		id:-1,
		isSelected: false,
		price: -1,
		total: -1,
		currency: "EUR - EURO",
		rowIndex: -1,
		rowColor:"#FEC538",
	},
	{
		name:"",
		id:-1,
		isSelected: false,
		price: -1,
		total: -1,
		currency: "EUR - EURO",
		rowIndex: -1,
		rowColor:"#FE434D",
	}
	]

var maximumSelectable=2;

getPriceDollars=function(price){
	var html="";
	html+='<div class="price">';
	html+='<span class="money '+(price>=1?'filled':'')+'"><i class="fa fa-usd fa-fw" aria-hidden="true" data-rating="1"></i></span>';
	html+='<span class="money '+(price>=2?'filled':'')+'"><i class="fa fa-usd fa-fw" aria-hidden="true" data-rating="2"></i></span>';
	html+='<span class="money '+(price>=3?'filled':'')+'"><i class="fa fa-usd fa-fw" aria-hidden="true" data-rating="3"></i></span>';
	html+='</div>';
	return html;
}

selectTr=function(id, name, price, priceTr, totalTr, rowIndex){
	$("#btnRowN"+rowIndex).prop("disabled",true);
	if(!selectedTr[0].isSelected){
		$("#rowN"+rowIndex).css('background-color', selectedTr[0].rowColor);
		$("#fieasibility").show();

		selectedTr[0].isSelected=true;
		selectedTr[0].price=price;
		selectedTr[0].total=totalTr;
		selectedTr[0].rowIndex=rowIndex;
		selectedTr[0].name=name;
		selectedTr[0].id=id;

		$("#selectedtable").show();
		$("#selectedRow1").show();
		$("#selectedRow2").hide();
		var html="";
		html+=getPriceDollars(price);

		$("#selectedPrice1").html(html);
		$("#selectedName1").html(name);
	}else if(!selectedTr[1].isSelected){
		$("#rowN"+rowIndex).css('background-color', selectedTr[1].rowColor);
		$("#selectedRow2").show();
		$(".selectTrBtn").prop("disabled",true);

		selectedTr[1].isSelected=true;
		selectedTr[1].price=price;
		selectedTr[1].total=totalTr;
		selectedTr[1].rowIndex=rowIndex;
		selectedTr[1].name=name;
		selectedTr[1].id=id;

		var html="";
		html+=getPriceDollars(price);

		$("#selectedPrice2").html(html);
		$("#selectedName2").html(name);
	}
}

deselectTr=function(tr){
	$(".selectTrBtn").prop("disabled",false);
	$("#rowN"+selectedTr[tr-1].rowIndex).css('background-color', '');

	if(tr==1){
		selectedTr[tr-1].isSelected=selectedTr[tr].isSelected;
		selectedTr[tr-1].price=selectedTr[tr].price;
		selectedTr[tr-1].total=selectedTr[tr].total;
		selectedTr[tr-1].rowIndex=selectedTr[tr].rowIndex;
		selectedTr[tr-1].name=selectedTr[tr].name;
		selectedTr[tr-1].id=selectedTr[tr].id;

		var html="";
		html+=getPriceDollars(selectedTr[tr-1].price);
		html+='     ';
		html+=selectedTr[tr-1].total+' Euro/ch';

		$("#selectedPrice1").html(html);
		$("#selectedName1").html(selectedTr[tr-1].name);
		$("#rowN"+selectedTr[tr-1].rowIndex).css('background-color',selectedTr[tr-1].rowColor);


		selectedTr[tr].isSelected=false;
		selectedTr[tr].price=-1;
		selectedTr[tr].total=-1;
		selectedTr[tr].rowIndex=-1;
		selectedTr[tr].id=-1;

		$("#selectedRow"+2).hide();

		$("#selectedPrice"+2).html("");
		$("#selectedName"+2).html("");
	}else{
		selectedTr[tr-1].isSelected=false;
		selectedTr[tr-1].price=-1;
		selectedTr[tr-1].total=-1;
		selectedTr[tr-1].rowIndex=-1;
		selectedTr[tr-1].id=-1;


		$("#selectedRow"+2).hide();

		$("#selectedPrice"+2).html("");
		$("#selectedName"+2).html("");
	}

	refreshButtons();
}

refreshButtons=function(){
	for (var i=1; i<=maximumSelectable;i++){
		$("#btnRowN"+selectedTr[i-1].rowIndex).prop("disabled",selectedTr[i-1].isSelected);
	}
	if(countSelected()<=0) $("#selectedtable").hide();;
}

countSelected=function(){
	var counter=0;
	for (var i=0; i<maximumSelectable;i++){
		if(selectedTr[i].isSelected) counter++;
	}
	return counter;
}

getAgPrice=function(tr){
	return selectedTr[tr-1].total;
}

isSelected=function(n){
	return selectedTr[n-1].isSelected;
}

resetTr=function(){
	$(".selectTrBtn").prop("disabled",false);

	for(var i=1; i<= maximumSelectable; i++){
		$("#rowN"+selectedTr[i-1].rowIndex).css('background-color', '');
		selectedTr[i-1].isSelected=false;
		selectedTr[i-1].price=-1;
		selectedTr[i-1].total=-1;
		$("#selectedPrice"+i).html("");
		$("#selectedName"+i).html("");
	}

	$("#fieasibility").hide();
	$("#selectedtable").hide();
}

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


	ctrl.firstIsSelected=function(){
		return $scope.IsFirstSelected;
	}
	ctrl.secondIsSelected=function(){
		return $scope.IsSecondSelected;
	}

	ctrl.calculatePriceAg = function(priceClass,priceTr){
		var mb=ctrl.params.maxB;
		switch(priceClass){
		case 1:
			toReturn = (mb*ctrl.params.multA).toFixed(2);
			break;
		case 2:
			toReturn = (mb*ctrl.params.multB).toFixed(2);
			break;
		case 3:
			toReturn = (priceTr*ctrl.params.multC).toFixed(2);
			break;
		}

		return toReturn;
	}

	ctrl.getAgPrice=function(tr){
		return getAgPrice(tr);
	}

	ctrl.createPopOverForUser= function(user){
		var html='';
		html='<a href="#"';
		//html+='<button type="button" class="btn btn-secondary"';
		html+='data-container="body" data-toggle="popover" data-placement="right" data-trigger="focus" ';
		html+='data-title=" '+user.FirstName+user.LastName+user.Id+'" ';
		html+='data-content=" ';
		html+='mothertongue: '+user.Mothertongue+'</br>';
		html+='" >';
		html+='<i class="fa fa-info-circle"></i>';
		html+='</a>';
		return html;
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
				var name=doc.FirstName+doc.LastName+doc.Id;
				var priceAg=ctrl.calculatePriceAg(doc.Price,doc.PriceTr);
				html+='<tr id="rowN'+i+'" class="row '+ctrl.getClass(doc)+'">';
				html+='<td class="col-md-2">'+ctrl.createPopOverForUser(doc)+' '+name+'</td>';
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
				html+='<button id="btnRowN'+i+'" type="button" class="btn btn-primary btn-sm selectTrBtn" onclick="selectTr('+doc.Code+','+name+','+doc.Price+','+doc.PriceTr+','+priceAg+','+i+')">Select translator</button>';
				html+='</td>';
				html+='<tr>';
			}
			html+='</table>';
		}else{
			html+="No pair found for this search, please try another";
		}
		$("#table").html(html);
		$('[data-toggle="popover"]').popover({
			container: 'body',
			html: true,
		});
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
		html+='<label>translate from: </label>';
		html+='<select id="select-from" placeholder="Translate from" required>';
		for(var i=0; i<ctrl.Languages.length; i++){
			var element=ctrl.Languages[i];
			html+='<option value="'+element.Id+'">'+element.Language+'</option>';
		}
		html+='</select>';
		$("#formfrom").html(html);
		html='';
		html+='<label>translate to: </label>';
		html+='<select id="select-to" placeholder="Translate to" required>';
		for(var i=0; i<ctrl.Languages.length; i++){
			var element=ctrl.Languages[i];
			html+='<option value="'+element.Id+'">'+element.Language+'</option>';
		}
		html+='</select>';
		$("#formto").html(html);

		var html="";
		html+='<label>Field: </label>';
		html+='<select id="select-field" placeholder="Field">';
		for(var i=0; i<ctrl.Fields.length; i++){
			var element=ctrl.Fields[i];
			html+='<option value="'+element.Id+'"';			
			html+='>'+element.Field+'</option>';
		}
		html+='<option value="'+ctrl.Fields.length+'"';
		html+=' selected="selected"';
		//select all trigger query on all parameters
		//remember to modify getTranslator.php if something changes here
		html+='>'+"select all"+'</option>';
		html+='</select>';
		$("#formcenter").html(html);

	}

	ctrl.search=function(){
		$("#table").html('<i class="fa fa-spinner fa-pulse fa-3x fa-fw" aria-hidden="true"></i>');
		resetTr();
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

	ctrl.calculateFeasibility=function(){
		var timeDiff = ctrl.TrDeadline.getTime() - ctrl.today.getTime();
		var days = Math.ceil(timeDiff / (1000 * 3600 * 24));

		if(days<0){
			ctrl.TrDeadline=ctrl.tomorrow;
			ctrl.feasibility=3;
			alert("wrong deadline");
			return;
		}

		ctrl.MaxCh=days*10000;
		ctrl.UrgCh=days*8500;
		ctrl.days=days;
		//0=normal, 1=urgent, 2=impossible
		if(ctrl.TrCharacters>=ctrl.MaxCh) {
			ctrl.feasibility=2;
			ctrl.feasibilityBack="red";
			ctrl.feasibilityColor="#FFF";
			$("#feasibility").html("Job too demanding, please posticipate deadline");
		}else	if(ctrl.TrCharacters>=ctrl.UrgCh){
			ctrl.feasibility=1;
			ctrl.feasibilityBack="orange";
			ctrl.feasibilityColor="#FFF";
			$("#feasibility").html("Job will be set as urgent");
		}else{
			ctrl.feasibility=0;
			ctrl.feasibilityBack="#FFF";
			ctrl.feasibilityColor="#FFF";
			$("#feasibility").html("");
		}
		ctrl.updateTotals();
	}

	ctrl.isSelected=function(tr){
		return isSelected(tr);
	}

	ctrl.deselect=function(tr){
		deselectTr(tr);
		ctrl.calculateFeasibility();
	}

	ctrl.startJob=function(){
		ctrl.processSelected=true;
		if(ctrl.feasibility==0){
			selectedTr[0].total=ctrl.TrCharacters * ctrl.getAgPrice(1);
			selectedTr[1].total=ctrl.TrCharacters * ctrl.getAgPrice(2);
		}else if(ctrl.feasibility==1){
			selectedTr[0].total=ctrl.TrCharacters * ctrl.getAgPrice(1) * 105./100;
			selectedTr[1].total=ctrl.TrCharacters * ctrl.getAgPrice(2) * 105./100;
		}else{
			return;
		}
		$("#modalBodySelect").hide();
		$("#modalBodyUpload").show();
	}

	ctrl.submitJob=function(){
		if(!jobUploaded){
			alert("Please upload document to translate!!")
		}else{
			var temp = {
					user : getUsername(),
					token : getToken(),
					job: ctrl.jobTitle,
					description: ctrl.jobDescription,
					count: countSelected(),
					translators: selectedTr,
					url: urlUploaded,
					deadline: ctrl.TrDeadline,
					ncharacters: ctrl.TrCharacters,
					languagefrom: ctrl.from,
			};

			var stringPass = JSON.stringify(temp);
			var data = stringPass;

			$.ajax( {
				type : "POST",
				dataType : "application/json",
				contentType : "application/json; charset=utf-8",
				data : data,
				url : "createJob.php",
				complete : function(ret) {
					var response=ret.responseText;
					$('#TrModal').modal('hide');
					$("#table").html("");
					$("#selectedtable").hide();
					jobUploaded=false;
					urlUploaded="";
					ctrl.jobTitle="";
					ctrl.jobDescription="";
					ctrl.TrDeadline=ctrl.tomorrow;
					ctrl.TrCharacters=0;
					ctrl.processSelected=false;
					ctrl.conditionsAccepted=false;
					ctrl.pricesAccepted=false;

					$("#alertOK").html("Job created correctly, do another search or go to Jobs");
					$("#alertOK").fadeIn().delay(25000).fadeOut();
					$("#jobModal").hide();
				},
				error : function(xhr) {
					if (xhr.status == 500) {
						$("#alertError").html("Error from server, try to change field, rating or price.");
						$("#alertError").fadeIn().delay(1000).fadeOut();
					}

				}
			});
		}

	}

	ctrl.showPicker=function(){
		showPicker();
	}

	ctrl.closeModal=function(){
		$('#TrModal').modal('hide');
		ctrl.processSelected=false;
		ctrl.TrCharacters=0;
		ctrl.TrDeadline=ctrl.tomorrow;
		ctrl.conditionsAccepted=false;
		ctrl.pricesAccepted=false;

		ctrl.calculateFeasibility();
		$("#modalBodySelect").show();
		$("#modalBodyUpload").hide();
	}


	ctrl.$onInit=function(){
		ctrl.selectedPrice=3;
		ctrl.selectedRating=0;
		ctrl.from="";
		ctrl.to="";
		ctrl.field="";
		ctrl.initForm();

		ctrl.TrCharacters=0;
		ctrl.today=new Date();
		ctrl.tomorrow=new Date(ctrl.today.getTime() + 24 * 60 * 60 * 1000);
		ctrl.TrDeadline=ctrl.tomorrow;

		ctrl.processSelected=false;
		ctrl.conditionsAccepted=false;
		ctrl.pricesAccepted=false;

		$("#modalBodySelect").show();
		$("#modalBodyUpload").hide();
	}

});



angular.element(document).ready(function() {
	console.log("registro search");
	angular.bootstrap(document.getElementById('search'), ['search']);
});
