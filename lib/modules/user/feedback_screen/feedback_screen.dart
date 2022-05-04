import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/cubit/cubit.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class FeedbackScreen extends StatefulWidget {

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}
enum goalAchieve {yes,partially,no}
class _FeedbackScreenState extends State<FeedbackScreen> {
  goalAchieve? goalGroup ;
  String? goal;
  double? rating = 3 ;

  var feedBackController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  String chooseGoalAchieve(goalAchieve state) {
    String? goal;

    switch (state) {
      case goalAchieve.yes:
        goal = 'yes';
        break;
      case goalAchieve.partially:
        goal = 'partially';
        break;
      case goalAchieve.no:
        goal = 'no';
        break;
    }
    return goal;
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return BlocConsumer<HomeCubit,HomeStates>(
          listener: (context,state){},
          builder: (context,state)
          {
            var feedbackImage = HomeCubit.get(context).feedBackImage;

            return Scaffold(
              appBar: buildAppBar(
                title:  AppLocalizations.of(context).translate("FeedBack"),
                icon: IconBroken.Arrow___Left_2,
                onPressed: ()
                {
                  Navigator.pop(context);
                  //HomeCubit.get(context).removeFeedBackImage();
                },
                actions: [
                  defaultTextButton(
                    context,
                    function: ()
                    {
                      if(formKey.currentState!.validate())
                      {
                        if ( goal == null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                            SnackBar(
                              backgroundColor:AppCubit.get(context).constantColor1 ,
                              content: defaultBodyText(context, text: AppLocalizations.of(context).translate("please enter are you achieve your goal or not?")),
                              duration: const Duration(seconds: 2),
                            )
                        );
                      }
                      else
                        {
                          if(HomeCubit.get(context).feedBackImage == null)
                          {
                            HomeCubit.get(context).createFeedBack(feedback: feedBackController.text, rating: rating!, goalAchieve: goal!);
                            HomeCubit.get(context).removeFeedBackImage();

                          }
                          else {
                            HomeCubit.get(context).uploadFeedBackImage(feedback: feedBackController.text, rating: rating!, goalAchieve: goal!);
                            HomeCubit.get(context).removeFeedBackImage();

                          }
                          ScaffoldMessenger.of(context)
                                .showSnackBar(
                                SnackBar(
                                  backgroundColor:AppCubit.get(context).constantColor1 ,
                                  content: defaultBodyText(context, text: AppLocalizations.of(context).translate("FeedBack Send Successfully Thank You")),
                                  duration: const Duration(seconds: 2),
                                )
                            );
                        }
                      }

                    },
                   text: AppLocalizations.of(context).translate("Send"),
                  ),
                ],
              ),
              body: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [

                          defaultHeadLineText(
                              context,
                              text: AppLocalizations.of(context).translate("Do You achieve our Goal ?"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          defaultContainer(
                            context,
                            radius: 15,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children:
                                [
                                  RadioListTile<goalAchieve>(
                                    contentPadding: EdgeInsets.zero,
                                    title:  defaultBodyText(context, text: AppLocalizations.of(context).translate("yes")),//AppLocalizations.of(context).translate("gain")
                                    value: goalAchieve.yes,
                                    groupValue: goalGroup,
                                    onChanged: (goalAchieve? value) {
                                      setState(() {
                                        goalGroup = value!;
                                        goal = chooseGoalAchieve(goalAchieve.yes);
                                        //print(goal.toString());
                                      });
                                    },
                                  ),
                                  RadioListTile<goalAchieve>(
                                    contentPadding: EdgeInsets.zero,
                                    title: defaultBodyText(context, text: AppLocalizations.of(context).translate("partially")),
                                    value: goalAchieve.partially,
                                    groupValue: goalGroup,
                                    onChanged: (goalAchieve? value) {
                                      setState(() {
                                        goalGroup = value!;
                                        goal = chooseGoalAchieve(goalAchieve.partially);
                                        //print(goal.toString());
                                      });
                                    },
                                  ),
                                  RadioListTile<goalAchieve>(
                                    // activeColor: Colors.white,
                                    contentPadding: EdgeInsets.zero,
                                    title:  defaultBodyText(context, text:AppLocalizations.of(context).translate("no")),
                                    value: goalAchieve.no,
                                    groupValue: goalGroup,
                                    onChanged: (goalAchieve? value) {
                                      setState(() {
                                        goalGroup = value!;
                                        goal = chooseGoalAchieve(goalAchieve.no);
                                        //print(goal.toString());
                                      });
                                    },

                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          defaultContainer(
                            context,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  defaultHeadLineText(context, text:AppLocalizations.of(context).translate("Rate This App")),
                                  RatingBar.builder(
                                    initialRating: rating!,
                                    itemCount: 5,
                                    minRating: 1,
                                    updateOnDrag: true,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 5),
                                    itemBuilder: (context, index) {
                                      switch (index) {
                                        case 0:
                                          return Icon(
                                            Icons.sentiment_very_dissatisfied,
                                            color: Colors.red,
                                          );
                                        case 1:
                                          return Icon(
                                            Icons.sentiment_dissatisfied,
                                            color: Colors.redAccent,
                                          );
                                        case 2:
                                          return Icon(
                                            Icons.sentiment_neutral,
                                            color: Colors.amber,
                                          );
                                        case 3:
                                          return Icon(
                                            Icons.sentiment_satisfied,
                                            color: Colors.lightGreen,
                                          );
                                        case 4:
                                          return Icon(
                                            Icons.sentiment_very_satisfied,
                                            color: Colors.green,
                                          );
                                      }
                                      return Icon(
                                        Icons.sentiment_very_dissatisfied,
                                        color: Colors.red,
                                      );
                                    },
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        this.rating = rating;
                                      });
                                      print(this.rating);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          defaultContainer(
                            context,
                            height: 200,
                            //color: constantColor5,
                            child: defaultTextFormField(
                              controller: feedBackController,
                              type: TextInputType.multiline,
                              //color: ,
                              maxLines: 30,
                              hintText: AppLocalizations.of(context).translate("Tell Us Your FeedBack and any complaint"),
                              validate: (String? value)
                              {
                                if(value!.isEmpty)
                                {
                                  return AppLocalizations.of(context).translate("please enter your feedback");
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                HomeCubit.get(context).getFeedbackImage();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:  [
                                  Expanded(child: defaultBodyText(context,text: AppLocalizations.of(context).translate("Please enter photo to explain your complaint"),fontSize: 15)),
                                  Icon(IconBroken.Upload),
                                ],
                              )
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          if(HomeCubit.get(context).feedBackImage != null)
                            Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              defaultContainer(
                                context,
                                height: 150.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    image: DecorationImage(
                                        image: FileImage(feedbackImage!),
                                        fit: BoxFit.cover
                                    )
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },

    );
  }
}
