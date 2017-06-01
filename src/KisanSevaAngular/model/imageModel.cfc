/**
* File: imageModel.cfc
* Author: Satyapriya Baral
* Path: model/imageModel.cfc
* Purpose: contains functions to connect to the image database table.
* Date: 16-05-2017
*/
component {
	error = CreateObject("component", "log.error");
	
	/**
    * Function to check user exists or not.
    *
    * @param string $email - contains email of the user.
    * @return - Returns the record of the user.
    */
	public any function userImage(string userId)
	{
		try {
			userImage = new Query();
			userImage.setSQL("SELECT * FROM dbo.[Media] WHERE UserId = :userId");
			userImage.addParam( name = "userId", value = "#arguments.userId#", cfsqltype = "cf_sql_varchar" );
			imageResult = userImage.execute();
			return imageResult;
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
	}

	/**
    * Function to create a record of new image of user.
    *
    * @param string $imagename - contains name of the user image.
    * @param string $userId - contains the id of the user.
    * @return - Returns boolian value if record created or not.
    */
	public boolean function createProfileImage(string imageName, string userId)
	{
		try {
			newImage = new Query();
			newImage.setSQL("INSERT into dbo.[Media] (UserId, MediaName) VALUES (:userId, :mediaName)");
			newImage.addParam( name = "userId", value = "#arguments.userId#", cfsqltype = "cf_sql_varchar" );
			newImage.addParam( name = "mediaName", value = "#arguments.imageName#", cfsqltype = "cf_sql_varchar" );
			result = newImage.execute();
			return "true";
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
	}
	
	/**
    * Function to update profile image.
    *
    * @param string $imageName - contains the name of the image.
    * @param string $userId - contains the id of the user.
    * @return - Returns boolian value if succesful or not.
    */
	public boolean function updateProfileImage(string imageName, string userId)
	{
		try {
			update = new Query();
			update.setSQL("UPDATE dbo.[Media] SET MediaName = :ImageName WHERE UserId = :userId");
			update.addParam( name = "ImageName", value = "#arguments.imageName#", cfsqltype = "cf_sql_varchar" );
			update.addParam( name = "userId", value = "#arguments.userId#", cfsqltype = "cf_sql_varchar" );
			result = update.execute();
			return "true";
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
	}
}