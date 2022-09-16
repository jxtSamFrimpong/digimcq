import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../providerclasses/providerclasses.dart' as prov;
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../views/microwidgets/appBarWidget.dart';
import '../views/microwidgets/listOfCreatedTests.dart';
import 'microwidgets/addTestMicro.dart';
import '../utils/authservice.dart';
import 'microwidgets/appBarWidget.dart';
//import 'datas.dart';

class CreateTestPage extends StatelessWidget {
  //CreateTestPage();

  Future<void> uploadingData(_cred, String class_, String course_code,
      String description, String name, num endNumber) async {
    var result =
        await FirebaseFirestore.instance.collection(_cred.uid.toString()).add({
      'class_': class_,
      'course_code': course_code,
      'description': description,
      'name': name,
      'endNumber': endNumber,
      'scheme': []
    });
    await FirebaseFirestore.instance
        .collection(_cred.uid.toString())
        .doc(result.id)
        .collection('students');
    //return result.id;
  }

  void _openAddDialoge(_cred, BuildContext context) {
    TextEditingController _name = TextEditingController();
    TextEditingController _description = TextEditingController();
    TextEditingController _code = TextEditingController();
    TextEditingController _class = TextEditingController();
    TextEditingController _endNumber = TextEditingController();

    Widget cancelButton = MaterialButton(
      child: Text(
        'Cancel',
        style: TextStyle(
          fontFamily: 'Orbitron',
          color: Color.fromRGBO(29, 53, 87, 1.0),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create button
    Widget okButton = ElevatedButton(
      child: Text(
        "OK",
        style: TextStyle(
          fontFamily: 'Orbitron',
          color: Color.fromRGBO(29, 53, 87, 1.0),
        ),
      ),
      onPressed: () async {
        //TODO
        //Sub,it details to firebase and create test
        if (_class.text.length > 1 &&
            _code.text.length > 1 &&
            _name.text.length > 1 &&
            int.parse(_endNumber.text) > 0) {
          await uploadingData(
              _cred,
              _class.text.toString(),
              _code.text.toString(),
              _description.text.toString(),
              _name.text.toLowerCase(),
              int.parse(_endNumber.text));
          Navigator.of(context).pop();
        } else {
          //TOAST
          Fluttertoast.showToast(
              msg: "Fill all required Fields",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          print('cannot update with empty data');
        }
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Color.fromRGBO(241, 250, 238, 1.0),
      title: Text(
        "Create Test",
        style: TextStyle(
          fontFamily: 'Orbitron',
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(29, 53, 87, 1.0),
        ),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        //color: Color.fromRGBO(241, 250, 238, 1.0),
        child: ListView(
          children: [
            TextField(
              controller: _name,
              // keyboardType: TextInputType.,
              decoration: InputDecoration(
                labelText: 'Test Name',
                hintText: 'Enter Name of Test',
                labelStyle: TextStyle(
                  fontFamily: 'Orbitron',
                  color: Color.fromRGBO(29, 53, 87, 1.0),
                ),
              ),
              enableInteractiveSelection: true,
            ),
            TextField(
              controller: _code,
              decoration: InputDecoration(
                labelText: 'Course Code',
                hintText: 'Enter Course Code',
                labelStyle: TextStyle(
                  fontFamily: 'Orbitron',
                  color: Color.fromRGBO(29, 53, 87, 1.0),
                ),
              ),
            ),
            TextField(
              controller: _class,
              decoration: InputDecoration(
                labelText: 'Class',
                hintText: 'Eg. Computer Engineering 4',
                labelStyle: TextStyle(
                  fontFamily: 'Orbitron',
                  color: Color.fromRGBO(29, 53, 87, 1.0),
                ),
              ),
            ),
            TextField(
              controller: _endNumber,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Number of questions',
                hintText: 'Eg. Computer Engineering 4',
                labelStyle: TextStyle(
                  fontFamily: 'Orbitron',
                  color: Color.fromRGBO(29, 53, 87, 1.0),
                ),
              ),
            ),
            TextField(
              controller: _description,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Enter description of test',
                labelStyle: TextStyle(
                  fontFamily: 'Orbitron',
                  color: Color.fromRGBO(29, 53, 87, 1.0),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //TextEditingController addtestcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _testDocID = Provider.of<prov.User>(context).getTestDocID;
    var _cred = Provider.of<prov.User>(context).getUserCredentials;
    ImageProvider provProfPic(inp) {
      ImageProvider prof = inp;
      if (prof != null) {
        return prof;
      } else {
        return AssetImage('assets/drawer/user.png');
      }
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 250, 238, 1.0),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(29, 53, 87, 1.0),
        child: Image.asset(
          'assets/createtest/icons8-add-64.png',
          fit: BoxFit.cover,
        ),
        onPressed: () {
          //print(_cred.uid!);
          _openAddDialoge(_cred, context);
        },
      ),
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
                  Navigator.pushNamed(context, 'about');
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
      body: Column(
          //scrollDirection: Axis.vertical,
          //shrinkWrap: true,
          //mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: listOfCreatedTests(),
            ),
          ]),
    );
  }
}
