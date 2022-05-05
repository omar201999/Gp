import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/main.dart';
import 'package:gp/modules/user/add_Information/add_information.dart';
import 'package:gp/modules/user/login/cubit/cubit.dart';
import 'package:gp/modules/user/login/cubit/states.dart';
import 'package:gp/modules/user/onBoarding/onBoarding_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/localization/language.dart';


class LoginScreen extends StatelessWidget
{
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    void _changeLanguage(Language language) async {
      Locale _locale = await setLocale(language.languageCode);
      MyApp.setLocale(context, _locale);
    }
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),//..getUsers()
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
        },
        builder:(context,state)
        {
          return Scaffold(
            /*appBar: AppBar(
              backgroundColor: Colors.grey[50],
              elevation: 0,
              titleSpacing: 20.0,
            ),*/
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
                          text: AppLocalizations.of(context).translate("login"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        defaultBodyText(
                          context,
                          text: AppLocalizations.of(context).translate("LOGIN now to be Hulk"),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                          type: TextInputType.emailAddress,
                          controller: emailController ,
                          validate: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return AppLocalizations.of(context).translate("please enter your email");//'please enter your email address ';
                            }

                          },
                          label: AppLocalizations.of(context).translate("Email"),//'Email',
                          prefix: Icons.email_outlined,
                          border: const OutlineInputBorder(),

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
                                return AppLocalizations.of(context).translate("check_pass");//'password is too Short ';
                              }
                            },
                            obscure: LoginCubit.get(context).obScure,
                            suffixPressed: ()
                            {
                              LoginCubit.get(context).changePasswordVisibility();
                            },
                            label: AppLocalizations.of(context).translate("Password"),//'Password',
                            prefix: Icons.lock_outline,
                            border: const OutlineInputBorder(),
                            suffix:LoginCubit.get(context).suffix,
                        ),
                        const SizedBox(
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
                            text: AppLocalizations.of(context).translate("login"),//'Login',
                          ),
                          fallback: (context) =>  Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                             Text(
                              AppLocalizations.of(context).translate("Don't have an account?"),
                            ),
                            defaultTextButton(
                              context,
                              text: AppLocalizations.of(context).translate("Sign Up"),//'Sign Up',
                              function: ()
                              {
                                navigateTo(
                                  context,
                                  OnBoardingScreen(),
                                );
                              },
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButton<Language>(
                              iconSize: 30,
                              hint: defaultBodyText(context,text: AppLocalizations.of(context).translate("change_language")),
                              onChanged: (Language? language) {
                                _changeLanguage(language!);
                              },
                              items: Language.languageList()
                                  .map<DropdownMenuItem<Language>>(
                                    (e) => DropdownMenuItem<Language>(
                                  value: e,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(
                                        e.flag,
                                        style: TextStyle(fontSize: 30),
                                      ),
                                      Text(e.name)
                                    ],
                                  ),
                                ),
                              ).toList(),
                            ),
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
