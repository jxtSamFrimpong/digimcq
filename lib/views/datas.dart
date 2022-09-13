import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../providerclasses/providerclasses.dart' as prov;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../utils/filemanager.dart';

Future<List> generateStudentsData(uid, test_doc_id) async {
  var snapshot_lists = <Map>[];
  try {
    var collection = FirebaseFirestore.instance
        .collection(uid)
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
  return snapshot_lists;
}

studentsDataFunc(uid, test) async {
  return await generateStudentsData(uid, test);
}

class DataS extends StatelessWidget {
  const DataS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _cred = Provider.of<prov.User>(context).getUserCredentials;
    var _testDocID = Provider.of<prov.User>(context).getTestDocID;
    var _testName = Provider.of<prov.User>(context).getTestName;
    var _testClass = Provider.of<prov.User>(context).getClass;
    var _testCode = Provider.of<prov.User>(context).getCode;

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
                      var snapshot_lists = <Map>[];
                      try {
                        var collection = FirebaseFirestore.instance
                            .collection(_cred.uid)
                            .doc(_testDocID)
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
                      } catch (e) {
                        print('error generate students id');
                        print(e);
                      }

                      showMaterialModalBottomSheet(
                        context: context,
                        builder: (context) => SingleChildScrollView(
                          controller: ModalScrollController.of(context),
                          child: Container(
                            child: _insideBottomSheet(_testDocID, _testName,
                                _testCode, _testClass, snapshot_lists),
                          ),
                        ),
                      );
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
  FileManager fileManager = FileManager(file_name);
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
              fileManager.saveDataToTXT(snapshot_lists);
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
              fileManager.saveDataToCSV(snapshot_lists);
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
              fileManager.saveDataToJSON(snapshot_lists);
              fileManager.shareJSONFile(file_name);
            },
          )
        ],
      ),
    ),
  );
}
