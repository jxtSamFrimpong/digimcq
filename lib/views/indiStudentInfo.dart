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
    var appName = Provider.of<prov.User>(context).getUserCredentials;

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
              "$appName",
              style: TextStyle(color: Colors.black),
            ),
            actions: [],
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          // Important: Remove any padding from the ListView.
          //padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(_cred.displayName.toString()),
              accountEmail: Text(_cred.email),
              currentAccountPicture: CircleAvatar(
                //backgroundColor: Colors.orange,
                backgroundImage:
                    provProfPic(NetworkImage(_cred.photoURL.toString())),
                onBackgroundImageError: (exception, stackTrace) {},

                // FadeInImage(
                //   placeholder: AssetImage('assets/user.png'),
                //   image: NetworkImage(
                //     _cred.photoURL.toString(),
                //   ),
                // ),
                // foregroundImage:
                //     provProfPic(AssetImage('assets/drawer/user.png')),
                //child: ,
                //),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text("About App"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Container(),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log Out"),
              onTap: () {
                //signOutprov(context);
                AuthService().signOut();

                //Navigator.pop(context);
              },
            ),
          ],
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
