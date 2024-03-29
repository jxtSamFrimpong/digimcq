import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
//import '../../dummyData/testCreated.dart' as dummies;
import 'package:provider/provider.dart';
import '../../providerclasses/providerclasses.dart' as prov;
import 'package:loading_animation_widget/loading_animation_widget.dart';

class listOfCreatedTests extends StatelessWidget {
  listOfCreatedTests();

  // List dummyTests = dummies.Tests;
  // List dummyClasses = dummies.classes;

  @override
  Widget build(BuildContext context) {
    var _cred = Provider.of<prov.User>(context).getUserCredentials;
    //var _testDocID = Provider.of<prov.User>(context).getTestDocID;
    final Stream<QuerySnapshot> _testsStream =
        FirebaseFirestore.instance.collection(_cred.uid.toString()).snapshots();
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
            return TestWidget(_cred!.uid, document.id, data['course_code'],
                data['name'], data['class_'], data['endNumber']);
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

void provideTestDocID(BuildContext context, id) {
  Provider.of<prov.User>(context, listen: false).setTestDocID(id);
}

void provideEndNumber(BuildContext context, number) {
  Provider.of<prov.User>(context, listen: false).setEndNumber(number);
}

void provideTestName(BuildContext context, name) {
  Provider.of<prov.User>(context, listen: false).setTestName(name);
}

void provideTestCode(BuildContext context, code) {
  Provider.of<prov.User>(context, listen: false).setCode(code);
}

void provideClass(BuildContext context, name) {
  Provider.of<prov.User>(context, listen: false).setClass(name);
}

deleteTest(uid, docid) async {
  try {
    await FirebaseFirestore.instance.collection(uid).doc(docid).delete();
    return 'success';
  } catch (e) {
    print(e);
    return 'error';
  }
}

class TestWidget extends ListTile {
  //TODO: better fields along
  String uid;
  String doc_id;
  String _coursename;
  String _coursecode;
  //String _testId;
  String _class;
  var _endNumber;
  //num _id = 0;

  TestWidget(this.uid, this.doc_id, this._coursecode, this._coursename,
      this._class, this._endNumber);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Dismissible(
      background: Container(
        alignment: Alignment.centerRight,
        color: Color.fromRGBO(69, 123, 157, 1.0),
        child: SizedBox(
          //width: 40.0,
          height: 50.0,
          child: Image.asset('assets/createtest/icons8-delete-100.png'),
        ),
      ),
      key: Key(doc_id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Color.fromRGBO(241, 250, 238, 1.0),
                title: Text(
                  'Delete $_coursename ?',
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(69, 123, 157, 1.0),
                  ),
                ),
                content: Text(
                  'You won\'t be able to undo this action',
                  style: TextStyle(
                    color: Color.fromRGBO(69, 123, 157, 1.0),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child:
                        const Text('No', style: TextStyle(color: Colors.black)),
                  ),
                  TextButton(
                    onPressed: () async {
                      var res = await deleteTest(uid, doc_id);
                      if (res == 'success') {
                        print('test successfuly deleted');
                      }
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Yes',
                        style: TextStyle(color: Colors.black)),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Color.fromRGBO(230, 57, 70, 1.0),
                      ),
                    ),
                  ),
                ],
              );
            });
      },
      child: ListTile(
        onTap: () async {
          provideTestDocID(context, doc_id);
          provideEndNumber(context, _endNumber);
          provideTestName(context, this._coursename);
          provideClass(context, this._class);
          provideTestCode(context, this._coursecode);
          Navigator.pushNamed(context, 'test_info');
        },
        title: Text(
          this._coursename,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            fontFamily: 'Orbitron',
            color: Color.fromRGBO(69, 123, 157, 1.0),
          ),
        ),
        subtitle: Text(this._coursecode,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w100,
              fontFamily: 'Orbitron',
              color: Color.fromRGBO(69, 123, 157, 1.0),
            )),
        trailing: Text(this._class,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w100,
              fontFamily: 'Orbitron',
              color: Color.fromRGBO(69, 123, 157, 1.0),
            )), //TODO: string parse
      ),
    );
  }
}

// Future getEndNumber(uid, doc_id) async {
//   var q = await FirebaseFirestore.instance.collection(uid).doc(doc_id).get();
//   // if (q.)
//   return q.get('endNumber');
//   // return q['endNumber'];
// }
