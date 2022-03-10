import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/models/user_model.dart';
import 'package:gp/modules/register/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit() : super(RegisterInitialState());
  
  static RegisterCubit get(context) => BlocProvider.of(context);


  void userRegister({
    required String name,
    required String email,
    required String password,
    required double weight,
    required double height,
    required double goalWeight,
    required String gender,
})
  {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.
    createUserWithEmailAndPassword
      (
        email: email.trim(),
        password: password,
    ).then((value) {
      userCreate(
          name: name,
          email: email.trim(),
          uId: value.user!.uid,
          weight: weight,
          height: height,
          goalWeight: goalWeight,
          gender: gender
      );

    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
      print(error.toString());


    });

  }

  void userCreate({
  required String name,
    required String email,
    required String uId,
    required double weight,
    required double height,
    required double goalWeight,
    required String gender,



  })
  {
    UserModel model = UserModel(
      name: name,
      uId: uId,
      email: email.trim(),
      weight: weight,
      gender: gender,
      goalweight: goalWeight,
      height: height,
    );
    FirebaseFirestore.instance.
    collection('users').
    doc(uId).
    set(model.toMap()).
    then((value) {
      emit(CreateUserSuccessState(uId));
    }).
    catchError((error)
    {
      emit(CreateUserErrorState(error));
      print(error.toString());
    });

  }


}