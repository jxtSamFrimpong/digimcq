import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/src/foundation/key.dart';

import 'microwidgets/appBarWidget.dart';
import 'package:flutter/material.dart';
import 'studentSummary.dart';

class TestInfo extends StatelessWidget {
  const TestInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('APP_NAME'),
            bottom: TabBar(tabs: [
              Tab(
                  child: Center(
                child: Text('Student Summary'),
              )),
              Tab(child: Center(child: Text('Marking'))),
              Tab(child: Center(child: Text('Grades')))
            ]),
          ),
          body: TabBarView(children: [
            StudentsSummary(),
            Container(
              color: Colors.green,
            ),
            Container(
              color: Colors.blue,
            )
          ]),
        ));
  }
}
