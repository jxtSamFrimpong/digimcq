import 'package:flutter/material.dart';
import '../../providerclasses/providerclasses.dart' as prov;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../utils/authservice.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
    var _ChosenStudent = Provider.of<prov.User>(context).getChosenStudent;
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: AppBar(
            centerTitle: true,
            iconTheme: IconThemeData(
              color: Color.fromRGBO(241, 250, 238, 1.0),
            ),
            shadowColor: Color.fromRGBO(69, 123, 157, 1.0),
            toolbarHeight: 50.0,
            backgroundColor: Color.fromRGBO(29, 53, 87, 1.0),
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
            actions: [
              // IconButton(
              //   onPressed: () {},
              //   icon: Icon(
              //     Icons.search,
              //     //color: Color.fromRGBO(241, 250, 238, 1.0),
              //   ),
              // )
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Color.fromRGBO(241, 250, 238, 1.0),
          child: Column(
            // Important: Remove any padding from the ListView.
            //padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                onDetailsPressed: () {
                  Navigator.pushNamed(context, 'profile');
                },
                decoration: BoxDecoration(
                  color: Color.fromRGBO(29, 53, 87, 1.0),
                  //color: Color.fromRGBO(69, 123, 157, 1.0),
                ),
                accountName: Text(
                  _cred.displayName.toString(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Rampart_One',
                    color: Color.fromRGBO(241, 250, 238, 1.0),
                  ),
                ),
                accountEmail: Text(
                  _cred.email,
                  style: TextStyle(
                    //fontSize: 25,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Rampart_One',
                    color: Color.fromRGBO(241, 250, 238, 1.0),
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromRGBO(241, 250, 238, 1.0),
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
                leading: Icon(
                  Icons.home,
                  color: Color.fromRGBO(69, 123, 157, 1.0),
                ),
                title: Text(
                  "Home",
                  style: TextStyle(
                    //fontSize: 25,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Orbitron',
                    color: Color.fromRGBO(69, 123, 157, 1.0),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Color.fromRGBO(69, 123, 157, 1.0),
                ),
                title: Text(
                  "Settings",
                  style: TextStyle(
                    //fontSize: 25,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Orbitron',
                    color: Color.fromRGBO(69, 123, 157, 1.0),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.contacts,
                  color: Color.fromRGBO(69, 123, 157, 1.0),
                ),
                title: Text(
                  "About App",
                  style: TextStyle(
                    //fontSize: 25,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Orbitron',
                    color: Color.fromRGBO(69, 123, 157, 1.0),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Container(),
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Color.fromRGBO(69, 123, 157, 1.0),
                ),
                title: Text(
                  "Log Out",
                  style: TextStyle(
                    //fontSize: 25,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Orbitron',
                    color: Color.fromRGBO(69, 123, 157, 1.0),
                  ),
                ),
                onTap: () {
                  //signOutprov(context);
                  AuthService().signOut();

                  //Navigator.pop(context);
                },
              ),
            ],
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
            return Center(
              child: LoadingAnimationWidget.newtonCradle(
                color: Color.fromRGBO(29, 53, 87, 1.0),
                size: 200,
              ),
            );
          }
          // print(snapshot.data!);
          // var individualStudentDoc = snapshot.data!;
          return Text(snapshot.data!['student_idx']);
        },
      ),
    ));
  }
}

indiStudentInfo(data) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Container(
          child: Text(data['student_idx']),
        )),
      ),
      Container(
        child: Row(children: [
          Text('Score: ${data["got_marks"]}'),
          Text('${data["percentage"]}%'),
          Text('Out of: ${data["out_of"]}')
        ]),
      ),
      Container(
        child: Image.asset('assets/login/data-sheet-256.png'),
      ),
    ],
  );
}
