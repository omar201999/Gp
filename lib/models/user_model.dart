class UserModel
{
  String? name;
  String?  email;
  String? uId;
  double? weight;
  double? height;
  String? gender;
  double? goalweight;
  UserModel({
    this.name,
    this.email,
    this.uId,
    this.weight,
    this.height,
    this.gender,
    this.goalweight,
});
  UserModel.fromJson(Map<String ,dynamic>? json)
  {
    uId=json!['uId'];
    email=json['email'];
    name=json['name'];
    weight=json['weight'];
    height=json['height'];
    gender=json['gender'];
    goalweight=json['goalweight'];
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
        'goalweight':goalweight,



      };
  }





}