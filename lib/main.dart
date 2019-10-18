import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';

void main() => runApp(MyApp());

//Variables
SpeechRecognition _speechRecognition;
bool _isAvailable = false;
bool _isListening = false;
String resText = "I'm Deadpool!";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter-speech-recognition',
//      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff8b2323),
        backgroundColor: Color(0xff292929),
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
        title: Text('Speech Recognition',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      backgroundColor: Color(0xff171717),
      body: _buildBody(),
    );
  }

  Widget _buildBody(){
    return Container(
        margin: EdgeInsets.only(bottom: 40),
        child: new Stack(
          children: <Widget>[
            _deadPoolImage(),
            Positioned(
              child: new Align(
                alignment: FractionalOffset.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    _textLabelResult(),
                    _clearTextLabelButton(),
                    _rowWidget()
                  ],
                ),
              )
            )
          ],
        )
    );
  }

  Widget _deadPoolImage(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 500.0,
          width: 300.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('assets/deadpool.png'),
              fit: BoxFit.fitWidth
            )
          ),
        )
      ],
    );
  }

  Widget _rowWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
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
      backgroundColor: Color(0xff8b2323),
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
      backgroundColor: Color(0xff8b1a1a),
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
      backgroundColor: Color(0xff8b1a1a),
      mini: true,
      onPressed: (){
        if(_isListening){
          _speechRecognition.cancel().then((result) => setState((){
              _isListening = result;
              result = "";
            }),
          );
        }
        resText = "\nI'm Deadpool!";
      },
    );
  }

  Widget _clearTextLabelButton(){
    return Container(
        margin: EdgeInsets.all(50),
        child: OutlineButton(
          child: Text('CLEAR TEXT'),
          textColor: Colors.white,
          borderSide: BorderSide(color: Colors.white),
          onPressed: (){
            setState(() {
              resText = "";
            });
          },
        )
    );
  }

  Widget _textLabelResult(){
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      child: new Text(resText,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
        ),
      ),
    );
  }

}


