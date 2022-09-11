import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../providerclasses/providerclasses.dart' as prov;
import 'package:cloud_firestore/cloud_firestore.dart';

generateCSV(uid, test_doc_id) async {
  try {
    var docs = await FirebaseFirestore.instance
        .collection(uid)
        .doc(test_doc_id)
        .collection('students')
        .snapshots();
    print(docs.first);
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

    print('datassss');
    generateCSV(_cred.uid, _testDocID);
    return Container();
  }
}
