import 'package:flutter/material.dart';
import '../views/microwidgets/appBarWidget.dart';
import '../views/microwidgets/listOfCreatedTests.dart';

class CreateTestPage extends StatelessWidget {
  const CreateTestPage();

  @override
  Widget build(BuildContext context) {
    return Column(
        //scrollDirection: Axis.vertical,
        //shrinkWrap: true,
        children: [
          AppBarWidget(),
          listOfCreatedTests()
          // ,
        ]);
  }
}
