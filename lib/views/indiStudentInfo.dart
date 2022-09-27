import 'package:flutter/material.dart';
import 'dart:convert';
import '../../providerclasses/providerclasses.dart' as prov;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../utils/authservice.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:dio/dio.dart';
import '../utils/config.dart';
import 'package:http/http.dart' as http;

class IndividualStudentInfo extends StatelessWidget {
  const IndividualStudentInfo({Key? key}) : super(key: key);

  ImageProvider provProfPic(inp) {
    ImageProvider prof = inp;
    if (prof != null) {
      return prof;
    } else {
      return AssetImage('assets/drawer/user.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    var _ChosenStudent = Provider.of<prov.User>(context).getChosenStudent;
    var _cred = Provider.of<prov.User>(context).getUserCredentials;
    var _testDocID = Provider.of<prov.User>(context).getTestDocID;
    var _studentDocID = Provider.of<prov.User>(context).getStudentDocID;
    var _storageImageFilePath =
        Provider.of<prov.User>(context).getStorageImageFilePath;

    final Stream<DocumentSnapshot> _testsStream = FirebaseFirestore.instance
        .collection(_cred.uid.toString())
        .doc(_testDocID)
        .collection('students')
        .doc(_studentDocID)
        .snapshots();

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: AppBar(
              centerTitle: true,
              iconTheme: IconThemeData(
                color: Color.fromRGBO(241, 250, 238, 1.0),
              ),
              shadowColor: Color.fromRGBO(69, 123, 157, 1.0),
              toolbarHeight: 50.0,
              backgroundColor: Color.fromRGBO(29, 53, 87, 1.0),
              elevation: 0.0,
              // leading: IconButton(
              //   icon: Icon(
              //     Icons.menu,
              //     color: Colors.black,
              //   ),
              //   onPressed: () {},
              // ),
              title: Text(
                "MCQ GRADER",
                style: TextStyle(
                  fontFamily: 'Rampart_One',
                  color: Color.fromRGBO(241, 250, 238, 1.0),
                ),
              ),
              actions: [
                // IconButton(
                //   onPressed: () {},
                //   icon: Icon(
                //     Icons.search,
                //     //color: Color.fromRGBO(241, 250, 238, 1.0),
                //   ),
                // )
              ],
            ),
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: Color.fromRGBO(241, 250, 238, 1.0),
            child: Column(
              // Important: Remove any padding from the ListView.
              //padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  onDetailsPressed: () {
                    Navigator.pushNamed(context, 'profile');
                  },
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(29, 53, 87, 1.0),
                    //color: Color.fromRGBO(69, 123, 157, 1.0),
                  ),
                  accountName: Text(
                    _cred.displayName.toString(),
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Rampart_One',
                      color: Color.fromRGBO(241, 250, 238, 1.0),
                    ),
                  ),
                  accountEmail: Text(
                    _cred.email,
                    style: TextStyle(
                      //fontSize: 25,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Rampart_One',
                      color: Color.fromRGBO(241, 250, 238, 1.0),
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Color.fromRGBO(241, 250, 238, 1.0),
                    backgroundImage:
                        provProfPic(NetworkImage(_cred.photoURL.toString())),
                    onBackgroundImageError: (exception, stackTrace) {},

                    // FadeInImage(
                    //   placeholder: AssetImage('assets/user.png'),
                    //   image: NetworkImage(
                    //     _cred.photoURL.toString(),
                    //   ),
                    // ),
                    // foregroundImage:
                    //     provProfPic(AssetImage('assets/drawer/user.png')),
                    //child: ,
                    //),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Color.fromRGBO(69, 123, 157, 1.0),
                  ),
                  title: Text(
                    "Home",
                    style: TextStyle(
                      //fontSize: 25,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Orbitron',
                      color: Color.fromRGBO(69, 123, 157, 1.0),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'createtest');
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.info,
                    color: Color.fromRGBO(69, 123, 157, 1.0),
                  ),
                  title: Text(
                    "About App",
                    style: TextStyle(
                      //fontSize: 25,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Orbitron',
                      color: Color.fromRGBO(69, 123, 157, 1.0),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'about');
                  },
                ),
                Expanded(
                  child: Container(),
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Color.fromRGBO(69, 123, 157, 1.0),
                  ),
                  title: Text(
                    "Log Out",
                    style: TextStyle(
                      //fontSize: 25,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Orbitron',
                      color: Color.fromRGBO(69, 123, 157, 1.0),
                    ),
                  ),
                  onTap: () {
                    //signOutprov(context);
                    AuthService().signOut();

                    Navigator.pushReplacementNamed(context, 'handleauthstate');
                  },
                ),
              ],
            ),
          ),
        ),
        body: indiStudentInfo(_ChosenStudent, context, _storageImageFilePath,
            _studentDocID, _cred.uid, _testDocID),
      ),
    );
  }
}

// filePath(file_id) async {
//   //must return filepath url
//   var i =
//       'https://api.telegram.org/bot' + token + '/getFile?file_id=' + file_id;

//   try {
//     var url = Uri.parse(i);
//     var response = await http.get(url);
//     if (response.statusCode == 200) {
//       var _model = pathFileFromJson(response.body);
//       return _model;
//     }
//   } catch (e) {
//     print(e.toString());
//   }
//   // var file_path =
//   //     'https://api.telegram.org/file/bot' + token + '/' + pathFile.toString();
//   // //print(file_path);
//   // return file_path.toString();
// }

//https://api.telegram.org/file/bot<token>/<file_path>
//BQACAgQAAxkDAAOPYx1EFtP31ogqcmCHyVcs0qIqQ8UAAlQSAAKLduhQm4nkiMbW8-opBA
//https://api.telegram.org/bot<token>/getFile?file_id=<file_id>
indiStudentInfo(data, context, file_path, studentID, uid, testID) {
  return Container(
    color: Color.fromRGBO(241, 250, 238, 1.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Container(
            child: Text(
              data['student_idx'],
              style: TextStyle(
                //fontFamily: 'Orbitron'
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
                color: Color.fromRGBO(29, 53, 87, 1.0),
              ),
            ),
          )),
        ),
        Container(
            child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Score: ${data["got_marks"]}',
                style: TextStyle(
                  //fontFamily: 'Orbitron',
                  color: Color.fromRGBO(29, 53, 87, 1.0),
                ),
              ),
              Text(
                '${data["percentage"].toStringAsFixed(2)}%',
                style: TextStyle(
                  //fontFamily: 'Orbitron',
                  color: Color.fromRGBO(29, 53, 87, 1.0),
                ),
              ),
              Text(
                'Out of: ${data["out_of"]}',
                style: TextStyle(
                  //fontFamily: 'Orbitron',
                  color: Color.fromRGBO(29, 53, 87, 1.0),
                ),
              )
            ],
          ),
        )),
        SizedBox(
          height: 50.0,
        ),
        Container(
          child: Expanded(
              child: Image.network(
            file_path,
            fit: BoxFit.fill,
          )),
        ),
        SizedBox(
          height: 30.0,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              color: Color.fromRGBO(69, 123, 157, 1.0),
              width: MediaQuery.of(context).size.width * 0.8,
              child: MaterialButton(
                onPressed: () {
                  //var deleted = false;
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Color.fromRGBO(241, 250, 238, 1.0),
                          title: Text(
                            'Delete Student ${studentID} ?',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Orbitron',
                              color: Color.fromRGBO(29, 53, 87, 1.0),
                            ),
                          ),
                          content: Text(
                            'You won\'t be able to undo this action',
                            style: TextStyle(
                              //fontFamily: 'Orbitron',
                              color: Color.fromRGBO(69, 123, 157, 1.0),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: const Text(
                                'No',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Color.fromRGBO(230, 57, 70, 1.0),
                                ),
                              ),
                              onPressed: () async {
                                var res =
                                    await deleteStudent(uid, testID, studentID);
                                if (res == 'success') {
                                  print('test successfuly deleted');
                                }
                                //deleted = true;
                                Navigator.of(context).pop(true);
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Yes',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        );
                      });
                  // if (deleted) {
                  //   Navigator.pop(context);
                  // }
                },
                child: Text(
                  'Delete Student',
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    color: Color.fromRGBO(241, 250, 238, 1.0),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

// To parse this JSON data, do
//
//     final pathFile = pathFileFromJson(jsonString);

PathFile pathFileFromJson(String str) => PathFile.fromJson(json.decode(str));

String pathFileToJson(PathFile data) => json.encode(data.toJson());

class PathFile {
  PathFile({
    required this.ok,
    required this.result,
  });

  bool ok;
  Result result;

  factory PathFile.fromJson(Map<String, dynamic> json) => PathFile(
        ok: json["ok"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "result": result.toJson(),
      };
}

class Result {
  Result({
    required this.fileId,
    required this.fileUniqueId,
    required this.fileSize,
    required this.filePath,
  });

  String fileId;
  String fileUniqueId;
  int fileSize;
  String filePath;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        fileId: json["file_id"],
        fileUniqueId: json["file_unique_id"],
        fileSize: json["file_size"],
        filePath: json["file_path"],
      );

  Map<String, dynamic> toJson() => {
        "file_id": fileId,
        "file_unique_id": fileUniqueId,
        "file_size": fileSize,
        "file_path": filePath,
      };
}

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
