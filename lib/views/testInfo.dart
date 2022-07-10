import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/src/foundation/key.dart';

import 'microwidgets/appBarWidget.dart';
import 'package:flutter/material.dart';

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
                child: Text('Mark OMR'),
              )),
              Tab(child: Center(child: Text('Mark Scheme'))),
              Tab(child: Center(child: Text('Grades')))
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

class TakeTestOrKey extends StatelessWidget {
  const TakeTestOrKey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
    // 100000000
    // 00000000
    // 00000000
    // 00000000
  }
}
