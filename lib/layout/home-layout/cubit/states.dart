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
class SearchitemState extends HomeStates {}

class SearchSuccessitemState extends HomeStates {}

class SearchErroritemState extends HomeStates
{
  final String error;

  SearchErroritemState(this.error);
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

class SearchAddSnacksSuccessState extends HomeStates {}

class SearchAddSnacksErrorState extends HomeStates
{
  final String error;

  SearchAddSnacksErrorState(this.error);
}
class SearchAddBreakFastSuccessState extends HomeStates {}

class SearchAddBreakFastErrorState extends HomeStates
{
  final String error;

  SearchAddBreakFastErrorState(this.error);
}
class SearchAddDinnerSuccessState extends HomeStates {}

class SearchAddDinnerErrorState extends HomeStates
{
  final String error;

  SearchAddDinnerErrorState(this.error);
}
class SearchAddLunchSuccessState extends HomeStates {}

class SearchAddLunchErrorState extends HomeStates
{
  final String error;

  SearchAddLunchErrorState(this.error);
}
class GetAllUsersMealsLoadingState extends HomeStates {}

class GetAllUsersMealsSuccessState extends HomeStates {}

class GetAllUsersMealsErrorState extends HomeStates
{
  final String error;

  GetAllUsersMealsErrorState(this.error);
}

// for water tracker

class AddWaterGlassState extends HomeStates{}

class MinusWaterGlassState extends HomeStates{}

class AddCartItemSuccessState extends HomeStates{}

class AddCartItemErrorState extends HomeStates
{
  final String error;

  AddCartItemErrorState(this.error);
}

class UpdateCartItemSuccessState extends HomeStates{}

class UpdateCartItemErrorState extends HomeStates
{
  final String error;

  UpdateCartItemErrorState(this.error);
}

class GetCartItemSuccessState extends HomeStates{}

class GetCartItemLoadingState extends HomeStates{}

class GetCartItemErrorState extends HomeStates
{
  final String error;

  GetCartItemErrorState(this.error);
}

class DeleteCartItemSuccessState extends HomeStates{}

class DeleteCartItemErrorState extends HomeStates
{
  final String error;

  DeleteCartItemErrorState(this.error);
}
class minusState extends HomeStates{}

class plusState extends HomeStates{}

class CreateOrderLoadingState extends HomeStates {}

class CreateOrderSuccessState extends HomeStates {}

class CreateOrderErrorState extends HomeStates {}