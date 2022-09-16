/*

 */

//Fluter packages
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';

//Flutter pub.dev packages
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

//My modular imports
import 'package:digimcq/views/studentSummary.dart';
import 'package:provider/provider.dart';
import 'views/createTestPage.dart';
import 'views/testInfo.dart';
import 'views/indiStudentInfo.dart';
import 'views/about.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'scandy/edge.dart';
import 'providerclasses/providerclasses.dart';
import 'views/schemeedge.dart';
import 'views/login.dart';
import 'utils/authservice.dart';
import 'views/profile.dart';
import 'scandy/apirelearn.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FlutterNativeSplash.remove();

  var prefs = await SharedPreferences.getInstance();
  var intro;
  try {
    intro = prefs.getBool('intro');
  } catch (e) {
    print('try getting intro error');
    print(e);
  }
  if (intro == null) {
    intro = false;
    //if (kDebugMode) {
    print('intro null check:  $intro');
    //}
  } else {
    intro = true;
  }
  runApp(MyApp(intro));
}

class MyApp extends StatelessWidget {
  var intro;
  MyApp(this.intro);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    () {
      print(' arbitrary function works');
    };
    return MultiProvider(
      providers: [
        //ChangeNotifierProvider.value(value: Counter()),
        ChangeNotifierProvider.value(value: User())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          //initialRoute: 'handleauthstate',
          initialRoute: 'introhandler',
          routes: {
            //'welcome':
            'handleauthstate': (context) => AuthService().handleAuthState(),
            'introhandler': (context) => IntroHandler(intro),
            'home': (context) => MyHomePage(),
            'test_info': (context) => TestInfo(),
            'student_summeary': (context) => StudentsSummary(),
            'individual': (context) => IndividualStudentInfo(),
            'profile': (context) => ProfilePage(),
            'createtest': (context) => CreateTestPage(),
            'about': (context) => IntroductionScreens()
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

IntroHandler(intro) {
  return intro ? AuthService().handleAuthState() : IntroductionScreens();
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var prefs;
  var intro;

  @override
  void initState() {
    // TODO: implement initState
    setState(() async {
      prefs = await SharedPreferences.getInstance();
      intro = prefs.getInt('intro');
      if (intro == null) {
        intro = 0;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return intro ? IntroductionScreens() : AuthService().handleAuthState();
  }
}

// class ProviderTrial extends StatelessWidget {
//   void _incrementCounter(BuildContext context) {
//     Provider.of<Counter>(context, listen: false).incrementCounter();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var _counter = Provider.of<Counter>(context).getCounter;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Provider trial'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _incrementCounter(context);
//         },
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
