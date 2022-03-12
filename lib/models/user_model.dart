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
  String? active;
  String? profileImage;
  String? status ;
  double? weeklyGoal;
  int? age;

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
      };
  }





}