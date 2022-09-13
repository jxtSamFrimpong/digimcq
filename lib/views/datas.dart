import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../providerclasses/providerclasses.dart' as prov;
import 'package:cloud_firestore/cloud_firestore.dart';

generateCSV(uid, test_doc_id) async {
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
      Map<String, dynamic> _vals = {
        'answers': data['answers'],
        'file_id': data['file_id'],
        'score': data['got_marks'],
        'out_of': data['out_of'],
        'percentage': data['percentage'],
        'student_idx': data['student_idx']
      };
      myList.add(_vals);
    }
    //print(myList.length);

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
    print(e);
  }
}

class DataS extends StatelessWidget {
  const DataS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _cred = Provider.of<prov.User>(context).getUserCredentials;
    var _testDocID = Provider.of<prov.User>(context).getTestDocID;
    var _testName = Provider.of<prov.User>(context).getTestName;

    print('datassss');
    generateCSV(_cred.uid, _testDocID);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Download Data'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                    onPressed: () {},
                  ),
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
                    onPressed: () {},
                  ),
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
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
