import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'dart:math';
import 'package:provider/provider.dart';
import '../../providerclasses/providerclasses.dart' as prov;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../utils/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';

class StudentsSummary extends StatelessWidget {
  //StudentsSummary({Key? key}) : super(key: key);

  // List<Map> _products = List.generate(30, (i) {
  //   return {"id": i, "name": "Product $i", "price": Random().nextInt(200) + 1};
  // });

  // int _currentSortColumn = 0;
  // bool _isAscending = true;

  @override
  Widget build(BuildContext context) {
    var _cred = Provider.of<prov.User>(context).getUserCredentials;
    var _testDocID = Provider.of<prov.User>(context).getTestDocID;
    var _student_idx = Provider.of<prov.User>(context).getStudentDocID;

    final Stream<QuerySnapshot> _testsStream = FirebaseFirestore.instance
        .collection(_cred!.uid)
        .doc(_testDocID)
        .collection('students')
        .snapshots();

    return StreamBuilder(
        stream: _testsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.newtonCradle(
                color: Color.fromRGBO(29, 53, 87, 1.0),
                size: 200,
              ),
            );
          }
          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(
                  data['student_idx'].toString(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Orbitron',
                    color: Color.fromRGBO(69, 123, 157, 1.0),
                  ),
                ),
                subtitle: Text(
                  'Score: ' + data['got_marks'].toString(),
                  style: TextStyle(
                    fontSize: 10,
                    //fontWeight: FontWeight.w900,
                    fontFamily: 'Orbitron',
                    color: Color.fromRGBO(69, 123, 157, 1.0),
                  ),
                ),
                trailing: Text(data['percentage'].toStringAsFixed(2) + '%',
                    style: TextStyle(
                      //fontSize: 17,
                      //fontWeight: FontWeight.w900,
                      //fontFamily: 'Orbitron',
                      color: Color.fromRGBO(69, 123, 157, 1.0),
                    )),
                onTap: () async {
                  provideStudentDocID(context, data['student_idx']);
                  print(_student_idx);
                  provideChosenStudent(context, data);
                  var file_path = await filePath(data['file_id']);
                  if (kDebugMode) {
                    print('inside student summary');
                    print(file_path);
                  }
                  var final_path = 'https://api.telegram.org/file/bot' +
                      token +
                      '/' +
                      file_path;
                  if (kDebugMode) {
                    print('final path');
                    print(final_path);
                  }
                  provideStorageImageFilePath(context, final_path);

                  Navigator.pushNamed(context, 'individual');
                },
              );
            }).toList(),
          );
        });
  }
}

void provideStudentDocID(BuildContext context, id) {
  Provider.of<prov.User>(context, listen: false).setStudentDocId(id);
}

void provideChosenStudent(BuildContext context, data) {
  Provider.of<prov.User>(context, listen: false).setChosenStudent(data);
}

void provideStorageImageFilePath(BuildContext context, data) {
  Provider.of<prov.User>(context, listen: false).setStorageImageFilePath(data);
}

// class StudentTiles extends Widget {
//   var _uid;
//   var _doc_id;
//   var _student_id;

//   return Container();

// }

deleteStudent(uid, doc_id, stdid) async {
  try {
    await FirebaseFirestore.instance
        .collection(uid)
        .doc(doc_id)
        .collection('students')
        .doc(stdid)
        .delete();
    return 'success';
  } catch (e) {
    print(e);
    return 'error';
  }
}

filePath(file_id) async {
  //must return filepath url
  var i =
      'https://api.telegram.org/bot' + token + '/getFile?file_id=' + file_id;

  Response response;
  var dio = Dio();
  response = await dio.get(i);
  //print(response.data.toString());
  return response.data['result']['file_path'];
}

// To parse this JSON data, do
//
//     final pathFile = pathFileFromJson(jsonString);

// PathFile pathFileFromJson(String str) => PathFile.fromJson(json.decode(str));

// String pathFileToJson(PathFile data) => json.encode(data.toJson());

// class PathFile {
//   PathFile({
//     required this.ok,
//     required this.result,
//   });

//   bool ok;
//   Result result;

//   factory PathFile.fromJson(Map<String, dynamic> json) => PathFile(
//         ok: json["ok"],
//         result: Result.fromJson(json["result"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "ok": ok,
//         "result": result.toJson(),
//       };
// }

// class Result {
//   Result({
//     required this.fileId,
//     required this.fileUniqueId,
//     required this.fileSize,
//     required this.filePath,
//   });

//   String fileId;
//   String fileUniqueId;
//   int fileSize;
//   String filePath;

//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//         fileId: json["file_id"],
//         fileUniqueId: json["file_unique_id"],
//         fileSize: json["file_size"],
//         filePath: json["file_path"],
//       );

//   Map<String, dynamic> toJson() => {
//         "file_id": fileId,
//         "file_unique_id": fileUniqueId,
//         "file_size": fileSize,
//         "file_path": filePath,
//       };
// }
