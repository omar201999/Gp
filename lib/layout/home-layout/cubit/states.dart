abstract class HomeStates {}

class HomeIntitialState extends HomeStates{}

class HomeChangeBottonNavState extends HomeStates{}

class GetUserDataLoadingState extends HomeStates{}

class GetUserDataSuccessState extends HomeStates{}

class GetUserDataErrorState extends HomeStates
{
  final String error;
  GetUserDataErrorState(this.error);
}

class GetProfileImageLoadingState extends HomeStates{}

class GetProfileImageSuccessState extends HomeStates{}

class GetProfileImageErrorState extends HomeStates{}

class UpdateUserDataSuccessState extends HomeStates{}

class UpdateUserDataErrorState extends HomeStates{}

class UploadProfileImageLoadingState extends HomeStates{}

class UploadProfileImageSuccessState extends HomeStates{}

class UploadProfileImageErrorState extends HomeStates{}

class GetAllBreakFastRecipeSuccessState extends HomeStates {}

class GetAllBreakFastRecipeErrorState extends HomeStates
{
  final String error;

  GetAllBreakFastRecipeErrorState(this.error);
}
class GetAllLunchRecipeSuccessState extends HomeStates {}

class GetAllLunchRecipeErrorState extends HomeStates
{
  final String error;

  GetAllLunchRecipeErrorState(this.error);
}
class GetAllDinnerRecipeSuccessState extends HomeStates {}

class GetAllDinnerRecipeErrorState extends HomeStates
{
  final String error;

  GetAllDinnerRecipeErrorState(this.error);
}


