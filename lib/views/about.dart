import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionScreens extends StatelessWidget {
  const IntroductionScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Color.fromRGBO(241, 250, 238, 1.0),
        pages: [
          PageViewModel(
            title: ' ', //'Introduction 1/5',
            bodyWidget: Container(
              color: Color.fromRGBO(241, 250, 238, 1.0),
              child: Image.asset(
                "assets/launcher/int0.drawio.png",
                fit: BoxFit.fill,
              ),
            ),
            //image: buildImage("assets/launcher/int0.drawio.png"),
            //getPageDecoration, a method to customise the page style
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: ' ', //'Introduction 2/5',
            bodyWidget: Image.asset("assets/launcher/int1.drawio.png"),
            //image: buildImage("assets/launcher/int1.drawio.png"),
            //getPageDecoration, a method to customise the page style
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: ' ', //'Introduction 3/5',
            bodyWidget: Image.asset(
              "assets/launcher/int2.drawio.png",
              fit: BoxFit.cover,
            ),
            //image: buildImage("assets/launcher/int2.drawio.png"),
            //getPageDecoration, a method to customise the page style
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: ' ', // 'Introduction 4/5',
            bodyWidget: Image.asset(
              "assets/launcher/int3.drawio.png",
              fit: BoxFit.contain,
            ),
            //image: buildImage("assets/launcher/int3.drawio.png"),
            //getPageDecoration, a method to customise the page style
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: ' ', //'Introduction 5/5',
            bodyWidget: Image.asset(
              "assets/launcher/int4.drawio.png",
              fit: BoxFit.fitHeight,
            ),
            //image: buildImage("assets/launcher/int4.drawio.png"),
            //getPageDecoration, a method to customise the page style
            decoration: getPageDecoration(),
          ),
        ],
        onDone: () async {
          if (kDebugMode) {
            print("Done clicked");
          }
          var prefs = await SharedPreferences.getInstance();
          var intro = await prefs.setBool('intro', true);

          Navigator.pushReplacementNamed(context, 'handleauthstate');
        },
        //ClampingScrollPhysics prevent the scroll offset from exceeding the bounds of the content.
        scrollPhysics: const ClampingScrollPhysics(),
        showDoneButton: true,
        showNextButton: true,
        showSkipButton: true,
        isBottomSafeArea: true,
        skip: const Text("Skip",
            style:
                TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Orbitron')),
        next: const Text(
          'Next',
          style: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Orbitron'),
        ),
        done: const Text(
          "Done",
          style: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Orbitron'),
        ),
        dotsDecorator: getDotsDecorator(),
      ),
    );
  }

  //widget to add the image on screen
  Widget buildImage(String imagePath, context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          imagePath,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  //method to customise the page style
  PageDecoration getPageDecoration() {
    return const PageDecoration(
      imagePadding: EdgeInsets.only(top: 0),
      pageColor: Color.fromRGBO(241, 250, 238, 1.0),
      bodyPadding: EdgeInsets.only(top: 0, left: 0, right: 0),
      titlePadding: EdgeInsets.only(top: 0),
      bodyTextStyle: TextStyle(color: Colors.black54, fontSize: 15),
    );
  }

  //method to customize the dots style
  DotsDecorator getDotsDecorator() {
    return const DotsDecorator(
      spacing: EdgeInsets.symmetric(horizontal: 2),
      activeColor: Color.fromRGBO(168, 218, 220, 1.0),
      color: Colors.grey,
      activeSize: Size(12, 5),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
    );
  }
}
