	
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
	<!-- Bootstrap 3.3.6 -->
	<link href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.min.css" rel="stylesheet">
	<link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="<cfoutput>#request.webRoot#</cfoutput>assets/custom/css/main.css?ver=1.4.16666">
	<link rel="icon" type="image/png" href="<cfoutput>#request.webRoot#</cfoutput>assets/template/dist/img/favicon.ico'">
	<link rel="stylesheet" href="<cfoutput>#request.webRoot#</cfoutput>assets/template/dist/css/fresh-bootstrap-table.css">
	<link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
	<link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
	<!-- Ionicons -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
	<!-- Theme style -->
	<link rel="stylesheet" href="<cfoutput>#request.webRoot#</cfoutput>assets/template/dist/css/AdminLTE.min.css?ver=1.4.10">
	<!-- AdminLTE Skins. Choose a skin from the css/skins -->
	<link rel="stylesheet" href="<cfoutput>#request.webRoot#</cfoutput>assets/template/dist/css/skins/_all-skins.min.css">
	<link rel="stylesheet" href="<cfoutput>#request.webRoot#</cfoutput>assets/template/plugins/datatables/dataTables.bootstrap.css">
	<link rel="stylesheet" href="<cfoutput>#request.webRoot#</cfoutput>assets/template/plugins/iCheck/flat/blue.css">
	<link rel="stylesheet" href="<cfoutput>#request.webRoot#</cfoutput>assets/template/plugins/morris/morris.css">
	<link rel="stylesheet" href="<cfoutput>#request.webRoot#</cfoutput>assets/template/plugins/jvectormap/jquery-jvectormap-1.2.2.css">
	<link rel="stylesheet" href="<cfoutput>#request.webRoot#</cfoutput>assets/template/plugins/datepicker/datepicker3.css">
	<link rel="stylesheet" href="<cfoutput>#request.webRoot#</cfoutput>assets/template/plugins/daterangepicker/daterangepicker.css">
	<link rel="stylesheet" href="<cfoutput>#request.webRoot#</cfoutput>assets/template/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
</head>
<body class="hold-transition skin-blue sidebar-mini">
	<cfif  SESSION.isLogged EQ "false">
		<cflocation url="#request.webRoot#view/login/login.cfm" addToken="false"></cflocation>
	</cfif>
	<cfset controllerObject = CreateObject("component","controller.userController") />
	<cfif StructKeyExists(form,"signoutbtn")>
		<cfset VARIABLES.signout = controllerObject.signoutUser()/>
	</cfif>
	<cfset VARIABLES.userDetails = controllerObject.UserDetails(SESSION.userEmail)/>
	<div class="wrapper">
		<header class="main-header">
			<div class="logo">
				<span class="logo-lg"><b>Kisan</b>Seva</span>
			</div>
			<nav class="navbar navbar-static-top">
				<a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
					<span class="sr-only">Toggle navigation</span>
				</a>
				<div class="navbar-custom-menu">
					<ul class="nav navbar-nav">
						<div id="google_translate_element"></div>
					</ul>
					<ul class="nav navbar-nav">
						<li class="dropdown user user-menu">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								<img src="<cfoutput>#request.webRoot#</cfoutput>assets/custom/img/<cfoutput>#SESSION.image#</cfoutput>" class="user-image" alt="User Image">
								<span class="hidden-xs"><cfoutput> #SESSION.user# </cfoutput></span>
							</a>
							<ul class="dropdown-menu">
								<li class="user-header">
									<img src="<cfoutput>#request.webRoot#</cfoutput>assets/custom/img/<cfoutput>#SESSION.image#</cfoutput>" class="img-circle" alt="User Image">
									<p>
										<cfif  SESSION.type EQ 1> <cfoutput> #SESSION.user# </cfoutput> - Admin 
										<cfelseif SESSION.type EQ 2> <cfoutput> #SESSION.user# </cfoutput> - Farmer
										<cfelse> <cfoutput> #SESSION.user# </cfoutput> - Dealer
										</cfif>
										<small>Member since Apr. 2017</small>
									</p>
								</li>
								<li class="user-footer">
									<div class="pull-left">
										<a href="<cfoutput>#request.webRoot#</cfoutput>view/admin/profile.cfm" class="btn btn-default btn-flat">Profile</a>
									</div>
									<div class="pull-right">
										<cfform>
											<button type = "submit" class = "btn btn-default btn-flat" name = "signoutbtn" id = "signoutbtn" >Sign out
											</button>
										</cfform>
									</div>
								</li>
							</ul>
						</li>
					</ul>
				</div>
			</nav>
		</header>