abstract class CartStates{}

class CartInitialState extends CartStates {}

class AddCartItemSuccessState extends CartStates{}

class AddCartItemErrorState extends CartStates
{
  final String error;

  AddCartItemErrorState(this.error);
}

class UpdateCartItemSuccessState extends CartStates{}

class UpdateCartItemErrorState extends CartStates
{
  final String error;

  UpdateCartItemErrorState(this.error);
}

class GetCartItemSuccessState extends CartStates{}

class GetCartItemLoadingState extends CartStates{}

class GetCartItemErrorState extends CartStates
{
  final String error;

  GetCartItemErrorState(this.error);
}

class DeleteCartItemSuccessState extends CartStates{}

class DeleteCartItemErrorState extends CartStates
{
  final String error;

  DeleteCartItemErrorState(this.error);
}