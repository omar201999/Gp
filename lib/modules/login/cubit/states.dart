abstract class LoginStates {}

class LoginInitialState extends LoginStates{}

class LoginChangePasswordVisibilityState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginSuccessState extends LoginStates
{
  final String uId;

  LoginSuccessState(this.uId);
}

class LoginErrorState extends LoginStates
{
  //final String error;
  //LoginErrorState(this.error);
}

class GetUserDataLoadingState extends LoginStates{}

class GetUserDataSuccessState extends LoginStates{}

class GetUserDataErrorState extends LoginStates
{
  //final String error;
  //GetUserDataErrorState(this.error);
}
class GetAllUsersSuccessState extends LoginStates{}

class GetAllUsersErrorState extends LoginStates{
  final String error;
  GetAllUsersErrorState(this.error);
}



