import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/home_layout.dart';
import 'package:gp/modules/user/register/cubit/cubit.dart';
import 'package:gp/modules/user/register/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/cubit/cubit.dart';
import 'package:gp/shared/localization/app_localization%20.dart';

class RegisterScreen extends StatelessWidget
{
  final double weight;
  final double height;
  final String gender;
  final double goalWeight;
  final String? goal;
  final double? active;
  final bool? isMale;
  final int? age;


  RegisterScreen({
    required this.weight,
    required this.height,
    required this.gender,
    required this.goalWeight,
    required this.goal,
    required this.active,
    required this.isMale,
    required this.age

  });


  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var userNameController = TextEditingController();
  var phoneController = TextEditingController();
  var smsController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var formKeyPhone = GlobalKey<FormState>();
  int? totalCalorie;
  int? totalProtein;
  int? totalFats;
  int? totalCarbs;



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
          listener: (context,state)
          {
            if(state is RegisterErrorState)
            {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                  SnackBar(
                    backgroundColor:AppCubit.get(context).constantColor1 ,
                    content: defaultBodyText(context, text: state.error),
                    duration: const Duration(seconds: 3),
                  )
              );
            }
            if (state is CreateUserSuccessState)
            {
              uId=state.uId;
              navigateToAndReplacement(context, HomeLayout());
            /*  CacheHelper.saveData(
                key: 'uId',
                value: state.uId,
              ).then((value) async {
                uId = state.uId;

              }).catchError((error){
                print(error.toString());
              });*/
            }
          },
          builder: (context,state)
          {
            totalCalorie = isMale! ? ((10 * weight + 6.25 * height - 5 * age! + 5) * active!).round() :  ((10 * weight + 6.25 * height - 5 * age! - 161) * active!).round() ;
            if(goal == 'maintain')
            {
              totalCalorie = totalCalorie;
              totalProtein = (1.5 * weight).round();
              totalFats = ((20/100) * totalCalorie!).round();
              totalCarbs = ((totalCalorie! - (4 * totalProtein! + totalFats! )) / 4) .round();
            }else if(goal == 'gain')
            {
              totalCalorie = totalCalorie! +  400;
              totalProtein = (2 * weight).round();
              totalFats = ((30/100) * totalCalorie!).round();
              totalCarbs = ((totalCalorie! - (4 * totalProtein! + totalFats! )) / 4) .round();
            }else
            {
              totalCalorie = totalCalorie! - 400;
              totalProtein = (1.5 * weight).round();
              totalFats = ((20/100) * totalCalorie!).round();
              totalCarbs = ((totalCalorie! - (4 * totalProtein! + totalFats! )) / 4) .round();
            }
            var profileImage = RegisterCubit.get(context).profileImage;

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.grey[50],
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
                                return AppLocalizations.of(context).translate("name must not be empty");//'';
                              }
                              return null;
                            },
                            label: AppLocalizations.of(context).translate("name"),//'Name',
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
                                return AppLocalizations.of(context).translate("please enter your email");
                              }
                            },
                            label: AppLocalizations.of(context).translate("Email"),//'Email',
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
                                return AppLocalizations.of(context).translate("check_pass");// 'password is too Short';
                              }
                            },
                            obscure: RegisterCubit.get(context).obScure,
                            suffixPressed: ()
                            {
                              RegisterCubit.get(context).changePasswordVisibility();
                            },
                            label: AppLocalizations.of(context).translate("Password"),//'Password',
                            prefix: Icons.lock_outline,
                            border: OutlineInputBorder(),
                            suffix:RegisterCubit.get(context).suffix,

                          ),

                          SizedBox(
                            height: 20,
                          ),


                          ConditionalBuilder(
                           condition: state is! RegisterLoadingState ,
                            builder: (context) =>  defaultButton(
                              context,
                              text: AppLocalizations.of(context).translate("Registration"),//'Registration ',
                              onPreesed: ()
                              {
                                if(formKey.currentState!.validate())
                                 {
                                  /* showDialog(
                                    context: context,
                                    builder: (context) => BlocProvider(
                                      create: (BuildContext context) => RegisterCubit(),                                      child: BlocConsumer<RegisterCubit,RegisterStates>(
                                        listener: (context,state){},
                                        builder: (context,state){
                                          return Dialog(
                                            child: Form(
                                              key: formKeyPhone,
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children:
                                                  [
                                                    defaultTextFormField(

                                                      //color: AppCubit.get(context).constantColor1,
                                                        type: TextInputType.phone,
                                                        label: 'Phone',
                                                        border: OutlineInputBorder(),
                                                        prefix: Icons.phone,
                                                        controller: phoneController,
                                                        //hintText: AppLocalizations.of(context).translate("validate_phone"),
                                                        validate: (value){
                                                          if(value!.isEmpty){
                                                            return  AppLocalizations.of(context).translate("validate_phone_form");//'Phone must not be empty';
                                                          }
                                                        }
                                                    ),
                                                    SizedBox(height: 10,),
                                                    defaultTextFormField(
                                                      //color: AppCubit.get(context).constantColor1,
                                                        type: TextInputType.phone,
                                                        label: 'Sms message',
                                                        border: OutlineInputBorder(),
                                                        prefix: Icons.phone,
                                                        controller: smsController,
                                                        //hintText: AppLocalizations.of(context).translate("validate_phone"),
                                                        validate: (value){
                                                          if(value!.isEmpty){
                                                            return  AppLocalizations.of(context).translate("validate_phone_form");//'Phone must not be empty';
                                                          }
                                                        }
                                                    ),

                                                    SizedBox(height: 10,),

                                                    defaultButton(
                                                      context,
                                                      onPreesed: ()
                                                      {

                                                        RegisterCubit.get(context).verifyPhoneNumber(phoneNumber: phoneController.text);


                                                      },
                                                      text:  AppLocalizations.of(context).translate("Registration"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    barrierDismissible: true,
                                  );*/
                                   RegisterCubit.get(context).userRegister(
                                     name: userNameController.text,
                                     email: emailController.text,
                                     password: passwordController.text,
                                     weight: weight,
                                     height: height,
                                     goalWeight: goalWeight,
                                     gender: gender,
                                     age: age,
                                     weeklyGoal: (goalWeight-weight)/4.round(),
                                     goal: goal,
                                     active: active,
                                     totalCalorie: totalCalorie,
                                     totalProtein: totalProtein,
                                     totalFats: (totalFats! / 8).round(),
                                     totalCarbs:totalCarbs,
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
