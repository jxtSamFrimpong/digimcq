import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import '../views/microwidgets/appBarWidget.dart';
import '../views/microwidgets/listOfCreatedTests.dart';
import 'microwidgets/addTestMicro.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../utils/authservice.dart';
//import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CreateTestPage extends StatelessWidget {
  Future<void> uploadingData(String class_, String course_code,
      String description, String name) async {
    await FirebaseFirestore.instance.collection("tests").add({
      'class_': class_,
      'course_code': course_code,
      'description': description,
      'name': name,
    });
  }

  void _openAddDialoge(BuildContext context) {
    TextEditingController _name = TextEditingController();
    TextEditingController _description = TextEditingController();
    TextEditingController _code = TextEditingController();
    //TextEditingController _guid = TextEditingController();
    TextEditingController _class = TextEditingController();

    // Create button
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        //TODO
        //Sub,it details to firebase and create test
        uploadingData(_class.text.toString(), _code.text.toString(),
            _description.text.toString(), _name.text.toLowerCase());
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Create Test"),
      content: ListView(
        children: [
          TextField(
            controller: _name,
            decoration: InputDecoration(
                labelText: 'Test Name', hintText: 'Enter Name of Test'),
          ),
          // TextField(
          //   controller: _guid,
          //   decoration: InputDecoration(
          //       labelText: 'Unique Identifier',
          //       hintText: 'Give a globally unique identifier'),
          // ),
          TextField(
            controller: _code,
            decoration: InputDecoration(
                labelText: 'Course Code', hintText: 'Enter Course Code'),
          ),
          TextField(
            controller: _description,
            decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Enter description of test'),
          ),
          TextField(
            controller: _class,
            decoration: InputDecoration(
                labelText: 'Class', hintText: 'Eg. Computer Engineering 4'),
          ),
        ],
      ),
      actions: [
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

  CreateTestPage();
  TextEditingController addtestcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _openAddDialoge(context);
        },
      ),
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
              "APP_NAME",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ))
            ],
          ),
        ),
      ),
      drawer: Drawer(
          child: Column(
        // Important: Remove any padding from the ListView.
        //padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Abhishek Mishra"),
            accountEmail: Text("abhishekm977@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text(
                "A",
                style: TextStyle(fontSize: 40.0),
              ),
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
              AuthService().signOut();
              //Navigator.pop(context);
            },
          ),
        ],
      )),
      body: Column(
          //scrollDirection: Axis.vertical,
          //shrinkWrap: true,
          //mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: listOfCreatedTests(),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     SizedBox(
            //       width: 200.0,
            //       child: TextField(
            //         controller: addtestcontroller,
            //       ),
            //     ),
            //     MaterialButton(
            //       onPressed: () {
            //         //TODO do some checks add test to firebase
            //         addtestcontroller.clear();
            //         Future.delayed(Duration(seconds: 3));
            //         Navigator.pushNamed(context, 'test_info');
            //       },
            //       child: Center(child: Text('+ ADD')),
            //     )
            //   ],
            // )
            // ,
          ]),
    );
  }
}
