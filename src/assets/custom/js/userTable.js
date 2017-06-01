/**
* File    : userTable.js
* Purpose : Contains all jquery user details table functionality
* Created : 10-may-2017
* Author  : Satyapriya Baral
*/
$(document).ready(function() {	

	/**
    * Ajax call to get all user data
    *
    * @param null.
    * @return all data of user.
    */
    $('#example').DataTable( {
		"bJQueryUI": true,
        "bProcessing": true,
		"bServerSide": false,
		"sAjaxSource": "../../../controller/adminController.cfc?method=userDetails",
		"aoColumns": [
			{ "mData": "UserType" },
			{ "mData": "UserName" },
			{ "mData": "UserEmail" },
			{ "mData": "UserAddress" },
			{ "mData": "UserNumber" },
			{ "mData": "UserRating" },
			{ "mData": "ActionBtn" }
		]
	});
});