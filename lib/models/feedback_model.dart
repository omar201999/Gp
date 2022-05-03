class FeedBackModel
{
  String? userName;
  String? userEmail;
  String? userImage;
  String? feedbackImage;
  String? feedback;
  double? rating;
  String? goalAchieve;

  FeedBackModel({
    this.userName,
    this.userEmail,
    this.userImage,
    this.feedbackImage,
    this.rating,
    this.feedback,
    this.goalAchieve,
});
  FeedBackModel.fromjson(Map<String,dynamic>? json)
  {
    feedback=json!['feedback'];
    userName=json['userName'];
    userEmail=json['userEmail'];
    userImage=json['userImage'];
    feedbackImage=json['feedbackImage'];
    rating=json['rating'];
    goalAchieve=json['goalAchieve'];
  }

  Map<String,dynamic> toMap()
  {
    return
      {
       'feedback' : feedback,
       'userName' : userName,
       'userEmail' : userEmail,
       'userImage' : userImage,
       'feedbackImage' : feedbackImage,
       'rating' : rating,
       'goalAchieve' : goalAchieve,
      };
  }

}