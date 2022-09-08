/*

 */

//Fluter packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';

//Flutter pub.dev packages
import 'package:firebase_core/firebase_core.dart';

//My modular imports
import 'package:digimcq/views/studentSummary.dart';
import 'package:provider/provider.dart';
import 'views/createTestPage.dart';
import 'views/testInfo.dart';
import 'views/indiStudentInfo.dart';
import 'scandy/edge.dart';
import 'providerclasses/providerclasses.dart';
import 'views/schemeedge.dart';
import 'views/login.dart';
import 'utils/authservice.dart';
import 'scandy/apirelearn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //ChangeNotifierProvider.value(value: Counter()),
        ChangeNotifierProvider.value(value: User())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: 'handleauthstate',
          //initialRoute: 'home',
          routes: {
            //'welcome':
            'handleauthstate': (context) => AuthService().handleAuthState(),
            'home': (context) => MyHomePage(),
            'test_info': (context) => TestInfo(),
            'student_summeary': (context) => StudentsSummary(),
            'individual': (context) => IndividualStudentInfo()
          },
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.grey,
          )),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        //body: ApiRelearn(),
        body: Login(),
      ),
    );
  }
}

class ProviderTrial extends StatelessWidget {
  void _incrementCounter(BuildContext context) {
    Provider.of<Counter>(context, listen: false).incrementCounter();
  }

  @override
  Widget build(BuildContext context) {
    var _counter = Provider.of<Counter>(context).getCounter;

    return Scaffold(
      appBar: AppBar(
        title: Text('Provider trial'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
