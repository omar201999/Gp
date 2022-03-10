import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/modules/Lunch/cubit/states.dart';

class LunchCuibt extends Cubit<LunchStates>
{
  LunchCuibt() : super(LunchIntitialState());
  static LunchCuibt get(context) => BlocProvider.of(context);


  List<bool> isChecked =
  [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,

  ] ;

  Widget icon = Icon(Icons.check_box_outline_blank_outlined);

  void changeCheckBox (index,value)
  {
    isChecked[index] = value;

    emit(LunchChangeCheckBoxState());
  }


  /*void changeIconButtom()
  {
    isChecked = !isChecked;
    icon = isChecked ? Icon(Icons.check_box_outline_blank_outlined) : Icon(Icons.check_box) ;
    emit(breakfastChangeCheckBoxState());
  }
*/

}