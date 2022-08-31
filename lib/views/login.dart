import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/authservice.dart';
import '../providerclasses/providerclasses.dart' as prov;
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  void _provideCredentials(BuildContext context, cred) {
    Provider.of<prov.User>(context, listen: false).setUserCredentials(cred);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () async {
                    await AuthService().signIngWithGoogle();
                    _provideCredentials(
                        context, FirebaseAuth.instance.currentUser);
                    print(Provider.of<prov.User>(context).getUserCredentials);
                  },
                  child: Text('Signin'),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () {},
                  child: Text('Register'),
                ),
              ),
            ),

            SizedBox(
              height: 100.0,
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
      ),
    );
  }
}
