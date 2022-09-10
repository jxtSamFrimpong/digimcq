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
          centerTitle: true,
          shadowColor: Color.fromRGBO(69, 123, 157, 1.0),
          backgroundColor: Color.fromRGBO(29, 53, 87, 1.0),
          automaticallyImplyLeading: false,
          title: Text(
            "MCQ GRADER",
            style: TextStyle(
              fontFamily: 'Rampart_One',
              color: Color.fromRGBO(241, 250, 238, 1.0),
            ),
          ),
          bottom:
              TabBar(indicatorColor: Color.fromRGBO(168, 218, 220, 1.0), tabs: [
            Tab(
              child: Center(
                child: Text(
                  'Marking',
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    color: Color.fromRGBO(241, 250, 238, 1.0),
                  ),
                ),
              ),
            ),
            Tab(
              child: Center(
                child: Text(
                  'Students',
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    color: Color.fromRGBO(241, 250, 238, 1.0),
                  ),
                ),
              ),
            ),
            Tab(
              child: Center(
                child: Text(
                  'Data',
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    color: Color.fromRGBO(241, 250, 238, 1.0),
                  ),
                ),
              ),
            )
          ]),
        ),
        body: TabBarView(
          children: [
            SchemeEdge(),
            Container(
              color: Color.fromRGBO(241, 250, 238, 1.0),
              child: StudentsSummary(),
            ),
            Container(
              color: Color.fromRGBO(241, 250, 238, 1.0),
            )
          ],
        ),
      ),
    );
  }
}
