import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/cubit/cubit.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class AddressAndPhoneChangeScreen extends StatelessWidget {
  var  addressController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener:(context, state){} ,
     builder: (context, state)
    {
      var model = HomeCubit.get(context).userModel;
      if(model!.address != null)
      {
        addressController.text = model.address!;
        phoneController.text =model.phone! ;
      }

      return Scaffold(
        appBar: buildAppBar(
          title:  AppLocalizations.of(context).translate("change_app_bar"),//'Change Your Contact info',
          icon: IconBroken.Arrow___Left_2,
          onPressed: ()
          {
            Navigator.pop(context);
          },
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                children:
                [
                  if(state is UpdateUserDataLoadingState)
                    LinearProgressIndicator(),
                  if(state is UpdateUserDataLoadingState)
                    SizedBox(
                      height: 10,
                    ),
                  defaultTextFormField(
                      color: AppCubit.get(context).constantColor5,
                      type: TextInputType.text,
                      hintText: AppLocalizations.of(context).translate("address"),//' Address',
                      //border: OutlineInputBorder(),
                      prefix:Icons.home,
                      controller: addressController,
                      //hintText: AppLocalizations.of(context).translate("validate_address"),
                      validate: (value){
                        if(value!.isEmpty)
                        {
                          return  AppLocalizations.of(context).translate("validate_address_form");//'Address must not be empty';
                        }
                      }
                  ),
                  SizedBox(height: 10,),
                  defaultTextFormField(
                    color: AppCubit.get(context).constantColor5,
                      type: TextInputType.phone,
                      hintText: AppLocalizations.of(context).translate("phone"),//'Phone',
                      //border: OutlineInputBorder(),
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

                defaultButton(
                 context,
                  text:  AppLocalizations.of(context).translate("Update contact Info"),//'Update contact Info',
                  onPreesed: () {
                   if(formKey.currentState!.validate())
                   {
                     /*if(model.address != null && model.phone != null)
                     {*/
                       HomeCubit.get(context).updateUser(
                         address: addressController.text,
                         phone: phoneController.text,
                       );

                    /* else{
                       //'please enter your address and your phone'
                       showToast(text:  AppLocalizations.of(context).translate("validate_phone_and_address"), state: ToastStates.ERROR);
                     }*/

                   }

                }
                ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    );
  }
}
