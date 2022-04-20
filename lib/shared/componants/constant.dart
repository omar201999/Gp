
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';

Future<void> signOut(context)
async{
  uId = '';
  print(uId.toString());
  HomeCubit.get(context).userModel=null;
  print( HomeCubit.get(context).userModel.toString());
  await FirebaseAuth.instance.signOut();
  /*CacheHelper.removeData(
    key: 'uId',
  ).then((value)
  {
    uId = '';

  });*/
}


String? uId = '';




