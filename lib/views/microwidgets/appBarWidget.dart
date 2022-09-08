import 'package:flutter/material.dart';
import '../../../providerclasses/providerclasses.dart' as prov;
import 'package:provider/provider.dart';

// class AppBarWidget extends StatelessWidget {
//   //const AppBarWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {

//     return
//   }
// }

AppBarWidget(context) {
  var appName = Provider.of<prov.User>(context).getUserCredentials;
  return PreferredSize(
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
          "$appName",
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
  );
}
