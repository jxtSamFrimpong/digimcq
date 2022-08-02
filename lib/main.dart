import 'package:digimcq/views/studentSummary.dart';
import 'package:digimcq/views/testEDInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'views/createTestPage.dart';
import 'views/testInfo.dart';
import 'views/testInfo.dart';
import 'views/indiStudentInfo.dart';
//import 'views/CameraInput.dart';
//import 'package:camera/camera.dart';
import 'dart:async';
import 'dart:io';
import 'scandy/edge.dart';
//import 'package:edge_detection/edge_detection.dart';

//import 'views/CameraInput.dart';
//import 'package:camera/camera.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:edge_detection/edge_detection.dart';

//late List<CameraDescription> cameras;

void main() async {
  // try {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   cameras = await availableCameras();
  // } on CameraException catch (e) {
  //   print('Error in fetching the cameras: $e');
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: 'home',
        routes: {
          'home': (context) => MyHomePage(),
          //'camera': (context) => CameraApp(),
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
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: EdgeApp(),
    );
  }
}

// class CameraApp extends StatefulWidget {
//   const CameraApp({Key? key}) : super(key: key);

//   @override
//   State<CameraApp> createState() => _CameraAppState();
// }

// class _CameraAppState extends State<CameraApp> {
//   CameraController? controller;
//   bool _isCameraInitialized = false;
//   final resolutionPresets = ResolutionPreset.values;
//   ResolutionPreset currentResolutionPreset = ResolutionPreset.high;

//   void onNewCameraSelected(CameraDescription cameraDescription) async {
//     final previousCameraController = controller;
//     // Instantiating the camera controller
//     final CameraController cameraController = CameraController(
//       cameraDescription,
//       currentResolutionPreset,
//       imageFormatGroup: ImageFormatGroup.jpeg,
//     );

//     // Dispose the previous controller
//     await previousCameraController?.dispose();

//     // Replace with the new controller
//     if (mounted) {
//       setState(() {
//         controller = cameraController;
//       });
//     }

//     // Update UI if controller updated
//     cameraController.addListener(() {
//       if (mounted) setState(() {});
//     });

//     // Initialize controller
//     try {
//       await cameraController.initialize();
//     } on CameraException catch (e) {
//       print('Error initializing camera: $e');
//     }

//     // Update the Boolean
//     if (mounted) {
//       setState(() {
//         _isCameraInitialized = controller!.value.isInitialized;
//       });
//     }
//   }

//   @override
//   void initState() {
//     // Hide the status bar
//     SystemChrome.setEnabledSystemUIOverlays([]);
//     onNewCameraSelected(cameras[0]);
//     super.initState();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     final CameraController? cameraController = controller;

//     // App state changed before we got the chance to initialize.
//     if (cameraController == null || !cameraController.value.isInitialized) {
//       return;
//     }

//     if (state == AppLifecycleState.inactive) {
//       // Free up memory when camera not active
//       cameraController.dispose();
//     } else if (state == AppLifecycleState.resumed) {
//       // Reinitialize the camera with same properties
//       onNewCameraSelected(cameraController.description);
//     }
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: _isCameraInitialized
//           ? AspectRatio(
//               aspectRatio: 1 / controller!.value.aspectRatio,
//               child: controller!.buildPreview(),
//             )
//           : Container(),
//     );
//   }
// }

// class EdgeApp extends StatefulWidget {
//   const EdgeApp({Key? key}) : super(key: key);

//   @override
//   State<EdgeApp> createState() => _EdgeAppState();
// }

// class _EdgeAppState extends State<EdgeApp> {
//   String? _imagePath;

//   @override
//   void initState() {
//     super.initState();
//   }

//   Future<void> getImage() async {
//     String? imagePath;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     // We also handle the message potentially returning null.
//     try {
//       imagePath = (await EdgeDetection.detectEdge);
//       print("$imagePath");
//     } on PlatformException catch (e) {
//       imagePath = e.toString();
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       _imagePath = imagePath;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Center(
//             child: ElevatedButton(
//               onPressed: getImage,
//               child: Text('Scan'),
//             ),
//           ),
//           SizedBox(height: 20),
//           Text('Cropped image path:'),
//           Padding(
//             padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
//             child: Text(
//               _imagePath.toString(),
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 14),
//             ),
//           ),
//           Visibility(
//             visible: _imagePath != null,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Image.file(
//                 File(_imagePath ?? ''),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




// class Pickled extends StatefulWidget {
//   const Pickled({Key? key}) : super(key: key);

//   @override
//   State<Pickled> createState() => _PickledState();
// }

// class _PickledState extends State<Pickled> {
//   File? _image;

//   final _picker = ImagePicker();
//   // Implementing the image picker
//   Future<void> _openImagePicker() async {
//     final XFile? pickedImage =
//         await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       setState(() {
//         _image = File(pickedImage.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: MaterialButton(
//                   color: Colors.blue,
//                   child: const Text("Pick Image from Gallery",
//                       style: TextStyle(
//                           color: Colors.white70, fontWeight: FontWeight.bold)),
//                   onPressed: () async {
//                     _openImagePicker();
//                   }),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: MaterialButton(
//                   color: Colors.blue,
//                   child: const Text("Pick Image from Camera",
//                       style: TextStyle(
//                           color: Colors.white70, fontWeight: FontWeight.bold)),
//                   onPressed: () async {
//                     String? imagePath = await EdgeDetection.detectEdge;
//                   }),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 alignment: Alignment.center,
//                 width: double.infinity,
//                 //height: 300,
//                 color: Colors.grey[300],
//                 child: _image != null
//                     ? Image.network(_image!.path)
//                     : const Text('Please select an image'),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// CameraApp is the Main Application.
// class CameraApp extends StatefulWidget {
//   /// Default Constructor
//   const CameraApp({Key? key}) : super(key: key);

//   @override
//   State<CameraApp> createState() => _CameraAppState();
// }

// class _CameraAppState extends State<CameraApp> {
//   late CameraController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = CameraController(_cameras[0], ResolutionPreset.max);
//     controller.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     }).catchError((Object e) {
//       if (e is CameraException) {
//         switch (e.code) {
//           case 'CameraAccessDenied':
//             print('User denied camera access.');
//             break;
//           default:
//             print('Handle other errors.');
//             break;
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!controller.value.isInitialized) {
//       return Container();
//     }
//     return MaterialApp(
//       home: CameraPreview(controller),
//     );
//   }
// }
