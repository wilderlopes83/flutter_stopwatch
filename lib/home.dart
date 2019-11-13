import 'dart:async';

import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  String _buttonText = "Iniciar";
  String _stopwatchText = "00:00:00";
  final _stopWatch = new Stopwatch();
  final _timeout = const Duration(seconds: 1);

  void _startTimeout(){
    new Timer(_timeout, _handleTimeout);
  }

  void _handleTimeout(){
    if (_stopWatch.isRunning){
      _startTimeout();
    }

    setState(() {
      _setStopwatchText();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cronômetro simples"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody(){

    return Column(
      children: <Widget>[        
        Center(          
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,                          
              children: <Widget>[
                RaisedButton(                  
                  onPressed: _startStopButtonPressed,
                  child: Text(_buttonText),
                ),
                //Spacer(flex: 1,),
                RaisedButton(                  
                  onPressed: _resetButtonPressed,
                  child: Text("Reiniciar"),
                ),
              ],  
            ),
          )
           ,
        ),
        Expanded(
          child: FittedBox(
            fit: BoxFit.none,
            child: Text(
              _stopwatchText,
              style: TextStyle(
                fontSize: 72
              )
            ),
          ),
        )
      ],
    );

  }

  void _startStopButtonPressed(){
    setState(() {      
      if (_stopWatch.isRunning){
        _buttonText = "Iniciar";
        _stopWatch.stop();
      }
      else{
        _buttonText = "Parar";
        _stopWatch.start();
        _startTimeout();
      }
    });
  }

  void _resetButtonPressed(){
    if (_stopWatch.isRunning){
      _startStopButtonPressed();
    }
    setState(() {
      _stopWatch.reset();
      _setStopwatchText();      
    });
  }

  void _setStopwatchText() {    //8
    _stopwatchText = _stopWatch.elapsed.inHours.toString().padLeft(2, "0") + ":" +
                    (_stopWatch.elapsed.inMinutes%60).toString().padLeft(2, "0") + ":" +
                    (_stopWatch.elapsed.inSeconds%60).toString().padLeft(2, "0");
  }
}