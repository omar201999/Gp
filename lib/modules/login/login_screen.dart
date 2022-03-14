import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/admin_layout.dart';
import 'package:gp/layout/home-layout/home_layout.dart';
import 'package:gp/modules/add_Information/add_information.dart';
import 'package:gp/modules/login/cubit/cubit.dart';
import 'package:gp/modules/login/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/network/local/cashe_helper.dart';

class LoginScreen extends StatelessWidget
{
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit()..getUsers(),//..getUsers()
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state)
        {
          if(state is LoginErrorState)
          {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
          if(state is LoginSuccessState)
          {
            LoginCubit.get(context).users.forEach((element)
            {
              if(element.status == 'admin')
              {
                CacheHelper.saveData(
                  key: 'uId',
                  value: state.uId,
                ).then((value) {
                  uId = state.uId;
                  navigateToAndReplacement(context, AdminDashBored());
                }).catchError((error){
                  print(error.toString());
                });
              }
              else
              {
                CacheHelper.saveData(
                  key: 'uId',
                  value: state.uId,
                ).then((value) async {
                  uId = state.uId;
                  navigateToAndReplacement(context, HomeLayout());
                }).catchError((error){
                  print(error.toString());
                });
              }
            });

          }
        },
        builder:(context,state)
        {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[200],
              elevation: 0,
              titleSpacing: 20.0,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key:formKey ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        defaultHeadLineText(
                          context,
                          text: 'Login',
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        defaultBodyText(
                          context,
                          text: 'LOGIN now to be Hulk',
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                          type: TextInputType.emailAddress,
                          controller: emailController ,
                          validate: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'please enter your email address ';
                            }

                          },
                          label: 'Email',
                          prefix: Icons.email_outlined,
                          border: OutlineInputBorder(),

                        ),
                        SizedBox(
                          height: 15.0,
                        ),

                        defaultTextFormField(
                            type: TextInputType.visiblePassword,
                            controller: passwordController ,
                            validate: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'password is too Short ';
                              }
                            },
                            obScure: LoginCubit.get(context).obScure,
                            suffixPressed: ()
                            {
                              LoginCubit.get(context).changePasswordVisibility();
                            },
                            label: 'Password',
                            prefix: Icons.lock_outline,
                            border: OutlineInputBorder(),
                            suffix:LoginCubit.get(context).suffix,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState ,
                          builder: (context) => defaultButton(
                            context,
                            onPreesed: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                );
                              }

                            },
                            text: 'Login',
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                              text: 'Sign Up',
                              function: ()
                              {
                                navigateTo(
                                  context,
                                  AddInformation(),
                                );
                              },

                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
