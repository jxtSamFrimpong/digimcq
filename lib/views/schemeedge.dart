import 'package:digimcq/services/markscript.dart';
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
import '../services/markscheme.dart';
import '../services/markscript.dart';

class SchemeEdge extends StatefulWidget {
  @override
  State<SchemeEdge> createState() => _SchemeEdgeState();
}

class _SchemeEdgeState extends State<SchemeEdge> {
  //const SchemeEdge({Key? key}) : super(key: key);
  late bool markSchemePresent;

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
    var _endNumber = Provider.of<prov.User>(context).getEndNumber;
    print('inside build');
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
                // getImage(true);
                // uploadingData(
                //   _cred.uid,
                //   _testDocID,
                //   _testDocID.toString().toUpperCase(),
                //   '50',
                //   '60',
                //   '_img_url',
                //   [],
                // );
                var file_path = await getImage(false);
                setState(() {
                  _lastImagePath = file_path;
                });

                var something = await sendFileGetID(file_path.toString());

                var file_id =
                    teleStorageFromJson(jsonDecode(something)).data.fileId;

                var mark_scheme =
                    await provideMarkScheme(_cred.uid, _testDocID);
                print('see if test has a scheme');
                //print(mark_scheme);
                print('yeah it does');

                var scriptData = await getMarkScript(file_id, _testDocID,
                    int.parse(_endNumber.toString()), mark_scheme);

                try {
                  print('try script stuff');
                  //print(scriptData['data']['score']);
                  //print(scriptData['data']['answers']);
                  print('working');
                } catch (e) {
                  print(e);
                }

                //updata or set students results to cloud
                try {
                  await uploadingData(
                      _cred.uid,
                      _testDocID.toString(),
                      scriptData['data']['index_number'],
                      scriptData['data']['score'],
                      scriptData['data']['out_of'],
                      file_id,
                      scriptData['data']['answers']);
                } catch (e) {
                  print(e);
                }

                //check if data was updated on firebase
                try {
//
                } catch (e) {
                  //
                }
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
                //print(file_id);

                var schemeData = await getMarkScheme(
                    file_id, _testDocID, int.parse(_endNumber.toString()));
                // var passedScheme = markSchemeFromJson(jsonDecode(schemeData));
                try {
                  print('try scheme stuff');
                  //print(schemeData['data']['scheme']);
                  print('working');
                } catch (e) {
                  print(e);
                }
                // print('try paased scheme stuff');
                // print(passedScheme.data.scheme);
                try {
                  print('update mark scheme on firebase');
                  await uploadMarkScheme(
                      schemeData['data']['scheme'], _cred.uid, _testDocID);
                  print('check if it really updated');
                  // var updated_mark_scheme = await FirebaseFirestore.instance
                  //     .collection(_cred.uid)
                  //     .doc(_testDocID)
                  //     .get();
                  print('yeah it does');
                } catch (e) {
                  print(e);
                }
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
  var _got_marks,
  var _out_of,
  String _img_url,
  List _answers,
) async {
  //Before firebase upload we need _img_url and _answers from our api
  double _percentage =
      (int.parse(_got_marks).toDouble() / int.parse(_out_of).toDouble()) *
          100.0;
  var result = await FirebaseFirestore.instance
      .collection(_uid.toString())
      .doc(_testDocID)
      .collection('students')
      .doc(_student_idx)
      //.collection(_student_idx)
      .set({
    'student_idx': _student_idx,
    'got_marks': int.parse(_got_marks),
    'out_of': int.parse(_out_of),
    'file_id': _img_url,
    'answers': _answers,
    'percentage': _percentage
  });
  //return result.id;
}

Future uploadMarkScheme(scheme_list, uid, test_id) async {
  var res = await FirebaseFirestore.instance
      .collection(uid)
      .doc(test_id)
      .update({"scheme": scheme_list});
}

provideMarkScheme(uid, docid) async {
  var mark_scheme =
      await FirebaseFirestore.instance.collection(uid).doc(docid).get();
  return mark_scheme['scheme'];
}
