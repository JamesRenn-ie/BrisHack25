
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(

          children: [
            Flexible(
              
              child: Text("Stats"),
            )

          //   SingleChildScrollView(
          //     child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.stretch,
          //         children: [
          //
          //           Center(
          //             child: Text(
          //             'STORE',
          //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          //             ),
          //           ),
          //           SizedBox(height: 10), // Space between store and coins row
          //           Padding(
          //             padding: EdgeInsets.symmetric(horizontal: 16),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 SizedBox(), // Placeholder to push coins to the right
          //                 Row(
          //                 ),
          //               ],
          //             ),
          //           ),
          //
          //
          //
          //         ]
          // ),
          //
          //
          //   )

          ],
      ),
      )

    );
  }

}