
class RecipeModel
{
  String? title;
  String? titleAr;
  String? image;
  double? carbs;
  double? protein;
  double? fats;
  double? calories;
  String? ingredients;
  String? ingredientsAr;
  String? directions;
  String? directionsAr;
  String? category;
  String? uId;
  num? totalRating;
  num? numOfRates;
  num? averageRating;
  //bool? isFavorite;
  //String? userId;



  RecipeModel({
    this.uId,
    this.title,
    this.image,
    this.carbs,
    this.protein,
    this.fats,
    this.calories,
    this.ingredients,
    this.directions,
    this.category,
    this.totalRating,
    this.numOfRates,
    this.averageRating,
    this.titleAr,
    this.directionsAr,
    this.ingredientsAr,
    //this.isFavorite,
    //this.userId,

  });

  RecipeModel.fromJson(Map<String, dynamic>? json){
    uId = json!['uId'];
    title = json['title'];
    image = json['image'];
    carbs = json['carbs'];
    protein = json['protein'];
    fats = json['fats'];
    calories = json['calories'];
   // weight = json['weight'];
    ingredients = json['ingredients'];
    directions = json['directions'];
    category = json['category'];
    totalRating=json['totalRating'];
    numOfRates=json['numOfRates'];
    averageRating=json['averageRating'];
    titleAr=json['titleAr'];
    directionsAr=json['directionsAr'];
    ingredientsAr=json['ingredientsAr'];
    //isFavorite=json['isFavorite'];
    //userId=json['userId'];


    //totalTime = json['totalTime'];

  }

  Map<String, dynamic> toMap()
  {
    return {
      'uId':uId,
      'title':title,
      'image':image,
      'carbs':carbs,
      'protein':protein,
      'fats':fats,
      'calories':calories,
      //'weight':weight,
      'ingredients':ingredients,
      'directions':directions,
      'category':category,
      'totalRating' :totalRating,
      'numOfRates' :numOfRates,
      'averageRating' :averageRating,
      'titleAr' :titleAr,
      'directionsAr' :directionsAr,
      'ingredientsAr' :ingredientsAr,
      //'isFavorite' :isFavorite,
      //userId' :userId,


      //'totalTime':totalTime

    };
  }


}