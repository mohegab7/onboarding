import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/shop_app/login/login_shop.dart';
import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_application_1/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class boardingModel {
  late final String image;
  late final String title;
  late final String body;
  boardingModel({
    required this.image,
    required this.body,
    required this.title,
  });
}

// ignore: must_be_immutable
class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var boardController = PageController();

  List<boardingModel> boarding = [
    boardingModel(
      image:
          'https://storage.googleapis.com/profit-prod/wp-content/uploads/2022/05/cd0bb0f3-employee-onboarding.png',
      body: 'onbody 1',
      title: 'on title 1',
    ),
    boardingModel(
      image:
          'https://storage.googleapis.com/profit-prod/wp-content/uploads/2022/05/cd0bb0f3-employee-onboarding.png',
      body: 'onbody 2',
      title: 'on title 2',
    ),
    boardingModel(
      image:
          'https://storage.googleapis.com/profit-prod/wp-content/uploads/2022/05/cd0bb0f3-employee-onboarding.png',
      body: 'onbody 3',
      title: 'on title 3',
    ),
  ];

  bool  islast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [TextButton( onPressed: () {NavigateAndFinish(context, LoginShop_Screen());  }, child: Text('SKIP',style: TextStyle(fontSize: 30)),)],),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                itemBuilder: (BuildContext context, int index) =>
                    buildboardingitem(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (int index) {
                  if(index == boarding.length-1){
                    setState(() {
                      islast=true;
                    });
                    print('last');
                  }
                  else{
                    print('not last');
                    setState(() {
                      islast=false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(controller: boardController,
                 count: boarding.length,
                 effect: ExpandingDotsEffect(
                  dotHeight: 12.0,
                  dotWidth: 12.0,
                  spacing: 5.0,
                  expansionFactor: 4,
                  activeDotColor: defaultColor,
                 ),),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (islast) {
                      Navigateto(context, widget);
                    }
                    boardController.nextPage(
                        duration: Duration(
                          milliseconds: 950,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn);
                  },
                  child: Icon(Icons.arrow_forward_ios_outlined),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildboardingitem(boardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: NetworkImage('${model.image}'),
            ),
          ),
          Text(
            '${model.title}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${model.body}',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      );
}
