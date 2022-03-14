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
