
class MealsModel {
  String? Measure;
  String? measureAr;
  String? Food;
  String? foodAr;
  num? Carbs;
  num? Protein;
  num? Fat;
  num? Calories;
  num? Grams;
  DateTime? Date ;

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
  });

  MealsModel.fromJson(Map<String, dynamic>? json) {
    Food = json!['Food'];
    Carbs = json['Carbs'];
    Protein = json['Protein'];
    Fat = json['Fat'];
    Calories = json['Calories'];
    Grams = json['Grams'];
    Measure = json['Measure'];
    foodAr = json['foodAr'];
    measureAr = json['measureAr'];
    Date = json['Date'] == null ? DateTime.now() : json['Date'].toDate();
  }

  Map<String, dynamic> toMap() {
    return {
      'Food': Food,
      'Carbs': Carbs,
      'Protein': Protein,
      'Fat': Fat,
      'Calories': Calories,
      'Grams': Grams,
      'Measure': Measure,
      'foodAr': foodAr,
      'measureAr': measureAr,
      'Date': DateTime.now(),
    };
  }
}
