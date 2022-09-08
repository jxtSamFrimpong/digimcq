import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/authservice.dart';
import '../providerclasses/providerclasses.dart' as prov;
import 'package:provider/provider.dart';

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
              // Center(
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: MaterialButton(
              //       onPressed: () {},
              //       child: Text('Register'),
              //     ),
              //   ),
              // ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.27,
              )
              // Row(
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.all(12.0),
              //     ),
              //   ],
              // )
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