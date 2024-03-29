<!DOCTYPE html>
<html lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Glifico</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="Description" content="Everything you need to find your translator and be sure to get you job done!">


<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-108156271-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-108156271-1');
</script>

<script type="text/javascript" src="js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="js/jquery.cookiebar.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.6/angular.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

<script src="functions.js"></script>
<script src="cookiebar.js"></script>
<script src="loginform.js"></script>
<script src="mylogin.js"></script>
<script src="app/glifico.modules.js"></script>
<script src="app/glificoFooter.component.js"></script>
<script src="app/login.controller.js"></script>

<link rel="styleSheet" href="angularjs/angular-material.min.css"/>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<link rel="stylesheet" type="text/css" href="css/jquery.cookiebar.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="MegaNavbar/assets/plugins/simple-line-icons/simple-line-icons.css">
<link rel="stylesheet" type="text/css" href="MegaNavbar/assets/css/MegaNavbar.min.css">
<link rel="stylesheet" type="text/css" href="MegaNavbar/assets/css/MegaNavbar.css">
<link rel="stylesheet" type="text/css" href="MegaNavbar/assets/css/skins/navbar-inverse.css">
<link rel="stylesheet" type="text/css" href="MegaNavbar/assets/css/animation/animation.css">
<link rel="shortcut icon" type="image/x-icon" href="favicon288.ico">
<link rel="apple-touch-icon" href="favicon288.ico">


<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit&hl=en"></script>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<script src="https://www.paypalobjects.com/api/checkout.js"></script>
<script src="payDocument.js"></script>
</head>
<body onload="onLoad()">

<nav class="navbar navbar-default navbar-fixed-top">
<div class="container-fluid">
<div class="navbar-header">
<button class="navbar-toggle" data-target="#MegaNavbar" data-toggle="collapse" type="button">
<span class="sr-only">Toggle navigation</span>
<span class="icon-bar"></span>
<span class="icon-bar"></span>
<span class="icon-bar"></span>
</button>

<a class="navbar-brand navbar-left" href="index.html"><i class="fa fa-home"></i>
<span class="reverse" style="font-size:22px;">GLIFICO</span>
</a>
</div>
<div class="collapse navbar-collapse" id="MegaNavbar">
<ul id = "MegaNavbarLeft" class="nav navbar-nav navbar-left" style="display:none;">
<li><a href="about.html">About</a></li>
<li><a href="services.html">Services</a></li>
<li><a href="privacy.html">Privacy</a></li>
<li><a href="terms.html">Terms</a></li>
<li><a href="contacts.html">Contacts</a></li>
</ul>
<ul class="nav navbar-nav navbar-right">
<li id="li-jobs" style="display:none;"><a href="pendingJobs.html">Jobs <i class="fa fa-file"></i></a></li>
<li id="li-pay" style="display:none;"><a href="pendingPayments.html">Jobs <i class="fa fa-file"></i></a></li>
<li id="li-search" style="display:none;"><a href="search.html">Search <i class="fa fa-search"></i></a></li>

<li id="li-tests" style="display:none;" class="dropdown">
<a aria-expanded="false" aria-haspopup="false" class="dropdown-toggle" data-toggle="dropdown" href="#">
<span class="reverse">Skill tests</span>
</a>

<ul class="dropdown-menu">
 	<li id="li-skill" style="display:none;"><a href="skillTest.html">Aptitude <i class="fa fa-globe"></i></a></li>
 	<li id="li-trad" style="display:none;"><a href="socialTrad.html">Translations <i class="fa fa-language"></i></a></li>
</ul>
</li>
<li id="li-rating" style="display:none;"><a href="socialRating.html">Rate it! <i class="fa fa-star"></i></a></li>

<li class="dropdown-grid" style="position: static;">
<a aria-expanded="false" aria-haspopup="true" class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);" id="a6" onClick="modalLogin()">
<span class="reverse">
<span id="view:_id4:computedField1">
<script>function modalLogin(){  $('#loginModal').modal('show');}</script>
<span id="usernameLoginRegister" onClick="modalLogin()" style="display:none;">Register / Login</span>
</span>
</span>
</a>
</li>

<li class="dropdown">
<a aria-expanded="false" aria-haspopup="false" class="dropdown-toggle" data-toggle="dropdown" href="#">
<span class="reverse">
<div id="loginController" ng-controller="loginController as ctrl">
<span><p id="usernameTab">{{ctrl.username}}</p></span>
</div>
</span>
</a>

<ul class="dropdown-menu">
 	<li><a onclick="personalArea()">Personal page <i class="fa fa-user"></i></a></li>
 	<li id="translator-help" style="display:none;"><a href="pdf_viewer/web/viewer.html?file=userguide.pdf">Help <i class="fa fa-question"></i></a>
 	<li id="agency-help" style="display:none;"><a href="pdf_viewer/web/viewer.html?file=userguide_agency.pdf">Help <i class="fa fa-question"></i></a>
    <li><a onclick="logout()">Logout <i class="fa fa-sign-out-alt"></i></a></li>
</ul>
</li>

</ul>
</div>
</div>
</nav>

<div aria-labelledby="myModalLabel" class="modal fade" id="loginModal" role="dialog" tabindex="-1">
<div class="modal-dialog" role="document">
<div class="modal-content">
<div class="modal-header">
<button aria-label="Close" class="close" data-dismiss="modal" type="button">
<span aria-hidden="true"></span>
</button>
<h4 class="modal-title" id="myModalLabel">Welcome, register or login at GLIFICO</h4>
</div>
<div class="modal-body">
<ul class="nav nav-tabs">
<li class="active"><a data-toggle="tab" href="#login">Login</a></li>
<li><a data-toggle="tab" href="#register">Register a new account</a></li>
</ul>
<div class="tab-content">
<div class="tab-pane fade in active" id="login">
<form class="form-horizontal">

<fieldset>
<div class="form-group">
<div class="col-md-12"></div>
</div>
<div class="form-group">
<label class="col-md-4 control-label" for="textinput" id="user">User:</label>
<div class="col-md-4">
<input autofocus="autofocus" class="form-control input-md" id="textinput" name="textinput" onkeydown="if(event.keyCode == 13) document.getElementById('button1id').click()" placeholder="User.." type="text">
</div>
</div>
<div class="form-group">
<label class="col-md-4 control-label" for="passwordinput">Password:</label>
<div class="col-md-4">
<input class="form-control input-md" id="passwordinput" name="passwordinput" onkeydown="if(event.keyCode == 13) document.getElementById('button1id').click()" placeholder="Password..." type="password">
</div>
</div>
<div class="alert alert-danger" id="errorPanel" style="display:none;">
<strong>Warning!</strong> Wrong username or password
</div>
<div class="form-group">
<label class="col-md-4 control-label" for="button1id"></label>
<div class="col-md-8">
<button IsDefault="false" class="btn btn-success" id="button1id" name="button1id" onClick="doDominoLogin()" type="button">Login</button>
</div>
</div>
<div class="form-group">
<div class="col-md-8" style="padding-left:50px;">
<p><a href="resetPassword.html">Forgot password?</a></p>
</div>
</div>
</fieldset>
</form>
</div>


<div class="tab-pane fade" id="register">
<div style="width: 90%; margin: auto; padding-bottom: 5em; padding-top: 1em; padding-left: 2em;">
<h3>What type of account do you want?</h3>
<span style="width:40%; margin:auto; float: left; font-size: 20px">
<button class="btn btn-primary" style="font-size: 20px;" onclick="showRegTrad()"><i class="fa fa-user"></i> Translator</button>
</span>
<span style="width:40%; margin:auto; float: right;">
<button class="btn btn-primary" style="font-size: 20px;" onclick="showRegAge()"><i class="fa fa-building"></i> Agency</button>
</span>
</div>

<div id="regAge" class="modal-agency" hidden="true">
<div id="regAgeForm" data-ng-controller="regAgecontroller as ctrl">
<div>
<form class="needs-validation" name="regAgeForm" action="/" method="post" novalidate>
<div class="input-group">
<div class="form-group col-md-8">
<label>Company Name: </label>
<input class="form-control" type="text" data-ng-model="ctrl.companyname" placeholder="name">
</div>
</div>
<div class="input-group">
<div class="form-group col-md-10">
<label>Username: </label>
<input name="username" class="form-control" type="text" data-ng-model="ctrl.username" placeholder="username">
<div data-ng-show="regAgeForm.username.$touched">
<div class="invalid-feedback" id="usercheck" data-ng-show="!ctrl.isuservalid()">Username must have al least 7 characters!
</div>
</div>
</div>
</div>
<div class="input-group">
<div class="form-group col-md-10">
<label>Email: </label>
<input name="emailfield" class="form-control" type="email" data-ng-model="ctrl.email" placeholder="email">
<div data-ng-show="regAgeForm.emailfield.$touched">
<div class="invalid-feedback" id="emailcheck" data-ng-show="!ctrl.isemailvalid()">This email address seems not valid</div>
</div>
</div>
</div>
<div class="input-group">
<div class="form-group col-md-7">
<label for="password">Password: </label>
<input name="passwordfield" class="form-control" type="password" data-ng-model="ctrl.password" placeholder="Must be at least 7 characters">
<div data-ng-show="regAgeForm.passwordfield.$touched">
<div class="invalid-feedback" id="passwordcheck" data-ng-show="!ctrl.ispasswordvalid()">
Password must have at least 7 characters!
</div>
</div>
</div>
<div class="form-group col-md-5">
<label>Repeat password: </label>
<input name="repeatpasswordfield" class="form-control" type="password" data-ng-model="ctrl.reppassword" placeholder="Retype password">
<div ng-show="regAgeForm.repeatpasswordfield.$touched">
<div class="invalid-feedback" id="matchcheck" data-ng-show="ctrl.passwordmatch()">Password must match!</div>
</div>
</div>
</div>
<div class="input-group">
<div class="form-group col-md-5">
<span id="captchaAge"></span>
</div>
</div>
<div class="input-group">
<div class="form-group form-check col-md-10">
<label><input type="checkbox" data-ng-model="ctrl.tec">I accept <a href="terms.html" target="_Blank">terms and conditions <i class="fa fa-external-link"></i></a></label>
</div>
</div>
<div class="input-group">
<div class="form-group form-check col-md-8">
<button type="button" data-ng-click="ctrl.Agesubmit()" class="btn btn-primary" ng-disabled="ctrl.invalidForm()">Register!</button>
</div>
</div>
</form>
</div>

</div>
</div>

<div id="regTrad" class="modal-translator" hidden="true">
<div id="regTradForm" data-ng-controller="regTradcontroller as ctrl">
<div>
<form class="needs-validation" name="regTradForm" action="/" method="post" novalidate>
<div class="input-group">
<div class="form-group col-md-5">
<label>Name: </label>
<input class="form-control" type="text" data-ng-model="ctrl.name" placeholder="name">
</div>
<div class="form-group col-md-5">
<label>Surname: </label>
<input class="form-control" type="text" data-ng-model="ctrl.surname" placeholder="surname">
</div>
</div>
<div class="input-group">
<div class="form-group col-md-10">
<label>Username: </label>
<input name="username" class="form-control" type="text" data-ng-model="ctrl.username" placeholder="username">
<div data-ng-show="regTradForm.username.$touched">
<div class="invalid-feedback" id="usercheck" data-ng-show="!ctrl.isuservalid()">Username must have al least 7 characters!
</div>
</div>
</div>
</div>
<div class="input-group">
<div class="form-group col-md-10">
<label>Email: </label>
<input name="emailfield" class="form-control" type="email" data-ng-model="ctrl.email" placeholder="email">
<div data-ng-show="regTradForm.emailfield.$touched">
<div class="invalid-feedback" id="emailcheck" data-ng-show="!ctrl.isemailvalid()">This email address seems not valid</div>
</div>
</div>
</div>
<div class="input-group">
<div class="form-group col-md-7">
<label for="password">Password: </label>
<input name="passwordfield" class="form-control" type="password" data-ng-model="ctrl.password" placeholder="Must be at least 7 characters">
<div data-ng-show="regTradForm.passwordfield.$touched">
<div class="invalid-feedback" id="passwordcheck" data-ng-show="!ctrl.ispasswordvalid()">
Password must have at least 7 characters!
</div>
</div>
</div>
<div class="form-group col-md-5">
<label>Repeat password: </label>
<input name="repeatpasswordfield" class="form-control" type="password" data-ng-model="ctrl.reppassword" placeholder="Retype password">
<div ng-show="regTradForm.repeatpasswordfield.$touched">
<div class="invalid-feedback" id="matchcheck" data-ng-show="ctrl.passwordmatch()">Password must match!</div>
</div>
</div>
</div>
<div class="input-group">
<div class="form-group col-md-5">
<span id="captchaTrad"></span>
</div>
</div>
<div class="input-group">
<div class="form-group form-check col-md-10">
<label><input type="checkbox" data-ng-model="ctrl.tec">I accept <a href="terms.html" target="_Blank">terms and conditions <i class="fa fa-external-link"></i></a></label>
</div>
</div>
<div class="input-group">
<div class="form-group form-check col-md-8">
<button type="button" data-ng-click="ctrl.submit()" class="btn btn-primary" ng-disabled="ctrl.invalidForm()">Register!</button>
</div>
</div>
</form>
</div>

</div>


</div>
</div>


</div>
</div>
<div class="modal-footer">
<button class="btn btn-default" data-dismiss="modal" type="button">Close</button>
</div>
</div>
</div>
</div>


<div class="alert alert-danger" id="alertError" style="display:none;position: fixed;top: 60px;left: 0;width: 100%;z-index:9999;">
<a class="close" data-dismiss="alert" href="#">&nbsp;</a>
</div>
<div class="alert alert-success" id="alertOK" style="display:none;position: fixed;top: 60px;left: 0;width: 100%;z-index:9999;">
<a class="close" data-dismiss="alert" href="#">&nbsp;</a>
</div>


<br><br><br><br>

<div id="payDocumentBody">
<div style="margin-right:10px;margin-left:10px">
<div class="panel panel-default">
<div class="panel-heading">
Please use the form below to pay translator
</div>
</div>
</div>
<div id="styledbody" style="text-align:center;float:center;">
<div class="glifico-info" style="width:50%;display: table;margin: 0 auto;float:center;text-align:center;">
<div id="payment" ng-controller="paymentController as ctrl">
<span id="message"></span>

<!-- paypal button-->
<br>
<div style="padding-top: 2em;" id="paypal-button"></div>
</div>
<br><br>


<br><br>
<button onclick="location.href='pendingPayments.html'" class="btn btn-primary" type="button">Return to <br>the job's page</button>

<div id="payCompleted" style="display:none;font-size:20px;">
Your payment has been <b>completed</b> on Paypal, thanks!
<br><br>
You will be automatically redirect in a few seconds...

<p>Anyway return to <a href="index.html">homepage</a></p>
</div>

</div>
</div>
</div>

<script>
shouldBeAgency();
</script>

 <div ng-app="glifico">
 <glificofooter></glificofooter>
 </div>


</body>

</html>
