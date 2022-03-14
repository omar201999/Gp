import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/home_layout.dart';
import 'package:gp/modules/user/register/cubit/cubit.dart';
import 'package:gp/modules/user/register/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/network/local/cashe_helper.dart';

class RegisterScreen extends StatelessWidget
{
  final double weight;
  final double height;
  final String gender;
  final double goalWeight;
  final String? goal;
  final String? active;




  RegisterScreen({
    required this.weight,
    required this.height,
    required this.gender,
    required this.goalWeight,
    required this.goal,
    required this.active,


  });

  var emailController = TextEditingController();
  var ageController = TextEditingController();
  var passwordController = TextEditingController();
  var userNameController = TextEditingController();
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
          },
          builder: (context,state)
          {
            var profileImage = RegisterCubit.get(context).profileImage;

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.grey[200],
                elevation: 0,
                titleSpacing: 20.0,
              ),
              body: Center(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children:
                        [
                          if(state is RegisterLoadingState)
                            LinearProgressIndicator(),
                          if(state is RegisterLoadingState)
                            SizedBox(
                              height: 10,
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  CircleAvatar(
                                    radius: 65,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 62,
                                      backgroundImage: profileImage == null ? NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png') : FileImage(profileImage) as ImageProvider ,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: ()
                                      {
                                        RegisterCubit.get(context).getProfileImage();
                                      },
                                      icon: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.camera,
                                          size: 16,
                                        ),
                                      ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          defaultTextFormField(
                            controller: userNameController,
                            type: TextInputType.text,
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'please enter your Name';
                              }
                            },
                            label: 'Name',
                            prefix: Icons.person,
                            border: OutlineInputBorder(),

                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultTextFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'please enter your email';
                              }
                            },
                            label: 'Email',
                            prefix: Icons.email_outlined,
                            border: OutlineInputBorder(),


                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultTextFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'password is too Short';
                              }
                            },
                            obScure: RegisterCubit.get(context).obScure,
                            suffixPressed: ()
                            {
                              RegisterCubit.get(context).changePasswordVisibility();
                            },
                            label: 'Password',
                            prefix: Icons.lock_outline,
                            border: OutlineInputBorder(),
                            suffix:RegisterCubit.get(context).suffix,

                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultTextFormField(
                            controller: ageController,
                            type: TextInputType.number,
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'please enter your Age';
                              }
                            },
                            label: 'Age',
                            border: OutlineInputBorder(),

                          ),
                          SizedBox(
                            height: 20,
                          ),


                          ConditionalBuilder(
                           condition: state is! RegisterLoadingState ,
                            builder: (context) =>  defaultButton(
                              context,
                              text: 'Registration ',
                              onPreesed: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  RegisterCubit.get(context).userRegister(
                                    name: userNameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    weight: weight,
                                    height: height,
                                    goalWeight: goalWeight,
                                    gender: gender,
                                    age: int.parse(ageController.text),
                                    weeklyGoal: (goalWeight-weight)/4.round(),
                                    goal: goal,
                                    active: active,
                                  );
                                }

                              },
                            ),
                            fallback: (context) => Center(child: CircularProgressIndicator()),
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
