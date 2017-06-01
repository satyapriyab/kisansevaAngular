/**
* File    : validation.js
* Purpose : Contains all jquery codes to for user login and register
* Created : 10-may-2017
* Author  : Satyapriya Baral
*/
$(document).ready(function(){
	/**
    * Function to check password
    *
    * @param string value - contains the password data.
    * @return null.
    */
	$.validator.addMethod("pwcheck", function(value) {
		return /^[A-Za-z0-9\d=!\-@._*]*$/.test(value) // consists of only these
		&& /[a-z]/.test(value) // has a lowercase letter
		&& /\d/.test(value) // has a digit
	});
	
	/**
    * Function to validate registration data
    *
    * @param null.
    * @return error messages if found.
    */
	$("#registerUser").validate({
		rules: {
			UserType: {
				required: {
					depends: function(element) {
						return $("#userType").val() == "";
					}
				}
			},
			Name: {
				required: true,
				minlength: 5
			},
			Email: {
				required: true,
				email: true
			},
			Password: {
				required: true,
				pwcheck: true,
				minlength: 5
			},
			RetypePassword: {
				required: true,
				equalTo: Password
			},
			Number: {
				required: true,
				minlength: 10,
				maxlength: 10
			}
		},
		messages: {
			UserType: {
				required: "Select a User Type"
			},
			Name: {
				required: "Please enter name",
				minlength: "Name should be of minimum 5 charecters"
			},
			Email: {
				required: "Please enter Email",
				email: "Enter a valid Email"
			},
			Password: {
				required: "Please enter Password",
				pwcheck: "Password must be 8 characters including 1 uppercase letter, 1 special character, alphanumeric characters",
				minlength: "Password should be of minimum 5 charecters"
			},
			RetypePassword: {
				required: "Reenter Password",
				equalTo: "Password Mismatch"
			},
			Number: {
				required: "Please Enter Number",
				minlength: "Please Enter 10 digits",
				maxlength: "Please Enter 10 digits"
			}
		}
	});

	/**
    * Function to validate login data
    *
    * @param null.
    * @return error messages if found.
    */
	$("#loginUser").validate({
		rules: {
			Email: {
				required: true,
				email: true
			},
			Password: {
				required: true,
				minlength: 5
			}
		},
		messages: {
			Email: {
				required: "Please enter Email",
				email: "Enter a valid Email"
			},
			Password: {
				required: "Please enter Password",
				minlength: "Password should be of minimum 5 charecters"
			}
		}
	});
	
	/**
    * Function to reset password data
    *
    * @param null.
    * @return error messages if found.
    */
	$("#resetPassword").validate({
		rules: {
			Password: {
				required: true,
				pwcheck: true,
				minlength: 5
			}
		},
		messages: {
			Password: {
				required: "Please enter Password",
				pwcheck: "Password must be 8 characters including 1 uppercase letter, 1 special character, alphanumeric characters",
				minlength: "Password should be of minimum 5 charecters"
			}
		}
	});
	
});