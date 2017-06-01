/**
* File    : category.js
* Purpose : Contains all jquery codes for category validation fields
* Created : 10-may-2017
* Author  : Satyapriya Baral
*/
$(document).ready(function(){
	
	/**
    * Function to validate crop data
    *
    * @param null.
    * @return error messages if found.
    */
	$("#AddCrop").validate({
		rules: {
			Category: {
				required: {
					depends: function(element) {
						return $("#category").val() == "";
					}
				}
			},
			Crop: {
				required: true,
				minlength: 3
			}
		},
		messages: {
			Category: {
				required: "Select a Category"
			},
			Crop: {
				required: "Please enter crop Name",
				minlength: "Crop should be of minimum 3 charecters"
			}
		}
	});
	
	/**
    * Function to validate category data
    *
    * @param null.
    * @return error messages if found.
    */
	$("#AddCategory").validate({
		rules: {
			Category: {
				required: true,
				minlength: 3
			}
		},
		messages: {
			Category: {
				required: "Please enter category Name",
				minlength: "Category should be of minimum 3 charecters"
			}
		}
	});
	
  /**
  * Ajax call to display crops according to category
  *
  * @param Null
  * @return Null
  */
  $("#category").on("change",function(){
    var cat_id = $(this).val();
    //sets the div where crops to be displayed.
	var div=$(this).parent().parent().parent();
    var op="";
    $.ajax({
      type:'get',
      url: "../../../controller/adminController.cfc?method=viewCrops" ,
      data:{'id':cat_id},
      success:function(data){
		  var tmp = data[1];
		  jsonOBJ = jQuery.parseJSON(data);
			var arr = $.map(jsonOBJ, function(el) { return el });
			for( var i=0 ; i < arr.length ; i++ ) {
				op+= '<div class="box-header with-border">';
				op+= arr[i]+'</br>';
				op+= '</div>';
			}
		div.find('.crops').html(" ");
        div.find('.crops').append(op);
      }
    })
  });
  
    /**
  * Ajax call to input crop to database
  *
  * @param Null
  * @return Null
  */
  $("#addCropBtn").on("click",function(){
    var cat_id = $("#category").val();
	var crop = $("#crop").val();
    //sets the div where crops to be displayed.
	var div=$(this).parent().parent().parent();
    var op="";
    $.ajax({
      type:'get',
      url: "../../../controller/adminController.cfc?method=addCrop" ,
      data:{'categoryId':cat_id, 'crop':crop},
      success:function(data){ 
		op+= '<input type="text" class="form-control" placeholder="Enter Crop" name="Crop" id="crop">';
		div.find('.cropData').html(" ");
        div.find('.cropData').append(op);
		 $('#category').trigger('change');

      }
    })
  });
 })