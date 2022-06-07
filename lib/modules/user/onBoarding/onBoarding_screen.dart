import 'package:flutter/material.dart';
import 'package:gp/modules/user/add_Information/add_information.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
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

  bool isLast = false;

  void submit() {

    navigateToAndReplacement(context, AddInformation());
  }

  @override
  Widget build(BuildContext context) {
    List<BoardingModel> boarding = [
      BoardingModel(
        backgroundImage: 'assets/images/onBoarding_1.webp',
        title: AppLocalizations.of(context).translate('on_boarding_screen1_title'),
        body: AppLocalizations.of(context).translate('on_boarding_screen1_body'),
      ),

      BoardingModel(
        backgroundImage: 'assets/images/onBoarding_2.webp',
        title: AppLocalizations.of(context).translate('on_boarding_screen2_title'),
        body: AppLocalizations.of(context).translate('on_boarding_screen2_body'),
      ),

      BoardingModel(
        backgroundImage: 'assets/images/onBoarding_3.webp',
        title: AppLocalizations.of(context).translate('on_boarding_screen3_title'),
        body: AppLocalizations.of(context).translate('on_boarding_screen3_body'),
      ),

      BoardingModel(
        backgroundImage: 'assets/images/onBoarding_4.webp',
        title: AppLocalizations.of(context).translate('on_boarding_screen4_title'),
        body: AppLocalizations.of(context).translate('on_boarding_screen4_body'),
      ),

      BoardingModel(
        backgroundImage: 'assets/images/onBoarding_5.jpg',
        title: AppLocalizations.of(context).translate('on_boarding_screen5_title'),
        body: AppLocalizations.of(context).translate('on_boarding_screen5_body'),
      ),

      BoardingModel(
        backgroundImage: 'assets/images/onBoarding_6.webp',
        title: AppLocalizations.of(context).translate('on_boarding_screen6_title'),
        body: AppLocalizations.of(context).translate('on_boarding_screen6_body'),
      ),
    ];

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
                //top: 780,
                top: 700,
               /* start: 20,
                end: 20,*/
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
              image: AssetImage('${model.backgroundImage}'),
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