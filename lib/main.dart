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

  Widget _buildBody(){
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _rowWidget(),
            _textLabelResult(),
          ],
        )
    );
  }

  Widget _rowWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center ,
      children: <Widget>[
        _floatingButtonStop(),
        _floatingButtonMic(),
        _floatingButtonCancel(),
      ],
    );
  }

  Widget _floatingButtonMic(){
    return FloatingActionButton(
      child: Icon(Icons.mic),
      onPressed: (){
        if(_isAvailable && !_isListening){
          _speechRecognition.listen(locale: "en_US").then((result) => print('$result'));
        }
      },
    );
  }

  Widget _floatingButtonStop(){
    return FloatingActionButton(
      child: Icon(Icons.stop),
      mini: true,
      onPressed: (){
        if(_isListening){
          _speechRecognition.stop().then((result) => setState(() => _isListening = result));
        }
      },
    );
  }

  Widget _floatingButtonCancel(){
    return FloatingActionButton(
      child: Icon(Icons.cancel),
      mini: true,
      onPressed: (){
        if(_isListening){
          _speechRecognition.cancel().then((result) => setState((){
              _isListening = result;
              result = "";
            }),
          );
        }
      },
    );
  }

  Widget _textLabelResult(){
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      child: Text(resText),
    );
  }

}


