import 'package:flutter/material.dart';
import 'package:gp/modules/user/add_Information/add_information.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:glass/glass.dart';

class BoardingModel {
  String? backgroundImage;
  String? title;
  String? body;

  BoardingModel({
    required this.backgroundImage,
    required this.title,
    required this.body
  });


}

class OnBoardingScreen extends StatefulWidget {

  @override
  OnBoardingScreenState createState() => OnBoardingScreenState();

}

class OnBoardingScreenState extends State<OnBoardingScreen> {

  var boardController = PageController();
  List<BoardingModel> boarding = [
    BoardingModel(
      backgroundImage: 'https://images.unsplash.com/photo-1546793665-c74683f339c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=4000&q=80%204000w',
      title: 'Want to maintain, lose or gain weight? 🤔',
      body: 'Our app help you to do it by healthy way. App calculates calories daily and how many calories you should eat.',
    ),

    BoardingModel(
      backgroundImage: 'https://images.unsplash.com/photo-1586277419671-f34cf56500a0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=4775&q=80 4775w',
      title: 'Want to fix the way you drink water? 💧',
      body: 'Our app help you to track your daily water intake to reach the healthy goal.',
    ),

    BoardingModel(
      backgroundImage: 'https://images.unsplash.com/photo-1629358101753-531fa5a2f661?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3600&q=80%203600w',
      title: 'Your partner in health and nutrition 💪',
      body: 'Daily you enter the 3 main meals and our app calculates calories, protein, fats and carbs you have eat from the goal of nutrition plan.',
    ),

    BoardingModel(
      backgroundImage: 'https://images.unsplash.com/photo-1619617257069-3dc8f124c512?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=4000&q=80 4000w',
      title: 'Want to buy healthy food and products? 🛒',
      body: 'You can make order to buy many healthy products and food.',
    ),

    BoardingModel(
      backgroundImage: 'https://firebasestorage.googleapis.com/v0/b/nutrition-system-873a0.appspot.com/o/recipes%2Fimage_picker706153797030710715.jpg?alt=media&token=762bbc48-afb7-42c2-bb8b-9a2f37722193',
      title: 'Make your healthy meal by yourself 🍽️',
      body: 'There are many healthy recipes for you that help you to make delicious and healthy food in the same.',
    ),

    BoardingModel(
      backgroundImage: 'https://images.unsplash.com/photo-1528992761365-34a53564c222?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=4000&q=80%204000w',
      title: 'Know how many your food contains calories 🍛',
      body: 'You can take photo of your food and app detects the image, then gives you how many calories, fats, carbs, protein in your food.',
    ),
  ];

  bool isLast = false;

  void submit() {

    navigateToAndReplacement(context, AddInformation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
          //alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: boardController,
              onPageChanged: (int index){
                if(index == boarding.length - 1){
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
              itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
            ),
          ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 700,
              ),
              child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 8.0,
                    ),
                    Container(
                      height: 40,
                      child: TextButton(
                        onPressed: submit,
                        child: const Text(
                          'SKIP',
                        ),
                      ),
                    ).asGlass(
                      tintColor: Colors.transparent,
                      clipBorderRadius: BorderRadius.circular(15.0),
                    ),
                    const SizedBox(
                      width: 80.0,
                    ),
                     SmoothPageIndicator(
                        controller: boardController,
                        effect: const ExpandingDotsEffect(
                          dotColor: Colors.grey,
                          activeDotColor: defaultColor,
                          dotHeight: 10.0,
                          dotWidth: 10.0,
                          spacing: 5.0,
                          expansionFactor: 2,
                        ),
                        count: boarding.length,
                      ),
                    const Spacer(),
                    defaultRawButton(
                      onPressed: (){
                        if(isLast) {
                          submit();
                        } else {
                          boardController.nextPage(
                            duration: const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        }

                      },
                      icon: Icons.arrow_forward_ios,
                    )


                  ]
              ),
            )
        ],
      )
    );
  }


  Widget buildBoardingItem(BoardingModel model) => Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration (
          image: DecorationImage (
              image: NetworkImage('${model.backgroundImage}'),
              fit: BoxFit.cover
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
            top: 380,
            start: 20,
            end: 20,
            bottom: 100,
          ),
          child: Container(
            child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Text(
                      '${model.title}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      '${model.body}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                )
            ),
          ).asGlass(
            tintColor: Colors.transparent,
            clipBorderRadius: BorderRadius.circular(20.0),
          ),
        ),

      );
}