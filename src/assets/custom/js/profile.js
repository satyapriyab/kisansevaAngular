/**
* File    : profile.js
* Purpose : Contains all jquery codes for profile validation fields
* Created : 10-may-2017
* Author  : Satyapriya Baral
*/
$(document).ready(function(){
	/**
    * Function to validate profile data
    *
    * @param null.
    * @return error messages if found.
    */
	$("#editProfileForm").validate({
		rules: {
			Name: {
				required: true,
				minlength: 5
			},
			Number: {
				required: true,
				minlength: 10,
				maxlength: 10
			}
		},
		messages: {
			Name: {
				required: "Please enter name",
				minlength: "Name should be of minimum 5 charecters"
			},
			Number: {
				required: "Please Enter Number",
				minlength: "Please Enter 10 digits",
				maxlength: "Please Enter 10 digits"
			}
		}
	});

});