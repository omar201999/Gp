
import 'package:intl/intl.dart';

class MealsModel {
  num? id;
  String? Measure;
  String? measureAr;
  String? Food;
  String? foodAr;
  num? Carbs;
  num? Protein;
  num? Fat;
  num? Calories;
  num? Grams;
  String? Date ;

  MealsModel({
    this.Food,
    this.Carbs,
    this.Protein,
    this.Fat,
    this.Calories,
    this.Grams,
    this.Measure,
    this.foodAr,
    this.measureAr,
    this.Date,
    this.id,

  });

  MealsModel.fromJson(Map<String, dynamic>? json) {
    id = json!['id'];
    Food = json['Food'];
    Carbs = json['Carbs'];
    Protein = json['Protein'];
    Fat = json['Fat'];
    Calories = json['Calories'];
    Grams = json['Grams'];
    Measure = json['Measure'];
    foodAr = json['foodAr'];
    measureAr = json['measureAr'];
    Date = json['Date'] /*== null ? DateTime.now() : json['Date'].toDate()*/;
  }

  Map<String, dynamic> toMap() {
    return {
      'Food': Food,
      'id': id,
      'Carbs': Carbs,
      'Protein': Protein,
      'Fat': Fat,
      'Calories': Calories,
      'Grams': Grams,
      'Measure': Measure,
      'foodAr': foodAr,
      'measureAr': measureAr,
      'Date': DateFormat('d MMMM y').format(DateTime.now()),
    };
  }
}
