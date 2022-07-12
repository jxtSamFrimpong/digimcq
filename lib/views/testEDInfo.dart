import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/material.dart';

class TestEDInfo extends StatelessWidget {
  TestEDInfo();

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
                child: Text('Grades'),
              )),
              Tab(child: Center(child: Text('Mark More'))),
              Tab(child: Center(child: Text('Mark Scheme')))
            ]),
          ),
          body: TabBarView(children: [
            Container(
              color: Colors.orange,
            ),
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
