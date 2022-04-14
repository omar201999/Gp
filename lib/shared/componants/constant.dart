
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gp/modules/user/login/login_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/network/local/cashe_helper.dart';

void signOut(context)
{
  FirebaseAuth.instance.signOut();
  CacheHelper.removeData(
    key: 'uId',
  ).then((value)
  {
    if (value)
    {
      //navigateToAndReplacement(context, LoginScreen());
      uId = '';
    }
  });
  print(uId.toString());
}


String? uId = '';




