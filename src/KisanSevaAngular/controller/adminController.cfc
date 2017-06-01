/**
* File: adminController.cfc
* Author: Satyapriya Baral
* Path: controller/adminController.cfc
* Purpose: contains all for admin screen.
* Date: 04-05-2017
*/
component {
	
	userObject = CreateObject("component", "model.userModel");
	categoryObject = CreateObject("component", "model.categoryModel");
	error = CreateObject("component", "log.error");
	
	/**
    * Function to get all data of users.
    *
    * @param null
    * @return - Returns user data to the ajax call.
    */
	function userDetails() access="remote"
	{
		try {
			LOCAL.userDetails = userObject.userDetails();	
			LOCAL.data = [];
		
			for(i=1 ; i <= LOCAL.userDetails.getResult().recordcount ; i++) {
				if(LOCAL.userDetails.getResult().UserIsActive[i] NEQ 1){
					LOCAL.action = "<Button class='label label-danger glyphicon glyphicon-remove-sign' onclick=window.location='../../view/admin/userData.cfm?status=#LOCAL.userDetails.getResult().UserIsActive[i]#&userId=#LOCAL.userDetails.getResult().UserId[i]#'>Disable</Button>";
				} else {
					LOCAL.action = "<Button class='label label-success' onclick=window.location='../../view/admin/userData.cfm?status=#LOCAL.userDetails.getResult().UserIsActive[i]#&userId=#LOCAL.userDetails.getResult().UserId[i]#'>Enable</Button>";
				}
			
				if(LOCAL.userDetails.getResult().UserTypeId[i] EQ 2) {
					LOCAL.type = "Farmer";
				} else if(LOCAL.userDetails.getResult().UserTypeId[i] EQ 3) {
					LOCAL.type = "Dealer";
				}
			
				if(LOCAL.userDetails.getResult().UserTypeId[i] NEQ 1) {
					obj = {
						"UserType" = "#LOCAL.type#",
						"UserName" = "#LOCAL.userDetails.getResult().UserName[i]#",
						"UserEmail" = "#LOCAL.userDetails.getResult().UserEmail[i]#",
						"UserAddress" = "#LOCAL.userDetails.getResult().UserAddress[i]#",
						"UserNumber" = "#LOCAL.userDetails.getResult().UserNumber[i]#",
						"UserRating" = "#LOCAL.userDetails.getResult().UserRating[i]#",
						"ActionBtn" = "#LOCAL.action#"
					};
					arrayAppend(data, obj);
				}
			}

			suppresswhitespace="Yes";
			WriteOutput('
			{
				"aaData":
				#serializeJSON(data)#
			}');
			enablecfoutputonly="No" ;
			showdebugoutput="No";
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
	}
	
	/**
    * Function to update the status of user.
    *
    * @param int userId - contains the id of the user.
	* @param string ststus - contains the ststus of user.
    * @return - null.
    */
	public void function statusUpdate(string userId, string status)
	{
		try {
			if (ARGUMENTS.status EQ 1) {
				LOCAL.status = 0;
			} else {
				LOCAL.status = 1;
			}
			LOCAL.userDetails = userObject.update(LOCAL.status, ARGUMENTS.userId, "UserIsActive", "UserId");
		}

		catch (any exception){
			error.errorLog(exception);
		}		
	}

	/**
    * Function to add new category of crop.
    *
    * @param string $category - contains name of the category.
    * @return - Returns messages of errors if any or success msg.
    */
	public any function addCategory(string category)
	{
		try {
			LOCAL.messages=StructNew();
			if (category EQ "") {
				LOCAL.messages.Category = 'Please Enter Category';
			}
			if (isDefined("messages") AND NOT structIsEmpty(messages)) {
				return LOCAL.messages;
			}
			LOCAL.category = categoryObject.createCategory(category);
			return LOCAL.category;
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
	}
	
	/**
    * Function to add new crop under category.
    *
    * @param string $category - contains name of the category.
    * @return - Returns messages of errors if any or success msg.
    */
	any function addCrop(string categoryId, string crop) access="remote"
	{
		try {
			LOCAL.addCrop = categoryObject.createCrop(categoryId, crop);
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
	}
	/**
    * Function to view all category details.
    *
    * @param null.
    * @return - Returns object of all category details.
    */
	public any function viewCategory()
	{
		try {
			LOCAL.category = categoryObject.viewCategory();
			return LOCAL.category;
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
	}
	
	/**
    * Function to get all data of users.
    *
    * @param null
    * @return - Returns user data to the ajax call.
    */
	any function viewCrops(string id) access="remote"
	{
		LOCAL.crops = categoryObject.viewCrops();
		if(LOCAL.crops.getResult().recordCount EQ 0) {
			WriteOutput( serializeJSON("No Crops Found"));
		} else {
			LOCAL.cropDetails = [];
			for(i=1 ; i <= LOCAL.crops.getResult().recordcount ; i++) {
				if( LOCAL.crops.getResult().CategoryId[i] EQ ARGUMENTS.id ){
					LOCAL.data=StructNew();
					LOCAL.data.id=LOCAL.crops.getResult().CropName[i];
					arrayAppend(LOCAL.cropDetails, LOCAL.data);
				}
			}
			writeOutput( serializeJSON(LOCAL.cropDetails) );
		}
	}
	

}