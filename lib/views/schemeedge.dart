import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../providerclasses/providerclasses.dart' as prov;
import 'package:dio/dio.dart';
import 'dart:convert';
import '../services/TeleStorageModel.dart';

class SchemeEdge extends StatefulWidget {
  @override
  State<SchemeEdge> createState() => _SchemeEdgeState();
}

class _SchemeEdgeState extends State<SchemeEdge> {
  //const SchemeEdge({Key? key}) : super(key: key);
  late bool markSchemePresent;

  // retrieveMarkScheme(_uid, _testDocID) async {
  //   var scheme = await FirebaseFirestore.instance
  //       .collection(_uid.toString())
  //       .doc(_testDocID)
  //       .get()
  //       .then((value) => value.data()!['scheme']);
  //   print(scheme);
  // }

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

  Future<String?> getImage(marking) async {
    String? imagePath;
    var file_ids;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      imagePath = (await EdgeDetection.detectEdge);
      // setState(() {
      //   _lastImagePath = imagePath;
      // });

      print("$imagePath" + "ok");
      return imagePath;
    } on PlatformException catch (e) {
      imagePath = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      if (marking) {
        setState(() {
          _lastImagePath = imagePath;
        });
      } else {
        //async send to api and do something about it
        //file_ids = await sendFileGetID(imagePath);
        setState(() {
          _lastImagePath = imagePath;
        });
      }

      //return;
    }

    // setState(() {
    //   _lastImagePath = imagePath;
    //   print(_lastImagePath);
    // });
  }

  @override
  Widget build(BuildContext context) {
    var _cred = Provider.of<prov.User>(context).getUserCredentials;
    var _testDocID = Provider.of<prov.User>(context).getTestDocID;
    var _endNumber = provideEndNumber(context, _cred.uid, _testDocID);
    print(_endNumber);

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
              onPressed: () async {
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
              child: Text('Mark Script'),
            ),
            MaterialButton(
              onPressed: () async {
                var file_path = await getImage(false);
                setState(() {
                  _lastImagePath = file_path;
                });

                var something = await sendFileGetID(file_path.toString());

                var file_id =
                    teleStorageFromJson(jsonDecode(something)).data.fileId;
                print(file_id);
              },
              child: Text('Key'),
            )
          ],
        ))
      ],
    );
  }
}

Future<void> uploadingData(
  String _uid,
  String _testDocID,
  String _student_idx,
  String _got_marks,
  String _out_of,
  String _img_url,
  List _answers,
) async {
  //Before firebase upload we need _img_url and _answers from our api
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
    'answers': _answers,
    // 'file_id': file_ids['data']['file_id'],
    // 'file_unique_id': file_ids['data']['file_unique_id']
  });
  //return result.id;
}

Future uploadMarkScheme(scheme_list, uid, test_id) async {
  var res = await FirebaseFirestore.instance
      .collection(uid)
      .doc(test_id)
      .update({"scheme": scheme_list});
}

// Future<Map> sendFileGetID(file_Path) async {
//   Response response;
//   var dio = Dio();
//   String BASE_URL = 'http://20.237.63.30:8080/teleStorageGetFileID';
//   var formData = FormData.fromMap({
//     'file': await MultipartFile.fromFile(file_Path),
//     // 'files': [
//     //   await MultipartFile.fromFile('./text1.txt', filename: 'text1.txt'),
//     //   await MultipartFile.fromFile('./text2.txt', filename: 'text2.txt'),
//     // ]
//   });
//   response = await dio.post(BASE_URL, data: formData);
//   response
//   print(response.data);
//   return jsonDecode(response.data);
// }

Future<Map> markScheme(file_id, test_id, end_number) async {
  Response response;
  var dio = Dio();

  String BASE_URL = 'http://20.237.63.30:8080/mark_scheme';
  bool scheme_or_paper = true;

  Map params = {
    "file_id": file_id,
    "test_id": test_id,
    "end_number": end_number,
    "scheme_or_paper": scheme_or_paper
  };

  response = await dio.post(BASE_URL, data: jsonEncode(params));

  return jsonDecode(response.data);
}

// retrieveAnswersToMarkingScheme(file_ids, test_id, endNumber) async {
//   //TODO markScheme
//   Map scheme = await markScheme(file_ids['data']['file_id'], 'test_id', 40);
//   if (scheme != null) {
//     //print(scheme['data']['scheme']);
//     return scheme;
//   }
// }
Future provideEndNumber(BuildContext context, uid, doc_id) async {
  var _end = await FirebaseFirestore.instance
      .collection(uid)
      .doc(doc_id)
      .get()
      .then((value) => value.data()!['endNumber']);
  return _end;
}
