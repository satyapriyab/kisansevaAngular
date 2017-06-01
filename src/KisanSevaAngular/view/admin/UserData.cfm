<!DOCTYPE html>
<!--
* File    : UserData.cfm
* Author  : Satyapriya Baral
* Date    : 23-Mar-2017
* Purpose : View details of user  -->
<html>
<head>
	<title>Admin | FarmerDetails</title>
	<cfinclude template="#request.webRoot#view/master/header.cfm">
	<cfset controllerObject = CreateObject("component","controller.adminController") />
	<cfif  SESSION.type NEQ 1>
		<cflocation url="#request.webRoot#view/login/login.cfm" addToken="false"></cflocation>
	</cfif>
	<cfif isDefined("url.status")>
		<cfset status = url.status />
		<cfset userId = url.userId />
		<cfset VARIABLES.changeStatus = controllerObject.statusUpdate( userId = "#userId#", status = "#status#")>
		<cflocation url="#request.webRoot#view/admin/userData.cfm" addToken="false"></cflocation>
	</cfif>
	<aside class="main-sidebar">
		<section class="sidebar">
			<div class="user-panel">
				<div class="pull-left image">
					<img src="<cfoutput>#request.webRoot#</cfoutput>assets/custom/img/<cfoutput>#SESSION.image#</cfoutput>" class="img-circle" alt="User Image">
				</div>
				<div class="pull-left info">
					<p><cfoutput> #SESSION.user# </cfoutput></p>
					<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
				</div>
			</div>
			<ul class="sidebar-menu">
				<li class="header">MAIN NAVIGATION</li>
				<li class="treeview">
					<a href="<cfoutput>#request.webRoot#</cfoutput>view/admin/adminHome.cfm">
						<i class="fa fa-home"></i>
						<span>Home</span>
					</a>
				</li>
				<li class="active treeview">
					<a href="<cfoutput>#request.webRoot#</cfoutput>view/admin/userData.cfm">
						<i class="fa fa-users"></i>
						<span>Users</span>
					</a>
				</li>
				<li class="treeview">
					<a href="<cfoutput>#request.webRoot#</cfoutput>view/admin/addCategory.cfm">
						<i class="fa fa-edit"></i>
						<span>Category</span>
					</a>
				</li>
				<li class="treeview">
					<a href="#">
						<i class="fa fa-edit"></i>
						<span>Farming Tips</span>
					</a>
				</li>
				<li class="treeview">
					<a href="#">
						<i class="fa fa-user-plus"></i>
						<span>Add Admin</span>
					</a>
				</li>
			</ul>
		</section>
	</aside>
	<div class="content-wrapper">
		<section class="content-header">
			<h1>Farmer Details</h1>
			<ol class="breadcrumb">
				<li><a href="<cfoutput>#request.webRoot#</cfoutput>view/admin/adminHome.cfm"><i class="fa fa-dashboard"></i> Home</a></li>
				<li class="active">Farmer Details</li>
			</ol>
		</section>
		<section class="content">
			<div class="row">
				<div class="col-xs-12">
					<div class="col-md-12">
						<div class="table-responsive">
							<table id="example" class="table table-striped table-curved" cellspacing="0" width="100%">
								<thead>
									<tr>
										<th>Type</th>
										<th>Name</th>
										<th>Email</th>
										<th>Address</th>
										<th>Contact</th>
										<th>Rating</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
								<tfoot>
									<tr>
										<th>Type</th>
										<th>Name</th>
										<th>Email</th>
										<th>Address</th>
										<th>Contact</th>
										<th>Rating</th>
										<th>Action</th>
									</tr>
								</tfoot>
							</table>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
	<script src="<cfoutput>#request.webRoot#</cfoutput>assets/template/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script type="text/javascript" src="<cfoutput>#request.webRoot#</cfoutput>assets/custom/js/userTable.js?ver=1shbhiy.11"></script>
	<cfinclude template="#request.webRoot#view/master/footer.cfm">
