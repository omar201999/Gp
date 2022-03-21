class MealsModel
{
  int? id;
  String? Food;
  String? Measure;
  int? Carbs;
  int? Protein;
  int? Fat;
  int? Calories;
  int? Grams;




  MealsModel({
    this.Food,
    this.Measure,
    this.Carbs,
    this.Protein,
    this.Fat,
    this.Calories,
    this.id,
    this.Grams
  });

  MealsModel.fromJson(Map<String, dynamic>? json){
    id = json!['id'];
    Food = json['Food'];
    Measure = json['Measure'];
    Carbs = json['Carbs'];
    Protein = json['Protein'];
    Fat = json['Fat'];
    Calories = json['Calories'];
    Grams = json['Grams'];


  }

  Map<String, dynamic> toMap()
  {
    return {
      'Food':Food,
      'Measure':Measure,
      'Carbs':Carbs,
      'Protein':Protein,
      'Fat':Fat,
      'id':id,
      'Calories':Calories,
      'Grams':Grams,

    };
  }


}