import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/home_layout.dart';
import 'package:gp/modules/register/cubit/cubit.dart';
import 'package:gp/modules/register/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';

class RegisterScreen extends StatelessWidget
{
  final double weight;
  final double height;
  final String gender;
  final double goalweight;
  RegisterScreen({
    required this.weight,
    required this.height,
    required this.gender,
    required this.goalweight,


  });

  var emailContrller = TextEditingController();
  var passwordContrller = TextEditingController();
  var userNameContrller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
          listener: (context,state)
          {
            if (state is CreateUserSuccessState)
            {
              navigateTo(context, HomeLayout());
            }
          },
          builder: (context,state)
          {
            return Scaffold(

              appBar: buildAppBar(
                title: 'Sing In',
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children:
                    [
                      defualtTextFormField(
                        controller: emailContrller,
                        type: TextInputType.emailAddress,
                        validate: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'please enter your email';
                          }
                        },
                        label: 'Email',

                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defualtTextFormField(
                        controller: passwordContrller,
                        type: TextInputType.visiblePassword,
                        validate: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'please enter password';
                          }
                        },
                        label: 'Password',

                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defualtTextFormField(
                        controller: userNameContrller,
                        type: TextInputType.text,
                        validate: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'please enter your name';
                          }
                        },
                        label: 'Name',

                      ),
                      SizedBox(
                        height: 20,
                      ),

                      DefaultButton(
                        context,
                        text: 'Registration ',
                        onPreesed: ()
                        {
                          if(formKey.currentState!.validate())
                          {
                            RegisterCubit.get(context).userRegister(
                                name: userNameContrller.text,
                                email: emailContrller.text,
                                password: passwordContrller.text,
                                weight: weight,
                                height: height,
                                goalWeight: goalweight,
                                gender: gender
                            );
                          }

                        },
                      ),


                    ],
                  ),
                ),
              ),
            );
          },
          ),
    );
  }
}
