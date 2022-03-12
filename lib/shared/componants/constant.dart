
import 'package:gp/modules/login/login_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/network/local/cashe_helper.dart';

void signOut(context)
{
  CacheHelper.removeData(
    key: 'uId',
  ).then((value)
  {
    if (value)
    {
      navigateToAndReplacement(context, LoginScreen());
    }
  });
}


String? uId = '';
