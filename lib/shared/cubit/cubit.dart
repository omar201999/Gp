import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/shared/cubit/states.dart';
import 'package:gp/shared/network/local/cashe_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  bool isDark = false;

  void changeAppMode({ bool? fromShared})
  {
    if (fromShared != null)
    {
      isDark = fromShared;

    }
    else{
      isDark = !isDark;

      CacheHelper.saveData(key: 'isDark', value: isDark).then((value)
      {
        emit(AppChangeModeState());
      });

    }


  }
}