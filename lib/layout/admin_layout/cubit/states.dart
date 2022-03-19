abstract class AdminStates {}

class AdminInitialState extends AdminStates {}

class ChangeBottomNavState extends AdminStates{}

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



// create product

class CreateProductLoadingState extends AdminStates{}

class CreateProductSuccessState extends AdminStates{}

class CreateProductErrorState extends AdminStates{}

class ProductImagePickedSuccessState extends AdminStates{}

class ProductImagePickedErrorState extends AdminStates{}

class GetProductsSuccessState extends AdminStates{}

class GetProductsErrorState extends AdminStates
{
  final String error;

  GetProductsErrorState(this.error);
}
