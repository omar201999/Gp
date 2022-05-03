import 'package:flutter/material.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';

class BlockUser extends StatelessWidget {
  const BlockUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Center(
          child: Column(
            children: [
              /*   if(HomeCubit.get(context).userModel!.userActive != null)
                        CircularProgressIndicator(),*/
              //if(HomeCubit.get(context).userModel!.userActive == null)
              defaultHeadLineText(context, text: 'Email has been removed due to abusive behaviour'),
              //if(HomeCubit.get(context).userModel!.userActive == null)
              defaultTextButton(context, function: ()
              {
                signOut(context);
              }, text: 'Log Out'),
            ],
          ),
        ),
      ),
      );
  }
}
