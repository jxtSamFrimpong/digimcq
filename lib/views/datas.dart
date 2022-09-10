import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
//import '../../providerclasses/providerclasses.dart' as prov;
import 'package:cloud_firestore/cloud_firestore.dart';

generateCSV(uid, test_doc_id, c_code) async {
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
