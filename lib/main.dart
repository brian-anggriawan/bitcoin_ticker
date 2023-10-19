import 'package:flutter/material.dart';
import 'convert_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('💸 Bitcoin Ticker'),
            backgroundColor: Colors.lightBlue,
          ),
          body: ConvertScreen(),
        ));
  }
}
