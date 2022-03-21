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
class SearchLoadingBreakFastState extends HomeStates {}

class SearchSuccessBreakFastState extends HomeStates {}

class SearchErrorBreakFastState extends HomeStates
{
  final String error;

  SearchErrorBreakFastState(this.error);
}
class SearchLoadingDinnerState extends HomeStates {}

class SearchSuccessDinnerState extends HomeStates {}

class SearchErrorDinnerState extends HomeStates
{
  final String error;

  SearchErrorDinnerState(this.error);
}
class SearchLoadingSnacksState extends HomeStates {}

class SearchSuccessSnacksState extends HomeStates {}

class SearchErrorSnacksState extends HomeStates
{
  final String error;

  SearchErrorSnacksState(this.error);
}
class SearchLoadingLunchState extends HomeStates {}

class SearchSuccessLunchState extends HomeStates {}

class SearchErrorLunchState extends HomeStates
{
  final String error;

  SearchErrorLunchState(this.error);
}
class SearchLoadingState extends HomeStates {}

class SearchSuccessState extends HomeStates {}

class SearchErrorState extends HomeStates
{
  final String error;

  SearchErrorState(this.error);
}

class protienSuccessState extends HomeStates {}

class protienErrorState extends HomeStates
{
  final String error;

  protienErrorState(this.error);
}
class ChangeCheckBoxState extends HomeStates{}

class SearchMealSuccessState extends HomeStates {}

class SearchMealErrorState extends HomeStates
{
  final String error;

  SearchMealErrorState(this.error);
}