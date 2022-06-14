import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:gp/models/feedback_model.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class FeedBackItemScreen extends StatelessWidget
{
  FeedBackModel feedBackModel;
  FeedBackItemScreen({
   required this.feedBackModel,
});
  String customerSatisfaction()
  {
    if(feedBackModel.rating! == 1)
    {
      return 'Very Bad';
    }
    else if(feedBackModel.rating! == 2)
    {
      return 'Bad';
    }
    else if(feedBackModel.rating! == 3)
    {
      return 'Good';
    }
    else if(feedBackModel.rating! == 4)
    {
      return ' Very Good';
    }
    else
      {
        return 'Excellent';
      }
  }


  @override
  Widget build(BuildContext context) {
    double rating = feedBackModel.rating!;
    Icon change(rating)
    {
      switch (rating) {
        case 1:
          return Icon(
            Icons.sentiment_very_dissatisfied,
            color: Colors.red,
          );
        case 2:
          return Icon(
            Icons.sentiment_dissatisfied,
            color: Colors.redAccent,
          );
        case 3:
          return Icon(
            Icons.sentiment_neutral,
            color: Colors.amber,
          );
        case 4:
          return Icon(
            Icons.sentiment_satisfied,
            color: Colors.lightGreen,
          );
        case 5:
          return Icon(
            Icons.sentiment_very_satisfied,
            color: Colors.green,
          );
      }
      return Icon(
        Icons.sentiment_very_satisfied,
        color: Colors.green,
      );
    }
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children:
            [
              if(feedBackModel.feedbackImage != null)
                Stack(
                alignment: AlignmentDirectional.topStart,
                children:
                [
                  Image(image: NetworkImage(feedBackModel.feedbackImage!)),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        top: 5,
                        start: 10
                    ),
                    child: Container(
                      height: 40,
                      width: 40,
                      child: IconButton(
                        color: defaultColor,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon( IconBroken.Arrow___Left_2, ),
                      ),
                    ).asGlass(
                      tintColor: Colors.transparent,
                      clipBorderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ],
              ),
              if(feedBackModel.feedbackImage == null)
                Row(
                  children:
                  [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          top: 5,
                          start: 10
                      ),
                      child: Container(
                        height: 40,
                        width: 40,
                        child: IconButton(
                          color: defaultColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon( IconBroken.Arrow___Left_2, ),
                        ),
                      ).asGlass(
                        tintColor: Colors.transparent,
                        clipBorderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ],
                ),


                Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [

                    defaultContainer(
                      context,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            defaultBodyText(context, text: 'User Name is ${feedBackModel.userName!}'),
                            defaultBodyText(context, text: 'User Email is ${feedBackModel.userEmail!}'),
                            defaultBodyText(context, text: 'User Rating is ${feedBackModel.rating}'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultContainer(
                      context,
                      //height: 200,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: defaultBodyText(context, text: feedBackModel.feedback!,height: 2.3),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultContainer(
                      context,
                      width: double.infinity,
                      //height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Expanded(child: defaultBodyText(context, text: 'Achievement of user is ${feedBackModel.goalAchieve!}')),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    defaultContainer(
                      context,
                      width: double.infinity,
                      //height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(child: defaultBodyText(context, text: 'Customer Satisfaction is ${customerSatisfaction()}')),
                            change(rating),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
