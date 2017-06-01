<!DOCTYPE html>
<!--
* File    : adminHome.cfm
* Author  : Satyapriya Baral
* Date    : 09-May-2017
* Purpose : Contains home page of admin  -->
<html>
<head>
	<title>Admin | Home</title>
	<cfinclude template="#request.webRoot#view/master/header.cfm">
	<cfif  SESSION.type NEQ 1>
		<cflocation url="#request.webRoot#view/login/login.cfm" addToken="false"></cflocation>
	</cfif>
	<cfset controllerObject = CreateObject("component","controller.adminController") />
	<cfset VARIABLES.categoryDetails = controllerObject.viewCategory()>
	<cfif StructKeyExists(form,"addCategoryBtn")>
		<cfset VARIABLES.messages = controllerObject.addCategory( category = "#form.Category#")>
		<cflocation url="#request.webRoot#view/admin/addCategory.cfm" addToken="false"></cflocation>
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
				<li class="treeview">
					<a href="<cfoutput>#request.webRoot#</cfoutput>view/admin/userData.cfm">
						<i class="fa fa-users"></i>
						<span>Users</span>
					</a>
				</li>
				<li class="active treeview">
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
			<h1>
				Category
				<small>Admin</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="<cfoutput>#request.webRoot#</cfoutput>view/admin/adminHome.cfm"><i class="fa fa-dashboard"></i> Home</a></li>
				<li class="active">Category</li>
			</ol>
		</section>
		<section class="content">
			<div class="row">
				<div class="col-md-6">
					<div class="box box-primary">
						<div class="box-header with-border">
							<h3><b>Category</b></h3><hr>
							<cfloop from="1" to="#categoryDetails.getResult().recordCount#" index="i">
								<div class="box-header with-border">
									<cfoutput>#categoryDetails.getResult().CategoryName[i]#</cfoutput><br />
								</div>
							</cfloop>
							<cfform id="AddCategory" method="Post">
								<div class="form-group has-feedback">
									<cfinput type="text" class="form-control" placeholder="Enter Category" name="Category">
								</div>
								<div class="row">
								<div class="col-xs-8"></div>
									<div class="col-xs-4">
										<button type="submit" name="addCategoryBtn" class="btn btn-primary btn-block btn-flat">Add Category</button>
									</div>
								</div>
							</cfform>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="box box-primary">
						<cfform id="AddCrop">
							<div class="box-header with-border">
								<h3><b>Crops Under Category</b></h3><hr>
								<select class="form-control" id="category" name="Category">
									<option value="" selected="true">--Select Category--</option>
									<cfloop from="1" to="#categoryDetails.getResult().recordCount#" index="i">
										<option value="<cfoutput>#categoryDetails.getResult().CategoryId[i]#</cfoutput>"><cfoutput>#categoryDetails.getResult().CategoryName[i]#</cfoutput></option>
									</cfloop>
								</select>	
								<div id="crops" class="crops">
								</div>
							</div>
							<div class="box-header">
								<div class="form-group has-feedback cropData" id="cropData" >
									<cfinput type="text" class="form-control" placeholder="Enter Crop" name="Crop" id="crop">
								</div>
								<div class="row">
									<div class="col-xs-8"></div>
									<div class="col-xs-4">
										<button type="button" id="addCropBtn" name="addCropBtn" class="btn btn-primary btn-block btn-flat">Add Crop</button>
									</div>
								</div>
							</div>
						</cfform>
					</div>
				</div>
			</div>	
		</section>
	</div>
	<script src="<cfoutput>#request.webRoot#</cfoutput>assets/template/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<script src="<cfoutput>#request.webRoot#</cfoutput>assets/template/js/jquery-validation-1.16.0/dist/jquery.validate.js"></script>
	<script type="text/javascript" src="<cfoutput>#request.webRoot#</cfoutput>assets/custom/js/category.js?ver=1.23aswdwd.11"></script>
	<cfinclude template="#request.webRoot#view/master/footer.cfm">