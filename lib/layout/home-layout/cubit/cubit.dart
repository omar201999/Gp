import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/modules/customer_dashboard/CustomerDashBoard_Screen.dart';
import 'package:gp/modules/home/home_screen.dart';
import 'package:gp/modules/market/MarketScreen.dart';
import 'package:gp/modules/recipe/recipe_screen.dart';


class HomeCubit extends Cubit<HomeStates>
{
  HomeCubit() : super(HomeIntitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bodyScreen =
  [
    HomePage(),
    MarketScreen(),
    RecipeScreen(),
    CustomerDashBoardScreen(),

  ];
  void changeBottomNavBar(int index)
  {
    currentIndex = index;
    emit(HomeChangeBottonNavState());
  }

}