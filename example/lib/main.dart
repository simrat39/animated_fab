import 'dart:math';

import 'package:animated_fab/animated_fab.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: ListView.builder(
          controller: scrollController,
          itemCount: 1000,
          itemBuilder: (context, index) => ListTile(
            title: Text("$index"),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit_outlined),
            label: "Sdsd",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit_outlined),
            label: "Sdsd",
          ),
        ],
      ),
      floatingActionButton:
          getFABS().values.toList().elementAt(Random().nextInt(1)),
      floatingActionButtonLocation:
          getFABS().keys.toList().elementAt(Random().nextInt(1)),
    );
  }

  Map<dynamic, dynamic> getFABS() {
    Map<FloatingActionButtonLocation, Widget> fabs = {
      FloatingActionButtonLocation.endDocked: AnimatedFAB(
        icon: Icon(
          Icons.thumbs_up_down,
          color: Colors.white,
        ),
        scrollController: scrollController,
        text: 'Confirm',
        maxWidth: 90,
        backgroundGradient: LinearGradient(
          colors: [
            Color(0xff7F00FF),
            Color(0xffE100FF),
          ],
        ),
        onTap: () {
          print("tapped");
        },
      ),
      // FloatingActionButtonLocation.centerDocked: AnimatedFAB(
      //   icon: Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      //   scrollController: scrollController,
      //   text: 'Add',
      //   maxWidth: 50,
      //   backgroundColor: Colors.teal,
      //   onTap: () {
      //     print("tapped");
      //   },
      // ),
    };
    return fabs;
  }
}
