import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../providerclasses/providerclasses.dart' as prov;

class SchemeEdge extends StatefulWidget {
  @override
  State<SchemeEdge> createState() => _SchemeEdgeState();
}

class _SchemeEdgeState extends State<SchemeEdge> {
  //const SchemeEdge({Key? key}) : super(key: key);
  Future<void> uploadingData(
      String _uid,
      String _testDocID,
      String _student_idx,
      String _got_marks,
      String _out_of,
      String _img_url,
      List _answers) async {
    var result = await FirebaseFirestore.instance
        .collection(_uid.toString())
        .doc(_testDocID)
        .collection('students')
        .doc(_student_idx)
        //.collection(_student_idx)
        .set({
      'student_idx': _student_idx,
      'got_marks': _got_marks,
      'out_of': _out_of,
      'img_url': _img_url,
      'answers': _answers
    });
    //return result.id;
  }

  String? _lastImagePath;

  bool? _lastImageIsAScheme;

  @override
  void initState() {
    super.initState();
  }

  provideImage() {
    if (_lastImagePath == null) {
      return AssetImage('assets/testplaceholderimage.jpg');
    }
    return FileImage(File(_lastImagePath!));
  }

  Future<void> getImage(marking) async {
    String? imagePath;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      imagePath = (await EdgeDetection.detectEdge);
      print("$imagePath");
    } on PlatformException catch (e) {
      imagePath = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      if (marking) {
        //async send to api and do something about it
      } else {
        //async send to api and do something about it
      }

      return;
    }

    setState(() {
      _lastImagePath = imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _cred = Provider.of<prov.User>(context).getUserCredentials;
    var _testDocID = Provider.of<prov.User>(context).getTestDocID;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            color: Colors.amberAccent,
            child: FadeInImage(
              placeholder: AssetImage('assets/testplaceholderimage.jpg'),
              //image: NetworkImage('https://picsum.photos/250?image=9'),
              image: provideImage(),
            ),
          ),
        ),
        //Spacer(),
        Container(
            //decoration: BoxDecoration(backgroundBlendMode: BlendMode.color),
            //height: MediaQuery.of(context).size.height * 0.1,
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: () {
                getImage(true);
                uploadingData(
                  _cred.uid,
                  _testDocID,
                  _testDocID.toString().toUpperCase(),
                  '50',
                  '60',
                  '_img_url',
                  [],
                );
              },
              child: Text('Mark'),
            ),
            MaterialButton(
              onPressed: () {
                getImage(false);
              },
              child: Text('Key'),
            )
          ],
        ))
      ],
    );

    // Scaffold(
    //   appBar: PreferredSize(
    //     preferredSize: Size.fromHeight(70.0),
    //     child: Padding(
    //       padding: const EdgeInsets.all(10.0),
    //       child: AppBar(
    //         toolbarHeight: 50.0,
    //         //backgroundColor: Colors.white,
    //         backgroundColor: Colors.purpleAccent,
    //         elevation: 0.0,
    //         // leading: IconButton(
    //         //   icon: Icon(
    //         //     Icons.menu,
    //         //     color: Colors.black,
    //         //   ),
    //         //   onPressed: () {},
    //         // ),
    //         title: Text(
    //           "APP_NAME",
    //           style: TextStyle(color: Colors.black),
    //         ),
    //         actions: [
    //           IconButton(
    //               onPressed: () {},
    //               icon: Icon(
    //                 Icons.search,
    //                 color: Colors.black,
    //               ))
    //         ],
    //       ),
    //     ),
    //   ),
    //   body: Column(
    //     children: [
    //       Expanded(
    //           child: Column(
    //         children: [
    //           Container(
    //             color: Colors.amberAccent,
    //             child: AspectRatio(
    //               aspectRatio: 105 / 151,
    //               child: FadeInImage(
    //                 placeholder: AssetImage('assets/testplaceholderimage.jpg'),
    //                 //image: NetworkImage('https://picsum.photos/250?image=9'),
    //                 image: provideImage(),
    //               ),
    //             ),
    //           ),
    //           Container()
    //         ],
    //       )),
    //       Container(
    //           //decoration: BoxDecoration(backgroundBlendMode: BlendMode.color),
    //           height: MediaQuery.of(context).size.height * 0.1,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               MaterialButton(
    //                 onPressed: () {
    //                   getImage(true);
    //                 },
    //                 child: Text('Mark'),
    //               ),
    //               MaterialButton(
    //                 onPressed: () {
    //                   getImage(false);
    //                 },
    //                 child: Text('Key'),
    //               )
    //             ],
    //           ))
    //     ],
    //   ),
    // );
  }
}
