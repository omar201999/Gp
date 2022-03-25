class UserModel
{
  String? name;
  String?  email;
  String? uId;
  double? weight;
  double? height;
  String? gender;
  double? goalWeight;
  String? goal;
  double? active;
  String? profileImage;
  String? status ;
  double? weeklyGoal;
  int? age;
  int? totalCalorie;
  int? totalProtein;
  int? totalCarbs;
  int? totalFats;
  int? totalWater;

  UserModel({
    this.name,
    this.email,
    this.uId,
    this.weight,
    this.height,
    this.gender,
    this.goalWeight,
    this.active,
    this.goal,
    this.profileImage,
    this.status,
    this.weeklyGoal,
    this.age,
    this.totalCalorie,
    this.totalCarbs,
    this.totalFats,
    this.totalProtein,
    this.totalWater,

  });
  UserModel.fromJson(Map<String ,dynamic>? json)
  {
    uId=json!['uId'];
    email=json['email'];
    name=json['name'];
    weight=json['weight'];
    height=json['height'];
    gender=json['gender'];
    goalWeight=json['goalWeight'];
    goal=json['goal'];
    active=json['active'];
    profileImage=json['profileImage'];
    status=json['status'];
    weeklyGoal=json['weeklyGoal'];
    age=json['age'];
    totalCalorie=json['totalCalorie'];
    totalCarbs=json['totalCarbs'];
    totalFats=json['totalFats'];
    totalProtein=json['totalProtein'];
    totalWater=json['totalWater'];




  }

  Map<String ,dynamic> toMap()
  {
    return
      {
        'name':name,
        'email':email,
        'uId':uId,
        'weight':weight,
        'height':height,
        'gender':gender,
        'goalWeight':goalWeight,
        'goal':goal,
        'active':active,
        'profileImage':profileImage,
        'status':status,
        'weeklyGoal':weeklyGoal,
        'age': age,
        'totalCalorie': totalCalorie,
        'totalCarbs': totalCarbs,
        'totalFats': totalFats,
        'totalProtein': totalProtein,
        'totalWater': totalWater,

      };
  }
}