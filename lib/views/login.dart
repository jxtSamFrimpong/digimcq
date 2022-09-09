import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/authservice.dart';
import '../providerclasses/providerclasses.dart' as prov;
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //const Login({Key? key}) : super(key: key);
  var signInButtonPressed = false;

  void _provideCredentials(BuildContext context, cred) {
    Provider.of<prov.User>(context, listen: false).setUserCredentials(cred);
  }

  loadingCircleOrRow(bool i) {
    return i
        ? SizedBox(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(29, 53, 87, 1.0),
            ),
            height: 20.0,
            width: 20.0,
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/login/icons8-google-64.png',
                height: 20.0,
                width: 20.0,
              ),
              Text(
                '    Sign in',
                style: TextStyle(
                  fontFamily: 'Orbitron',
                  color: Color.fromRGBO(29, 53, 87, 1.0),
                ),
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.height);
    // print(MediaQuery.of(context).size.width);
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/login/layered-waves-haikei.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 50.0,
              ),
              Container(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(14.0),
                //   color: Color.fromRGBO(69, 123, 157, 1.0),
                // ),
                height: 300,
                width: 300,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/login/data-sheet-256.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      'MCQ GRADER',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rampart_One',
                        color: Color.fromRGBO(29, 53, 87, 1.0),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Expanded(
                child: SizedBox(
                  //height: 100.0,
                  //width: 250.0,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Orbitron',
                      color: Color.fromRGBO(29, 53, 87, 1.0),
                    ),
                    child: AnimatedTextKit(
                      totalRepeatCount: 10,
                      pause: const Duration(milliseconds: 2500),
                      //displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                      animatedTexts: [
                        TyperAnimatedText('In just three simple steps'),
                        TyperAnimatedText('Create your Test'),
                        TyperAnimatedText('Generate the Key to the test'),
                        TyperAnimatedText("Mark your student's scripts"),
                      ],
                      onTap: () {
                        print("Tap animatet text Event");
                      },
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    //color: Color.fromRGBO(168, 218, 220, 1.0),
                    onPressed: () async {
                      setState(() {
                        signInButtonPressed = true;
                      });
                      await AuthService().signIngWithGoogle();
                      _provideCredentials(
                          context, FirebaseAuth.instance.currentUser);
                      print(Provider.of<prov.User>(context).getUserCredentials);
                    },
                    child: Container(
                      height: 50.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                        color: Color.fromRGBO(168, 218, 220, 1.0),
                      ),
                      alignment: Alignment.center,
                      child: loadingCircleOrRow(signInButtonPressed),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.23,
              )
            ],
          ),
        ],
      )),
    );
  }
}

// decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/login/layered-waves-haikei.png'),
//             ),
//           ),