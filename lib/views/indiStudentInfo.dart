import 'package:flutter/material.dart';
import '../../providerclasses/providerclasses.dart' as prov;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../utils/authservice.dart';

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
    var _cred = Provider.of<prov.User>(context).getUserCredentials;
    var _testDocID = Provider.of<prov.User>(context).getTestDocID;
    var _studentDocID = Provider.of<prov.User>(context).getStudentDocID;
    //var appName = Provider.of<prov.User>(context).getUserCredentials;

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
          padding: const EdgeInsets.all(10.0),
          child: AppBar(
            toolbarHeight: 50.0,
            backgroundColor: Colors.white,
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
            actions: [],
          ),
        ),
      ),
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
