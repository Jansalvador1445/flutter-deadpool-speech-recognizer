import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green
      ),
      home: Body()
    );
  }
}

class Body extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => BodyState();
}

class BodyState extends State<Body>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Recognition'),
      ),
      body: _buildBody(),
    );
  }
}

Widget _buildBody(){
  return null;
}