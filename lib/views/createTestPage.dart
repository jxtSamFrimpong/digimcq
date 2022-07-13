import 'package:flutter/material.dart';
import '../views/microwidgets/appBarWidget.dart';
import '../views/microwidgets/listOfCreatedTests.dart';
import 'microwidgets/addTestMicro.dart';

class CreateTestPage extends StatelessWidget {
  CreateTestPage();
  TextEditingController addtestcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
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
            title: Text("Contact Us"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      )),
      body: Column(
          //scrollDirection: Axis.vertical,
          //shrinkWrap: true,
          children: [
            Row(
              children: [
                TextField(
                  // onChanged: (e){

                  // },
                  controller: addtestcontroller,
                ),
                MaterialButton(
                  onPressed: () {
                    //TODO do some checks add test to firebase
                    addtestcontroller.clear();
                  },
                  child: Center(child: Text('+ ADD')),
                )
              ],
            ),
            Expanded(child: listOfCreatedTests()),
            addTestWidget()
            // ,
          ]),
    );
  }
}
