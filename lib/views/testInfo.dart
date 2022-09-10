import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/src/foundation/key.dart';

import 'microwidgets/appBarWidget.dart';
import 'package:flutter/material.dart';
import 'studentSummary.dart';
import 'schemeedge.dart';

class TestInfo extends StatelessWidget {
  TestInfo();

//Color.fromRGBO(29, 53, 87, 1.0)


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("MCQ GRADER",
              style: TextStyle(
                fontFamily: 'Rampart_One',
                color: Color.fromRGBO(241, 250, 238, 1.0),
              ),),
          bottom: TabBar(tabs: [
            Tab(
              
              child: Center(
                child: Text('Marking'),
              ),
            ),
            Tab(
              child: Center(
                child: Text('Students'),
              ),
            ),
            Tab(
              child: Center(
                child: Text('Data'),
              ),
            )
          ]),
        ),
        body: TabBarView(
          children: [
            SchemeEdge(),
            StudentsSummary(),
            Container(
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
