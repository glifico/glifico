$(document).ready(function () {

});

// 	$.ajax( {
// 		type : "POST",
// 		dataType : "application/json",
// 		contentType : "application/json; charset=utf-8",
// 		data : data,
// 		url : "setJobOngoing.php",
// 		complete : function(ret) {
// 			var response=ret.responseText;
// 			$("#alertOK").html("Job finished!");
// 			$("#alertOK").fadeIn().delay(2000).fadeOut();
// 			$("#jobModal").hide();
// 			location.href=location.href;
// 		},
// 		error : function(xhr) {
// 			if (xhr.status == 500) {
// 				$("#alertError").html("Error from server, please retry.");
// 				$("#alertError").fadeIn().delay(1000).fadeOut();
// 			}
//
// 		}
// 	});
//
// }

var $star_rating = $('.star-rating .fa');

var SetRatingStar = function() {
  return $star_rating.each(function() {
    if (parseInt($star_rating.siblings('input.rating-value').val()) >= parseInt($(this).data('rating'))) {
      return $(this).removeClass('fa-star-o').addClass('fa-star');
    } else {
      return $(this).removeClass('fa-star').addClass('fa-star-o');
    }
  });
};

$star_rating.on('click', function() {
  $star_rating.siblings('input.rating-value').val($(this).data('rating'));
  return SetRatingStar();
});

SetRatingStar();


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
		html+='<th class="col-md-4" style="text-align:center;">Translator</th>';
		html+='<th class="col-md-4" style="text-align:center;">Price</th>';
		html+='<th class="col-md-4" style="text-align:center;">Value</th>';
		html+='<th class="col-md-4" style="text-align:center;"></th>';
		html+='</tr>';
		html+='</thead>';
		for (var i = 0; i < ctrl.documents.length; i++) {
			var doc=ctrl.documents[i];
			html+='<tr class="row '+ctrl.getClass(doc)+'">';
			html+='<td class="col-md-4">'+doc.job+'</td>';
			html+='<td class="col-md-4">'+doc.price+doc.currency+'</td>';
			if(doc.status=="Pending"){
				html+='<td class="col-md-4" data-toggle="tooltip" data-placement="top" title="'+ctrl.getToolTip(doc)+'">'+"Accepted"+'</td>';
			}else{
				html+='<td class="col-md-4" data-toggle="tooltip" data-placement="top" title="'+ctrl.getToolTip(doc)+'">'+doc.status+'</td>';
			}
			html+='<td class="col-md-4">';
			html+='<div id="'+doc.id+'">';
			if(doc.status=="Completed"){
				html+='<i class="fa fa-check" aria-hidden="true"></i></div>';
			}else if(doc.status=="Ongoing"){
				html+='<button type="button" class="btn btn-warning" data-toggle="modal" data-target="#jobModal"';
				html+='data-job="'+doc.job+'"';
				html+=' data-price="'+doc.price+'"';
				html+=' data-id="'+doc.id+'"';
				html+=' data-currency="'+doc.currency+'"';
				html+=' data-status="'+doc.status+'"';
				html+=' data-description="'+doc.description+'"';
				html+='>Show job</button>';
			}else if(doc.status=="Finished"){
				html+='Waiting approval...';
			}else if(doc.status=="Pending"){
				html+='Waiting payment...';
			}else if(doc.status=="Proposed"){
				html+='<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#jobModal"';
				html+='data-job="'+doc.job+'"';
				html+=' data-price="'+doc.price+'"';
				html+=' data-id="'+doc.id+'"';
				html+=' data-currency="'+doc.currency+'"';
				html+=' data-status="'+doc.status+'"';
				html+=' data-description="'+doc.description+'"';
				html+='>Show job and accept it</button>';
			}
			html+='</td>';
			html+='<tr>';
		}
		html+='</table>';
		$("#table").html(html);
	}

	ctrl.$onInit=function(){
		ctrl.createTable();
		// 	var url = "getPendingJobs.php?user=" + getUsername()+"&token="+getToken();
		//
		// 	var req = createXHTMLHttpRequest() ;
		// 	req.onreadystatechange = function(){
		// 		if (req.status == 200&req.readyState==4){
		// 			var data=JSON.parse(req.responseText);
		// 			ctrl.documents=data;
		// 			ctrl.createTable();
		// 			return(true);
		// 		}else{
		// 			mostraDialogTimed('errorPanel');
		// 			return(false);
		// 		}
		// 	}
		// 	req.open("GET",url,true);
		// 	req.send();
		// }
	}
});



angular.element(document).ready(function() {
	console.log("registro search");
	angular.bootstrap(document.getElementById('search'), ['search']);
});
