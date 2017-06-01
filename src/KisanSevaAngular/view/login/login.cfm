<!DOCTYPE html>
<!--
* File: login.cfm
* Author: Satyapriya Baral
* Purpose: contains the view of the login page.
* Date: 01-05-2017
-->
<html lang = "en-US">
	<head>
		<link rel="stylesheet" href="<cfoutput>#request.webRoot#</cfoutput>assets/template/bootstrap/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
		<link rel="stylesheet" href="<cfoutput>#request.webRoot#</cfoutput>assets/template/dist/css/AdminLTE.min.css">
		<link rel="stylesheet" href = "<cfoutput>#request.webRoot#</cfoutput>assets/custom/css/main.css">
	</head>	
	<body class="hold-transition login-page">
		<cfset controllerObject = CreateObject("component","controller.userController") />
		<cfif StructKeyExists(form,"loginbtn")>
			<cfset VARIABLES.errorMessages = controllerObject.loginUser( email = "#form.Email#", password = "#form.Password#" )>
		</cfif>
		<cfif  SESSION.isLogged NEQ "false" OR isDefined("errorMessages.type")>
			<cfif  SESSION.type EQ 1 OR (isDefined("errorMessages.type") AND errorMessages.type EQ 1)>
				<cflocation url="#request.webRoot#view/admin/adminHome.cfm" addToken="false"></cflocation>
			<cfelseif  SESSION.type EQ 2 OR (isDefined("errorMessages.type") AND errorMessages.type EQ 2)>
				<cflocation url="#request.webRoot#view/farmer/farmerHome.cfm" addToken="false"></cflocation>
			<cfelseif SESSION.type EQ 3 OR (isDefined("errorMessages.type") AND errorMessages.type EQ 3)>
				<cflocation url="#request.webRoot#view/dealer/dealerHome.cfm" addToken="false"></cflocation>
			</cfif>
		</cfif>
		<div class="login-box">
			<div class="login-logo">
				<b>Kisan</b>Seva</a>
			</div>
			<div class="login-box-body">
				<p class="login-box-msg">Sign in to start your session</p>
				<cfif isDefined("errorMessages.user")>
					<cfoutput> #errorMessages.user# </cfoutput>
				</cfif>
				<cfform id="loginUser">
					<div class="form-group has-feedback">
						<cfinput type="email" class="form-control" placeholder="Email" name="Email">
						<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
						<cfif isDefined("errorMessages.Email")>
							<cfoutput> #errorMessages.Email# </cfoutput>
						</cfif>
					</div>
					<div class="form-group has-feedback">
						<cfinput type="password" class="form-control" placeholder="Password" name="Password" >
						<span class="glyphicon glyphicon-lock form-control-feedback"></span>
						<cfif isDefined("errorMessages.Password")>
							<cfoutput> #errorMessages.Password# </cfoutput>
						</cfif>
					</div>
					<div class="row">
						<div class="col-xs-8"></div>
						<div class="col-xs-4">
							<button type="submit" name="loginbtn" class="btn btn-primary btn-block btn-flat">Sign In</button>
						</div>
					</div>
				</cfform>
				<a href="<cfoutput>#request.webRoot#</cfoutput>view/login/forgotPassword.cfm">I forgot my password</a><br>
				<a href="<cfoutput>#request.webRoot#</cfoutput>view/login/register.cfm" class="text-center">Register a new membership</a>
			</div>
		</div>
		<script src="<cfoutput>#request.webRoot#</cfoutput>assets/template/plugins/jQuery/jquery-2.2.3.min.js"></script>
		<script src="<cfoutput>#request.webRoot#</cfoutput>assets/template/js/jquery-validation-1.16.0/dist/jquery.validate.js"></script>
		<script src="<cfoutput>#request.webRoot#</cfoutput>assets/template/bootstrap/js/bootstrap.min.js"></script>
		<script src="<cfoutput>#request.webRoot#</cfoutput>assets/custom/js/validation.js?ver=126536756556"></script>
	</body>
</html>