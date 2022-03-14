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

