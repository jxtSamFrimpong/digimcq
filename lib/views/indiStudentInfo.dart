import 'package:flutter/material.dart';
import '../../providerclasses/providerclasses.dart' as prov;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class IndividualStudentInfo extends StatelessWidget {
  const IndividualStudentInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _cred = Provider.of<prov.User>(context).getUserCredentials;
    var _testDocID = Provider.of<prov.User>(context).getTestDocID;
    var _studentDocID = Provider.of<prov.User>(context).getStudentDocID;

    final Stream<DocumentSnapshot> _testsStream = FirebaseFirestore.instance
        .collection(_cred.uid.toString())
        .doc(_testDocID)
        .collection('students')
        .doc(_studentDocID)
        .snapshots();

    return SafeArea(
        child: Scaffold(
      body: StreamBuilder(
        stream: _testsStream,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          // print(snapshot.data!);
          // var individualStudentDoc = snapshot.data!;
          return Text(snapshot.data!['student_idx']);
        },
      ),
    ));

    // SafeArea(

    //   child: Scaffold(
    //     body: SingleChildScrollView(
    //       child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    //         Center(child: Text('Student ID')),
    //         Container(
    //           height: 200,
    //           width: 200,
    //           child: Text('image place holder'),
    //           color: Colors.redAccent,
    //         ),
    //         Text('grade'),
    //       ]),
    //     ),
    //   ),
    // );
  }
}
