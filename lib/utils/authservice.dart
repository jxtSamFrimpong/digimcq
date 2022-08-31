import 'package:digimcq/views/createTestPage.dart';
import 'package:digimcq/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../providerclasses/providerclasses.dart' as prov;

class AuthService {
  //handleAuthstate
  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          //print(FirebaseAuth.instance.currentUser);
          //Provider.of<Counter>(context, listen: false).incrementCounter();
          Provider.of<prov.User>(context, listen: false)
              .setUserCredentials(FirebaseAuth.instance.currentUser);
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.blue,
              body: CreateTestPage(),
            ),
          );
        } else {
          return Login();
        }
      },
    );
  }

  //signin
  signIngWithGoogle() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>['email']).signIn(); //google signin

    //obtaiin auth details from request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    //create a new credential
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    //once signed in return the user credential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //signout
  signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
