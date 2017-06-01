/**
* File: categoryModel.cfc
* Author: Satyapriya Baral
* Path: model/categoryModel.cfc
* Purpose: contains functions to connect to the category and crop database table.
* Date: 17-05-2017
*/
component {
	error = CreateObject("component", "log.error");

	/**
    * Function to add New Category.
    *
    * @param string $category - contains name of the category.
    * @return - Returns boolian value if record created or not.
    */
	public boolean function createCategory(string category)
	{
		try {
			newCategory = new Query();
			newCategory.setSQL("INSERT into dbo.[Category] (CategoryName) VALUES (:category)");
			newCategory.addParam( name = "category", value = "#arguments.category#", cfsqltype = "cf_sql_varchar" );
			result = newCategory.execute();
			return "true";
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
	}
	
	/**
    * Function to add New Crop.
    *
    * @param string $categoryId - contains id of the category.
    * @param string $crop - contains name of the crop.
    * @return - Returns boolian value if record created or not.
    */
	public boolean function createCrop(string categoryId, string crop)
	{
		try {
			newCrop = new Query();
			newCrop.setSQL("INSERT into dbo.[Crop] (CategoryId, CropName) VALUES (:categoryId, :crop)");
			newCrop.addParam( name = "categoryId", value = "#arguments.categoryId#", cfsqltype = "cf_sql_varchar" );
			newCrop.addParam( name = "crop", value = "#arguments.crop#", cfsqltype = "cf_sql_varchar" );
			result = newCrop.execute();
			return "true";
		}
		
		catch (any exception){
			error.errorLog(exception);
		}

	}
	
	/**
    * Function to view Category.
    *
    * @param null.
    * @return - Returns object of all category details.
    */
	public any function viewCategory(string category)
	{
		try {
			category = new Query();
			category.setSQL("SELECT * FROM dbo.[Category]");
			result = category.execute();
			return result;
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
	}
	
	/**
    * Function to view Crops.
    *
    * @param null.
    * @return - Returns object of all category details.
    */
	public any function viewCrops()
	{
		try {
			crop = new Query();
			crop.setSQL("SELECT * FROM dbo.[Crop]");
			result = crop.execute();
			return result;
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
	}
}