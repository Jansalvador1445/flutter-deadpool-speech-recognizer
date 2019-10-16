import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';

void main() => runApp(MyApp());

//Variables
SpeechRecognition _speechRecognition;
bool _isAvailable = false;
bool _isListening = false;
String resText = "";

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
  void initState(){
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer(){
    _speechRecognition = SpeechRecognition();
    _speechRecognition.setAvailabilityHandler((bool res) => setState(() => _isAvailable = res));
    _speechRecognition.setRecognitionStartedHandler(() => setState(() => _isListening = true));
    _speechRecognition.setRecognitionResultHandler((String speech) => setState(() => resText = speech));
    _speechRecognition.setRecognitionCompleteHandler(() => setState(() => _isListening = false));
    _speechRecognition.activate().then((res) => setState(() => _isAvailable = res));
  }

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
  return Container(
    child: Column(
      children: <Widget>[
        _floatingButton(),
      ],
    )
  );
}

Widget _floatingButton(){
  return FloatingActionButton(
    onPressed: (){
      resText = "Clicked";
      print(resText + "haha");
    },
  );
}


