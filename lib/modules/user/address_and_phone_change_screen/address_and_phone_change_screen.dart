import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
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
      if(model!.address == null)
      {
        addressController.text = '9 ali abdelfath street qsr elshama masr elqdema';
        phoneController.text = '01147881089';
      }else
      {
        addressController.text = model.address!;
        phoneController.text =model.phone! ;
      }

      return Scaffold(
        appBar: buildAppBar(
          title: 'Change Your Contact info',
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
              child: Column(
                children:
                [
                  defaultTextFormField(
                      type: TextInputType.text,
                      label: ' Address',
                      border: OutlineInputBorder(),
                      prefix:Icons.home,
                      controller: addressController,
                      validate: (value){
                        if(value!.isEmpty){
                          return 'Address must not be empty';
                        }
                      }
                  ),
                  SizedBox(height: 10,),
                  defaultTextFormField(
                      type: TextInputType.phone,
                      label: 'Phone',
                      border: OutlineInputBorder(),
                      prefix: Icons.phone,
                      controller: phoneController,
                      validate: (value){
                        if(value!.isEmpty){
                          return 'Phone must not be empty';
                        }
                      }
                  ),
                  SizedBox(height: 10,),

                defaultButton(
                 context,
                  text: 'Update contact Info',
                  onPreesed: () {
                  HomeCubit.get(context).updateUser(
                    address: addressController.text,
                    phone: phoneController.text,
                  );
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
