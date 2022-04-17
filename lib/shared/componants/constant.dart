
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gp/shared/network/local/cashe_helper.dart';

void signOut(context)
{
  FirebaseAuth.instance.signOut();
  CacheHelper.removeData(
    key: 'uId',
  ).then((value)
  {
    uId = null;
    print(uId.toString());
  });
}


String? uId = '';




