/**
* File: userController.cfc
* Author: Satyapriya Baral
* Path: model/userController.cfc
* Purpose: contains functions for login and registration.
* Date: 01-05-2017
*/
component {
	
	userObject = CreateObject("component", "model.userModel");
	imageObject = CreateObject("component", "model.imageModel");
	error = CreateObject("component", "log.error");
	/**
    * Function to check fields and register user.
    *
    * @param string $username - contains name of the user.
    * @param string $email - contains email of the user.
    * @param string $password - contains passwoed of the user.
    * @param string $address - contains address of the user.
    * @param string $number - contains number of the user.
    * @return - Returns messages of errors if any or success msg.
    */
	any function registerUser(string type, string username, string email, string password, string retypePassword, string address, string number) access="remote" returnformat="JSON"
	{
		try {
			LOCAL.errorMessages=StructNew();
			if (type == 0) {
				LOCAL.errorMessages.Type = 'Please Select User Type';
			}
			if (Len(username) < 5) {
				LOCAL.errorMessages.Name = 'Name Should be of minimum 5 charecters';
			}
			if (email EQ '' OR NOT isValid("email", email)) {
			LOCAL.errorMessages.Email = 'Plese Enter a Valid Email';
			}
			if (Len(password) < 5) {
				LOCAL.errorMessages.Password = 'Password Should be of minimum 5 charecters';
			}
			else if (password NOT EQUAL retypePassword) {
				LOCAL.errorMessages.RetypePassword = 'Password Mismatch';
			}
			if (Len(number) LESS THAN 10 OR Len(number) GREATER THAN 10) {
				LOCAL.errorMessages.Number = 'Number should be of 10 digits';
			}
			var LOCAL.checkUser = userObject.checkUser(email);
			if (checkUser.getResult().recordCount NEQ 0 ) {
				LOCAL.errorMessages.emailExists = 'Email Already Exists';
			} else {
				LOCAL.isRegistered = userObject.createUser(type, username, email, password, address, number);
				LOCAL.errorMessages.successful = 'Registered Succesfully';
			}
			LOCAL.messages = [];
			arrayAppend(LOCAL.messages, LOCAL.errorMessages);
			writeOutput( serializeJSON(LOCAL.messages) );
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
	}
	
	/**
    * Function to check user details entered and login user.
    *
    * @param string $email - contains email of the user.
    * @param string $password - contains passwoed of the user.
    * @return - Returns to the homepage or returns error.
    */
	any function loginUser(string email, string password) access="remote" returnformat="JSON"
	{

		try {
			LOCAL.loginErrorMessages=StructNew();
			if (email EQ '' OR NOT isValid("email", email)) {
				LOCAL.loginErrorMessages.Email = 'Plese Enter a Valid Email';
			}
			if (Len(password) < 5) {
				LOCAL.loginErrorMessages.Password = 'Password Should be of minimum 5 charecters';
			}
			LOCAL.hashPassword = HASH(ARGUMENTS.password);
			LOCAL.isLogged = userObject.checkUser(email);
			if(LOCAL.isLogged.getResult().recordCount EQ 0) {
				LOCAL.loginErrorMessages.userError = 'Incorrect Email or Password';
			} else {
				if(LOCAL.isLogged.getResult().UserPassword NEQ LOCAL.hashPassword) {
					LOCAL.loginErrorMessages.userError = 'Incorrect Email or Password';
				} else {
					LOCAL.imageDetails = imageObject.userImage(LOCAL.isLogged.getResult().UserId);
					if(LOCAL.imageDetails.getResult().recordCount EQ 0) {
						LOCAL.loginErrorMessages.image = "userImage.png";
					} else {
						LOCAL.loginErrorMessages.image = "#LOCAL.imageDetails.getResult().MediaName#";
					}
					LOCAL.loginErrorMessages.userEmail = "#arguments.email#";
					LOCAL.loginErrorMessages.user = "#isLogged.getResult().UserName#";
					LOCAL.loginErrorMessages.type = "#isLogged.getResult().UserTypeId#";
					APPLICATION.currentUsers = listAppend(APPLICATION.currentUsers, #ARGUMENTS.email#);
					LOCAL.loginErrorMessages.type = LOCAL.isLogged.getResult().UserTypeId;
				}
			}
			LOCAL.messages = [];
			arrayAppend(LOCAL.messages, LOCAL.loginErrorMessages);
			writeOutput( serializeJSON(LOCAL.messages) );
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
	}
	
	/**
    * Function to get the user Details.
    *
    * @param string $email - contains email of the user.
    * @return - Returns userinfo details.
    */
	any function userDetails(string email) access="remote" returnformat="JSON"
	{
		try {
			LOCAL.userInfo = userObject.checkUser(email);
			LOCAL.userDetails=StructNew();
			if (userInfo.getResult().recordCount EQ 0 ) {
				LOCAL.userDetails.notPresent = 'Invalid Email';
			} else {
				LOCAL.userDetails.email = "#userInfo.getResult().UserEmail#";
				LOCAL.userDetails.name = "#userInfo.getResult().UserName#";
				LOCAL.userDetails.type = "#userInfo.getResult().UserTypeId#";
				LOCAL.userDetails.media = "#userInfo.getResult().UserMediaId#";
				LOCAL.userDetails.address = "#userInfo.getResult().UserAddress#";
				LOCAL.userDetails.number = "#userInfo.getResult().UserNumber#";
				LOCAL.userDetails.token = "#userInfo.getResult().UserTokenId#";
			}
			LOCAL.messages = [];
			arrayAppend(LOCAL.messages, LOCAL.userDetails);
			writeOutput( serializeJSON(LOCAL.messages) );
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
	}
	
	/**
    * Function to get details and make a random value for password reset.
    *
    * @param string email - Contains email data.
    * @return - Returns success or failure msg.
    */
    any function createToken(string email) access="remote" returnformat="JSON"
	{
		try {
			LOCAL.message=StructNew();
			//checks if email exist or not
			LOCAL.userInfo = userObject.checkUser(email);
			if(LOCAL.userInfo.getResult().recordCount NEQ 0) {
				LOCAL.random="";
				var i = 0;
				for (i = 0; i <= 20; i++) {
					LOCAL.random=LOCAL.random&Chr(RandRange(65, 90));
				}
				LOCAL.insertToken = userObject.update(random, email, "UserTokenId", "UserEmail");
				savecontent variable="mailBody" {
					writeOutput( "To reset your password please visit this link: http://localhost:4200/resetPassword?token=#LOCAL.random#&email=#ARGUMENTS.email#");
				};
				mailService = new mail(
					to = "#ARGUMENTS.email#",
					from = "kisansevaodisha@gmail.com",
					subject = "Forgot Password",
					body = mailBody
				);
				mailService.send();
				LOCAL.message.success = 'Reset Link Sent To your Mail';
			} else {
				LOCAL.message.failure = 'Incorrect Email';
			}
			LOCAL.messages = [];
			arrayAppend(LOCAL.messages, LOCAL.message);
			writeOutput( serializeJSON(LOCAL.messages) );
		}

		catch (any exception){
			error.errorLog(exception);
		}
		
    }
	
	/**
    * Function to update the new password.
    *
    * @param string password - Contains the password.
    * @param string email - Contains the email.
    * @return - Returns boolian value.
    */
    any function updatePassword(string email, string password) access="remote" returnformat="JSON"
    {
		try {
			if (Len(password) < 5) {
				return 'Password Should be of minimum 5 charecters';
			}
			var hashPassword = HASH(password);
			LOCAL.updatePassword = userObject.update(LOCAL.hashPassword, ARGUMENTS.email, "UserPassword", "UserEmail");
			writeOutput(serializeJSON(LOCAL.updatePassword));
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
    }
	
	/**
    * Function to edit the user profile.
    *
    * @param string $username - contains name of the user.
    * @param string $address - contains address of the user.
    * @param string $number - contains contact number of the user.
    * @param string $image - contains the image to be uploaded.
    * @param string $userId - contains id of the user.
    * @param string $mediaId - contains id of the user media.
    * @return - Returns messages of errors if any or success msg.
    */
	public any function editUserProfile(string username, string address, string number, string image, string userId, string mediaId)
	{
		try {
			LOCAL.messages=StructNew();
			if (Len(username) < 5) {
				LOCAL.messages.Name = 'Name Should be of minimum 5 charecters';
			}
			if (Len(number) LESS THAN 10 OR Len(number) GREATER THAN 10) {
				LOCAL.messages.Number = 'Number should be of 10 digits';
			}
			if (isDefined("messages") AND NOT structIsEmpty(messages)) {
				return LOCAL.messages;
			}
			if (image NEQ "null") {
				var imageName = fileUpload("#APPLICATION.baseUrlData#\assets\custom\img\profileImage.jpg", "#ARGUMENTS.image#", "image/jpeg ", "makeunique");
				LOCAL.imageDetails = imageObject.userImage(userId);
				if(LOCAL.imageDetails.getResult().recordCount EQ 0) {
						LOCAL.createProfileImage = imageObject.createProfileImage("#imageName.ServerFileName#.#imageName.ServerFileExt#", userId);
					} else {
						LOCAL.updateProfileImage = imageObject.updateProfileImage("#imageName.ServerFileName#.#imageName.ServerFileExt#", userId);
					}
				SESSION.image = "#imageName.ServerFileName#.#imageName.ServerFileExt#";
			} else {
				LOCAL.updateProfile = userObject.updateProfile(username, address, number, userId);
			}
			SESSION.user = "#ARGUMENTS.username#";
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
	}
	
	/**
    * Function to signout the user.
    *
    * @param null
    * @return null
    */
	public void function signoutUser()
	{
		try {
			if(SESSION.userEmail NEQ "") {
				APPLICATION.currentUsers = listDeleteAt(APPLICATION.currentUsers,listFind(APPLICATION.currentUsers, SESSION.userEmail));
			}
			structClear(SESSION);
			SESSION.isLogged = "false";
			SESSION.userEmail = "";
			SESSION.type = "";
			location(url="../../view/login/login.cfm", addToken="false");
			sessionInvalidate();
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
	}
}