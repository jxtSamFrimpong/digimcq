import 'package:flutter/material.dart';
import '../utils/authservice.dart';
import '../providerclasses/providerclasses.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  void _provideCredentials(BuildContext context, cred) {
    Provider.of<User>(context, listen: false).setUserCredentials(cred);
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
                  onPressed: () {
                    Object cred = AuthService().signIngWithGoogle();
                    _provideCredentials(context, cred);
                    print(Provider.of<User>(context).getUserCredentials());
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
