import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import '../../dummyData/testCreated.dart' as dummies;

class listOfCreatedTests extends StatelessWidget {
  final Stream<QuerySnapshot> _testsStream =
      FirebaseFirestore.instance.collection('tests').snapshots();

  listOfCreatedTests({Key? key}) : super(key: key);

  List dummyTests = dummies.Tests;
  List dummyClasses = dummies.classes;

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   color: Colors.white,
    //   padding: EdgeInsets.all(8.0),
    //   margin: EdgeInsetsDirectional.all(12.0),
    //   //height: MediaQuery.of(context).size.height * 0.8,
    //   child: ListView.builder(
    //     //physics: ScrollPhysics(),
    //     shrinkWrap: true,
    //     itemCount: dummyTests.length,
    //     itemBuilder: (BuildContext ctx, int idx) {
    //       return TestWidget(dummyTests[idx]['code'], dummyTests[idx]['name'],
    //           dummyTests[idx]['id'], dummyTests[idx]['classes']);
    //     },
    //   ),
    // );

    return StreamBuilder<QuerySnapshot>(
      stream: _testsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return ListView(
          shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return TestWidget(
                data['course_code'], data['name'], data['class_']);
            // return ListTile(
            //   title: Text(data['name']),
            //   subtitle: Text(data['description']),
            //   trailing: Text(data['class_']),
            // );
          }).toList(),
        );
      },
    );
  }
}

class TestWidget extends ListTile {
  //TODO: better fields along
  String _coursename;
  String _coursecode;
  //String _testId;
  String _class;
  //num _id = 0;

  TestWidget(this._coursecode, this._coursename, this._class);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, 'test_info');
      },
      title: Text(this._coursename),
      subtitle: Text(this._coursecode),
      trailing: Text(this._class), //TODO: string parse
    );
  }
}

class TestAccordion extends StatelessWidget {
  String _coursename;
  String _coursecode;
  //String _testId;
  String _class;

  TestAccordion(this._coursecode, this._coursename, this._class);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: TestWidget(this._coursecode, this._coursename, this._class),
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (BuildContext ctx, int idx) {
              return GestureDetector(
                onTap: () {},
                child: Text('Class $idx'),
              );
            })
      ],
      trailing: SizedBox(
        child: Text('${this._class}'),
      ),
    );
  }
}
