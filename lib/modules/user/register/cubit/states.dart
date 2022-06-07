abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates
{
  final String error;

  RegisterErrorState(this.error);
}

class CreateUserSuccessState extends RegisterStates
{
  final String uId;


  CreateUserSuccessState(this.uId);

}

class CreateUserErrorState extends RegisterStates
{
  final String error;

  CreateUserErrorState(this.error);
}

class RegisterChangePasswordVisibilityState extends RegisterStates {}

class RegisterImagePickerSuccessState extends RegisterStates {}

class RegisterImagePickerErrorState extends RegisterStates {}

class RegisterUploadProfileImageSuccessState extends RegisterStates {}

class RegisterUploadProfileImageErrorState extends RegisterStates {}