
class RecipeModel
{
  String? title;
  String? image;
  double? carbs;
  double? protein;
  double? fats;
  double? calories;
  double? weight;
  String? ingredients;
  String? directions;
  String? category;
  //int? totalTime;
  String? uId;

  RecipeModel({
    this.title,
    this.image,
    this.carbs,
    this.protein,
    this.fats,
    this.calories,
    this.weight,
    this.ingredients,
    this.directions,
    this.category,
    //this.totalTime,
    this.uId
  });

  RecipeModel.fromJson(Map<String, dynamic>? json){
    uId = json!['uId'];
    title = json['title'];
    image = json['image'];
    carbs = json['carbs'];
    protein = json['protein'];
    fats = json['fats'];
    calories = json['calories'];
    weight = json['weight'];
    ingredients = json['ingredients'];
    directions = json['directions'];
    category = json['category'];
    //totalTime = json['totalTime'];

  }

  Map<String, dynamic> toMap()
  {
    return {
      'title':title!.toLowerCase(),
      'image':image,
      'carbs':carbs,
      'protein':protein,
      'fats':fats,
      'calories':calories,
      'weight':weight,
      'ingredients':ingredients,
      'directions':directions,
      'category':category,
      'uId':uId
      //'totalTime':totalTime

    };
  }


}