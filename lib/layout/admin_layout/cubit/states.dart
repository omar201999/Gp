abstract class AdminStates {}

class AdminInitialState extends AdminStates {}

class ChangeBottomNavState extends AdminStates{}

class GetAdminDataLoadingState extends AdminStates{}

class GetAdminDataSuccessState extends AdminStates{}

class GetAdminDataErrorState extends AdminStates{
  final String error;
  GetAdminDataErrorState(this.error);
}

class AdminGetAllUsersLoadingState extends AdminStates {}

class AdminGetAllUsersSuccessState extends AdminStates {}

class AdminGetAllUsersErrorState extends AdminStates
{
  final String error;

  AdminGetAllUsersErrorState(this.error);
}

class AdminDeleteUsersSuccessState extends AdminStates {}

class AdminDeleteUsersErrorState extends AdminStates
{
  final String error;

  AdminDeleteUsersErrorState(this.error);
}

class AdminDeleteRecipeSuccessState extends AdminStates {}

class AdminDeleteRecipeErrorState extends AdminStates
{
  final String error;

  AdminDeleteRecipeErrorState(this.error);
}
class AdminDeleteProductSuccessState extends AdminStates {}

class AdminDeleteProductErrorState extends AdminStates
{
  final String error;

  AdminDeleteProductErrorState(this.error);
}

class SearchUsersLoadingState extends AdminStates{}

class SearchUsersSuccessState extends AdminStates{}

class SearchUsersErrorState extends AdminStates
{
  final String error;
  SearchUsersErrorState(this.error);
}





//create recipe
class CreateRecipeLoadingState extends AdminStates{}

class CreateRecipeSuccessState extends AdminStates{}

class CreateRecipeErrorState extends AdminStates{}

class RecipeImagePickedSuccessState extends AdminStates{}

class RecipeImagePickedErrorState extends AdminStates{}

class ImagePickedSuccessState extends AdminStates{}

class ImagePickedErrorState extends AdminStates{}

class UploadNewRecipeImageSuccessState extends AdminStates{}

class UploadNewRecipeImageErrorState extends AdminStates{

  final String error;

  UploadNewRecipeImageErrorState(this.error);
}

class UpdateRecipeErrorState extends AdminStates{
  final String error;

  UpdateRecipeErrorState(this.error);

}

class UpdateRecipeSuccessState extends AdminStates{}

class GetAllLunchRecipeLoadingState extends AdminStates {}

class GetAllDinnerRecipeLoadingState extends AdminStates {}

class GetAllBreakFastRecipeLoadingState extends AdminStates {}

class GetAllBreakFastRecipeSuccessState extends AdminStates {}

class GetAllBreakFastRecipeErrorState extends AdminStates
{
  final String error;

  GetAllBreakFastRecipeErrorState(this.error);
}
class GetAllLunchRecipeSuccessState extends AdminStates {}

class GetAllLunchRecipeErrorState extends AdminStates
{
  final String error;

  GetAllLunchRecipeErrorState(this.error);
}
class GetAllDinnerRecipeSuccessState extends AdminStates {}

class GetAllDinnerRecipeErrorState extends AdminStates
{
  final String error;

  GetAllDinnerRecipeErrorState(this.error);
}
class GetAllRecipeSuccessState extends AdminStates {}

class GetAllRecipeErrorState extends AdminStates
{
  final String error;

  GetAllRecipeErrorState(this.error);
}

class SearchRecipeLoadingState extends AdminStates{}

class SearchRecipeSuccessState extends AdminStates{}

class SearchRecipeErrorState extends AdminStates
{
  final String error;
  SearchRecipeErrorState(this.error);
}

class RemoveRecipeImageState extends AdminStates{}



// create product

class CreateProductLoadingState extends AdminStates{}

class CreateProductSuccessState extends AdminStates{}

class CreateProductErrorState extends AdminStates{}

class ProductImagePickedSuccessState extends AdminStates{}

class ProductImagePickedErrorState extends AdminStates{}


class UpdateProductErrorState extends AdminStates{}

class UploadNewProductImageSuccessState extends AdminStates{}

class UploadNewProductImageErrorState extends AdminStates{

  final String error;

  UploadNewProductImageErrorState(this.error);
}
class GetProductsErrorState extends AdminStates
{
  final String error;

  GetProductsErrorState(this.error);
}
class GetProductsSuccessState extends AdminStates{}

class GetProductsLoadingState extends AdminStates{}


class GetStockProductsLoadingState extends AdminStates {}

class GetDashboardProductsSuccessState extends AdminStates{}

class GetDashboardProductsErrorState extends AdminStates{}


class SearchProductLoadingState extends AdminStates{}

class SearchProductSuccessState extends AdminStates{}

class SearchProductErrorState extends AdminStates
{
  final String error;
  SearchProductErrorState(this.error);
}

class AdminGetAllOrdersLoadingState extends AdminStates {}

class AdminGetAllOrdersSuccessState extends AdminStates {}

class AdminGetAllOrdersErrorState extends AdminStates
{
  final String error;

  AdminGetAllOrdersErrorState(this.error);
}

class RemoveProductImageState extends AdminStates{}
class GetAdminDataLoadingState extends AdminStates{}

class GetAdminDataSuccessState extends AdminStates{}

class GetAdminDataErrorState extends AdminStates{
  final String error;
  GetAdminDataErrorState(this.error);
}
