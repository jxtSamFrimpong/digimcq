import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/src/foundation/key.dart';

import 'microwidgets/appBarWidget.dart';
import 'package:flutter/material.dart';
import '../views/microwidgets/appBarWidget.dart';

class TestInfo extends StatelessWidget {
  const TestInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AppBarWidget(),
      Expanded(
        child: Container(),
      ),
      TakeTestOrKey()
    ]);
  }
}

class TakeTestOrKey extends StatelessWidget {
  const TakeTestOrKey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width / 3,
            color: Colors.lightBlueAccent,
            child: MaterialButton(
              onPressed: () {},
              child: Icon(Icons.abc),
            )),
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width / 3,
            color: Colors.blueAccent,
            child: MaterialButton(
              onPressed: () {},
              child: Icon(Icons.access_alarm),
            )),
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width / 3,
            color: Colors.blueAccent,
            child: MaterialButton(
              onPressed: () {},
              child: Icon(Icons.access_alarm),
            ))
      ],
    )
        //  GridView(
        //   primary: false,
        //   padding: EdgeInsets.all(8.0),
        //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        //     //crossAxisSpacing: 10.0,
        //     //mainAxisSpacing: 10.0,
        //     //childAspectRatio: 1 / 2,
        //     maxCrossAxisExtent: 500.0,
        //   ),
        //   ,
        // ),
        );
  }
}
