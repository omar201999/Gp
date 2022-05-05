import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/models/feedback_model.dart';
import 'package:gp/modules/admin/feedback_management/feedback_item_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class FeedBackManagementScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit,AdminStates>(
      listener: (context,state){},
      builder: (context,state)
      {

        return Scaffold(
          appBar: buildAppBar(
            title: 'FeedBack',
            icon: IconBroken.Arrow___Left_2,
            onPressed: ()
            {
              Navigator.pop(context);
            },
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child:Padding(
              padding: const EdgeInsets.all(15),
              child: ConditionalBuilder(
                  condition: AdminCubit.get(context).feedback.isNotEmpty,
                  builder: (context)=>ListView.separated(
                   physics: const NeverScrollableScrollPhysics(),
                   shrinkWrap: true,
                   itemBuilder:(context,index) => buildFeedbackItem(AdminCubit.get(context).feedback[index],context),
                   separatorBuilder: (context,index) => const SizedBox(
                     height: 10,
                   ),
                   itemCount:  AdminCubit.get(context).feedback.length),
                  fallback: (context) => const Center(child: CircularProgressIndicator())

              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildFeedbackItem(FeedBackModel model,context)=>InkWell(
    onTap: ()
    {
      navigateTo(context, FeedBackItemScreen(feedBackModel: model,));
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],//HexColor('#4d4d4d')
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(
              45
          ),
          bottomLeft: Radius.circular(
              30
          ),
        ),
      ),
      height: 280,
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 70,
            ),
            child: Container(
              //height: 200,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                    top:0,
                    bottom: 25,
                    start: 10
                ),
                child: Row(
                  children:
                  [
                    Container(
                      width: 2,
                      height: double.infinity,
                      color: Color.fromRGBO(47, 85, 150,1),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children:
                        [
                          defaultBodyText(context, text: 'Rating is ${model.rating}',fontSize: 15),
                          RatingBar.builder(
                            itemSize: 25,
                            initialRating: model.rating!,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (double value) {

                            },
                          ),
                          defaultBodyText(context, maxLines: 4,overflow: TextOverflow.ellipsis, text: '${model.feedback}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CircleAvatar(
            radius: 50,
            backgroundColor:
            Theme.of(context).scaffoldBackgroundColor,
            child: CircleAvatar(
              radius: 60.0,
              backgroundImage: NetworkImage(
                model.userImage!,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
