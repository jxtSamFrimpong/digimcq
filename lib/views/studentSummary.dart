import 'package:flutter/material.dart';
//import 'dart:math';
import 'package:provider/provider.dart';
import '../../providerclasses/providerclasses.dart' as prov;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class StudentsSummary extends StatelessWidget {
  //StudentsSummary({Key? key}) : super(key: key);

  // List<Map> _products = List.generate(30, (i) {
  //   return {"id": i, "name": "Product $i", "price": Random().nextInt(200) + 1};
  // });

  // int _currentSortColumn = 0;
  // bool _isAscending = true;

  @override
  Widget build(BuildContext context) {
    var _cred = Provider.of<prov.User>(context).getUserCredentials;
    var _testDocID = Provider.of<prov.User>(context).getTestDocID;
    var _student_idx = Provider.of<prov.User>(context).getStudentDocID;

    final Stream<QuerySnapshot> _testsStream = FirebaseFirestore.instance
        .collection(_cred!.uid)
        .doc(_testDocID)
        .collection('students')
        .snapshots();

    return StreamBuilder(
        stream: _testsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.newtonCradle(
                color: Color.fromRGBO(29, 53, 87, 1.0),
                size: 200,
              ),
            );
          }
          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data['student_idx'].toString()),
                subtitle: Text(data['got_marks'].toString()),
                trailing: Text(data['percentage'].toString()),
                onTap: () {
                  provideStudentDocID(context, data['student_idx']);
                  print(_student_idx);
                  Navigator.pushNamed(context, 'individual');
                },
              );
            }).toList(),
          );
        });

    // ListView.separated(
    //     separatorBuilder: (context, index) => Divider(),
    //     itemCount: 20,
    //     itemBuilder: ((context, index) {
    //       return ListTile(
    //         title: Text('Student $index'),
    //         onTap: () {
    //           Navigator.pushNamed(context, 'individual');
    //         },
    //       );
    //     }));
  }
}

void provideStudentDocID(BuildContext context, id) {
  Provider.of<prov.User>(context, listen: false).setStudentDocId(id);
}

// class StudentTiles extends Widget {
//   var _uid;
//   var _doc_id;
//   var _student_id;

//   return Container();

// }

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
