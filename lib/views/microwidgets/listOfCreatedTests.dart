import 'package:flutter/material.dart';
import '../../dummyData/testCreated.dart' as dummies;
//import 'package:getwidget/getwidget.dart';
import 'package:expandable/expandable.dart';

class listOfCreatedTests extends StatelessWidget {
  listOfCreatedTests({Key? key}) : super(key: key);

  List dummyTests = dummies.Tests;
  List dummyClasses = dummies.classes;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsetsDirectional.all(12.0),
      //height: MediaQuery.of(context).size.height * 0.8,
      child: ListView.builder(
          //physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: dummyTests.length,
          itemBuilder: (BuildContext ctx, int idx) {
            return Column(
              children: [
                // TestWidget(dummyTests[idx]['code'], dummyTests[idx]['name'],
                //     dummyTests[idx]['id'], dummyTests[idx]['classes']),
                TestWidget(dummyTests[idx]['code'], dummyTests[idx]['name'],
                    dummyTests[idx]['id'], dummyTests[idx]['classes']),
                //Divider()
              ],
            );
          }),
    );
    //ListView(
    // scrollDirection: Axis.vertical,
    //height: MediaQuery.of(context).size.height*0.7,
    // child:  shrinkWrap: true,
    //   children: [
    //     TestWidget('COE 419', 'Konkonsa', '315335', 4),
    //     TestWidget('COE 357', 'Linear Electronics', '244314', 6)
    //   ],
    // );
  }
}

class TestWidget extends ListTile {
  //TODO: better fields along
  String _coursename;
  String _coursecode;
  String _testId;
  num _numClasses;

  TestWidget(
      this._coursecode, this._coursename, this._testId, this._numClasses);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return ListTile(
      title: Text(this._coursename),
      subtitle: Text(this._coursecode), //TODO: string parse
    );
  }
}

class TestAccordion extends StatelessWidget {
  String _coursename;
  String _coursecode;
  String _testId;
  num _numClasses;

  TestAccordion(
      this._coursecode, this._coursename, this._testId, this._numClasses);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: TestWidget(
          this._coursecode, this._coursename, this._testId, this._numClasses),
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (BuildContext ctx, int idx) {
              return GestureDetector(
                onTap: () {},
                child: Text('Class $idx'),
              );
            })
      ],
      trailing: SizedBox(
        child: Text('${this._numClasses}'),
      ),
    );
  }
}
