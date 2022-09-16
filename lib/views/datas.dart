import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../providerclasses/providerclasses.dart' as prov;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../utils/filemanager.dart';

generateStudentsData(uid, test_doc_id) async {
  var snapshot_lists = <Map>[];
  try {
    var collection = FirebaseFirestore.instance
        .collection(uid.toString())
        .doc(test_doc_id)
        .collection('students');
    var querySnapshot = await collection.get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      //var fooValue = data['foo']; // <-- Retrieving the value.
      var sudo = double.parse(data['student_idx']);
      var sudoman;

      try {
        if (sudo > 70.0) {
          sudoman = 'A';
        } else if (sudo >= 60.0 && sudo < 70.0) {
          sudoman = 'B';
        } else if (sudo >= 50.0 && sudo < 60.0) {
          sudoman = 'C';
        } else if (sudo >= 40.0 && sudo < 50.0) {
          sudoman = 'D';
        } else if (sudo >= 0.0 && sudo < 40.0) {
          sudoman = 'F';
        }
      } catch (e) {
        print('double check fail');
        print(e);
      }

      Map<String, dynamic> _vals = {
        'answers': data['answers'],
        'file_id': data['file_id'],
        'score': data['got_marks'],
        'out_of': data['out_of'],
        'percentage': data['percentage'],
        'student_idx': data['student_idx'],
        'grade': sudoman
      };
      snapshot_lists.add(_vals);
    }
    //print(myList[0]["grade"]);
    //return myList;

    // var collection = FirebaseFirestore.instance
    //     .collection(uid)
    //     .doc(test_doc_id)
    //     .collection('students');
    // collection.snapshots().listen((querySnapshot) {
    //   for (var doc in querySnapshot.docs) {
    //     Map<String, dynamic> data = doc.data();
    //     var fooValue = data['foo']; // <-- Retrieving the value.
    //   }
    // });

    // var docs = await FirebaseFirestore.instance
    //     .collection(uid)
    //     .doc(test_doc_id)
    //     .collection('students')
    //     .snapshots()
    //     .toList();
    // print(docs);
  } catch (e) {
    print('error generate students id');
    print(e);
  }
  //print(snapshot_lists);
  return snapshot_lists;
}

studentsDataFunc(uid, test) async {
  return await generateStudentsData(uid, test);
}

class DataS extends StatelessWidget {
  //const DataS({Key? key}) : super(key: key);

  //var snapshot_lists;

  //FileManager fileManager = FileManager();
  //var fileManager;

  @override
  Widget build(BuildContext context) {
    //final _cred = Provider.of<prov.User>(context).getUserCredentials;
    //var _testDocID = Provider.of<prov.User>(context).getTestDocID;

    // @override
    // void initState() {
    //   // TODO: implement initState
    //   var uid = Provider.of<prov.User>(context).getUserCredentials.uid;
    //   setState(() async {
    //     snapshot_lists = await generateStudentsData(uid, _testDocID);
    //     print('fetched snaps');
    //   });
    //   super.initState();
    // }

    //var _testName = Provider.of<prov.User>(context).getTestName;
    //var _testClass = Provider.of<prov.User>(context).getClass;
    //var _testCode = Provider.of<prov.User>(context).getCode;
    //var file_name =
    //  _testName + '_' + _testClass + '_' + _testCode + '_' + _testDocID;

    print('datassss');
    //var snapshot_lists = studentsDataFunc(_cred.uid, _testDocID);
    //print(snapshot_lists[0]);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  color: Color.fromRGBO(69, 123, 157, 1.0),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: MaterialButton(
                    onPressed: () async {
                      var _cred;
                      var _uid;
                      var _testDocID;
                      var _testName;
                      var _testClass;
                      var _testCode;
                      var file_name;
                      var snapshot_lists;
                      try {
                        _cred = Provider.of<prov.User>(context, listen: false)
                            .getUserCredentials;
                        print(_cred);

                        try {
                          _uid = _cred.uid;
                          print(_uid);
                        } catch (err) {
                          print('cred.uid err  ');
                          print(err);
                        }
                        try {
                          _testDocID =
                              Provider.of<prov.User>(context, listen: false)
                                  .getTestDocID;
                          print(_testDocID);
                        } catch (err) {
                          print('testdoc id err  ');
                          print(err);
                        }

                        try {
                          _testName =
                              Provider.of<prov.User>(context, listen: false)
                                  .getTestName;
                          print(_testName);
                        } catch (err) {
                          print('test name err');
                          print(err);
                        }
                        try {
                          _testClass =
                              Provider.of<prov.User>(context, listen: false)
                                  .getClass;
                          print(_testClass);
                        } catch (err) {
                          print('test class err');
                          print(err);
                        }
                        try {
                          _testCode =
                              Provider.of<prov.User>(context, listen: false)
                                  .getCode;
                          print(_testCode);
                        } catch (err) {
                          print('test code err');
                          print(err);
                        }
                        try {
                          file_name = _testName.toString() +
                              '_' +
                              _testClass.toString() +
                              '_' +
                              _testCode.toString() +
                              '_' +
                              _testDocID.toString();
                          print('filename: ' + file_name);
                        } catch (err) {
                          print('constructing filename err');
                          print(err);
                        }
                      } catch (e) {
                        print(' error fetching cred');
                        print(e);
                      }

                      try {
                        snapshot_lists =
                            await generateStudentsData(_uid, _testDocID);
                      } catch (err) {
                        print('trying fetching snaps err');
                        print(err);
                      }

                      FileManager fileManager = FileManager();

                      showMaterialModalBottomSheet(
                          context: context,
                          builder: (context) => SingleChildScrollView(
                                controller: ModalScrollController.of(context),
                                child: Container(
                                  color: Color.fromRGBO(168, 218, 220, 1.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          //txt
                                          MaterialButton(
                                            child: Column(
                                              children: [
                                                // Padding(
                                                //   padding: const EdgeInsets.all(8.0),
                                                //   child: Text('txt'),
                                                // ),
                                                Image.asset(
                                                    'assets/datas/icons8-txt-50.png')
                                              ],
                                            ),
                                            onPressed: () {
                                              print(
                                                  'filename in txt: $file_name');
                                              print(snapshot_lists);
                                              fileManager.saveDataToTXT(
                                                  snapshot_lists, file_name);
                                              fileManager
                                                  .shareTxtFile(file_name);
                                            },
                                          ),
                                          //csv
                                          MaterialButton(
                                            child: Column(
                                              children: [
                                                // Padding(
                                                //   padding: const EdgeInsets.all(8.0),
                                                //   child: Text('csv'),
                                                // ),
                                                Image.asset(
                                                    'assets/datas/icons8-csv-50.png')
                                              ],
                                            ),
                                            onPressed: () {
                                              print(
                                                  'filename in csv: $file_name');
                                              print(snapshot_lists);
                                              fileManager.saveDataToCSV(
                                                  snapshot_lists, file_name);
                                              fileManager
                                                  .shareCSVFile(file_name);
                                            },
                                          ),
                                          //json
                                          MaterialButton(
                                            child: Column(
                                              children: [
                                                // Padding(
                                                //   padding: const EdgeInsets.all(8.0),
                                                //   child: Text('json'),
                                                // ),
                                                Image.asset(
                                                    'assets/datas/icons8-json-50.png')
                                              ],
                                            ),
                                            onPressed: () {
                                              //print(snapshot_lists);
                                              fileManager.saveDataToJSON(
                                                  file_name, snapshot_lists);
                                              fileManager
                                                  .shareJSONFile(file_name);
                                            },
                                          ),
                                        ]),
                                  ),
                                ),
                              ));
                    },
                    child: Text(
                      'Share Data With Yourself',
                      style: TextStyle(
                        fontFamily: 'Orbitron',
                        color: Color.fromRGBO(241, 250, 238, 1.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

_insideBottomSheet(testdocid, testname, code, _class, snapshot_lists) {
  var file_name = testname + '_' + _class + '_' + code + '_' + testdocid;
  FileManager fileManager = FileManager();
  return Container(
    color: Color.fromRGBO(168, 218, 220, 1.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //txt
          MaterialButton(
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text('txt'),
                // ),
                Image.asset('assets/datas/icons8-txt-50.png')
              ],
            ),
            onPressed: () {
              fileManager.saveDataToTXT(file_name, snapshot_lists);
              fileManager.shareTxtFile(file_name);
            },
          ),
          //csv
          MaterialButton(
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text('csv'),
                // ),
                Image.asset('assets/datas/icons8-csv-50.png')
              ],
            ),
            onPressed: () {
              fileManager.saveDataToCSV(file_name, snapshot_lists);
              fileManager.shareCSVFile(file_name);
            },
          ),
          //json
          MaterialButton(
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text('json'),
                // ),
                Image.asset('assets/datas/icons8-json-50.png')
              ],
            ),
            onPressed: () {
              fileManager.saveDataToJSON(file_name, snapshot_lists);
              fileManager.shareJSONFile(file_name);
            },
          )
        ],
      ),
    ),
  );
}

// var snapshot_lists = <Map>[];
//                       // try {
//                       var collection = await FirebaseFirestore.instance
//                           .collection(_cred.uid)
//                           .doc(_testDocID)
//                           .collection('students');
//                       //print(collection);
//                       var querySnapshot = await collection.get();
//                       for (var doc in querySnapshot.docs) {
//                         Map<String, dynamic> data = doc.data();
//                         var sudo = double.parse(data['student_idx']);
//                         var sudoman;

//                         try {
//                           if (sudo > 70.0) {
//                             sudoman = 'A';
//                           } else if (sudo >= 60.0 && sudo < 70.0) {
//                             sudoman = 'B';
//                           } else if (sudo >= 50.0 && sudo < 60.0) {
//                             sudoman = 'C';
//                           } else if (sudo >= 40.0 && sudo < 50.0) {
//                             sudoman = 'D';
//                           } else if (sudo >= 0.0 && sudo < 40.0) {
//                             sudoman = 'F';
//                           }
//                         } catch (e) {
//                           print('double check fail');
//                           print(e);
//                         }

//                         Map<String, dynamic> _vals = {
//                           'answers': data['answers'],
//                           'file_id': data['file_id'],
//                           'score': data['got_marks'],
//                           'out_of': data['out_of'],
//                           'percentage': data['percentage'],
//                           'student_idx': data['student_idx'],
//                           'grade': sudoman
//                         };
//                         snapshot_lists.add(_vals);
//                       }
//                       //print(snapshot_lists);
//                       print('up to this point works');
//                       // } catch (e) {
//                       //   print('error generate students id');
//                       //   print(e);
//                       // }

// showMaterialModalBottomSheet(
//   context: context,
//   builder: (context) => SingleChildScrollView(
//     controller: ModalScrollController.of(context),
//     child: Container(
//       child: _insideBottomSheet(_testDocID, _testName,
//           _testCode, _testClass, snapshot_lists),
//     ),
//   ),
// );

//Container(
//     color: Color.fromRGBO(168, 218, 220, 1.0),
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           //txt
//           MaterialButton(
//             child: Column(
//               children: [
//                 // Padding(
//                 //   padding: const EdgeInsets.all(8.0),
//                 //   child: Text('txt'),
//                 // ),
//                 Image.asset(
//                     'assets/datas/icons8-txt-50.png')
//               ],
//             ),
//             onPressed: () {
//               fileManager.saveDataToTXT(
//                   file_name, snapshot_lists);
//               fileManager.shareTxtFile(file_name);
//             },
//           ),
//           //csv
//           MaterialButton(
//             child: Column(
//               children: [
//                 // Padding(
//                 //   padding: const EdgeInsets.all(8.0),
//                 //   child: Text('csv'),
//                 // ),
//                 Image.asset(
//                     'assets/datas/icons8-csv-50.png')
//               ],
//             ),
//             onPressed: () {
//               fileManager.saveDataToCSV(
//                   file_name, snapshot_lists);
//               fileManager.shareCSVFile(file_name);
//             },
//           ),
//           //json
//           MaterialButton(
//             child: Column(
//               children: [
//                 // Padding(
//                 //   padding: const EdgeInsets.all(8.0),
//                 //   child: Text('json'),
//                 // ),
//                 Image.asset(
//                     'assets/datas/icons8-json-50.png')
//               ],
//             ),
//             onPressed: () {
//               fileManager.saveDataToJSON(
//                   file_name, snapshot_lists);
//               fileManager.shareJSONFile(file_name);
//             },
//           )
//         ],
//       ),
//     ),
//   )
