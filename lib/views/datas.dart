import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../providerclasses/providerclasses.dart' as prov;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../utils/filemanager.dart';

Future<List> generateStudentsData(uid, test_doc_id) async {
  var myList = <Map>[];
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
      myList.add(_vals);
    }
    //print(myList[0]["grade"]);
    return myList;

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
  return myList;
}

class DataS extends StatefulWidget {
  const DataS({Key? key}) : super(key: key);

  @override
  State<DataS> createState() => _DataSState();
}

class _DataSState extends State<DataS> {
  @override
  Widget build(BuildContext context) {
    var _cred = Provider.of<prov.User>(context).getUserCredentials;
    var _testDocID = Provider.of<prov.User>(context).getTestDocID;
    var _testName = Provider.of<prov.User>(context).getTestName;
    var _testClass = Provider.of<prov.User>(context).getClass;
    var _testCode = Provider.of<prov.User>(context).getCode;

    print('datassss');

    List snapshot_lists;
    //print(snapshot_lists);

    @override
    void initState() async {
      super.initState();
      snapshot_lists = await generateStudentsData(_cred.uid, _testDocID);
    }

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
                    onPressed: () {
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

_insideBottomSheet(String testdocid, String testname, String code,
    String _class, List snapshot_lists) {
  String file_name = testname + '_' + _class + '_' + code + '_' + testdocid;
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
