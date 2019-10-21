// Copyright 2018 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
/* 
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride; */
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'dart:async'; //Asyncronus library for http requests.
import 'dart:convert'; //Library for json transformation.

//import 'package:flutter/services.dart';
//import 'package:holding_gesture/holding_gesture.dart';          //Currently not used but will be needed in posterior improvements.
void main() => runApp(MyApp());
/* void main() {
  // See https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override
  // debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  runApp(new MyApp());
} */

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Sirius',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, @required this.title})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum ConnectionStatus { connected, disconnected }

//Remember to write ' with WidgetsBindingObserver if needed'

class _MyHomePageState extends State<MyHomePage> {
  var status = ConnectionStatus.disconnected;
  final String _host = 'Enter your Host'; //For get
  int _size = 0;
  String _position = ' ';
  //Map _data;
  int _magnet_On;
  //http.Client _client;
  var fromStream;

  void _Move(String direction) {
    switch (direction) {
      case 'u':
        sendData('u');
        break;

      case 'd':
        sendData('d');
        break;

      case 'r':
        sendData('r');
        break;

      case 'l':
        sendData('l');
        break;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //WidgetsBinding.instance.removeObserver(this);
    print('disposed');
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _magnet_On = 0;
    //_client = http.Client();                                   Delete if not needed before WebSocket test.
    //getData();                                                 Delete if not needed before WebSocket test.
    //WidgetsBinding.instance.addObserver(this);
    print('Initialized');
    _position = '0';
  }

  void drop() {
    if (_magnet_On == 1) {
      _magnet_On = 0;
      sendData('x');
    }
  }

  void pickUp() {
    if (_magnet_On == 0) {
      sendData('e');
    }
  }

  void sendData(String message) {
    if ( status == ConnectionStatus.connected) {

    }
  }

  void connect() async {
    
  }

  void disconnect() async {
    
    print("disconnected");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          style: TextStyle(fontFamily: 'Raleway', fontSize: 30.0),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Machine\nController',
                  style: TextStyle(
                      fontSize: 40.0,
                      decoration: TextDecoration.none,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w700,
                      color: Colors.deepPurple[300]),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(children: <Widget>[
                      Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, )),
                      Text(
                        'Position',
                        style: TextStyle(
                            fontFamily: 'Raleway', color: Colors.blue[300]),
                      )
                    ]),
                  ),
                  Expanded(
                    child: Column(children: <Widget>[
                      Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[300]),
                          child:
                              /*StreamBuilder(
                            stream: widget.channel.stream,
                            initialData: _size,
                            builder:(context,snapshot){

                              if(snapshot.hasError){
                                return Icon(Icons.warning);
                              }

                              if(snapshot.hasData){
                                fromStream = snapshot.data;
                                _size = fromStream['tamanno_disc'];
                                _magnet_On = fromStream['iman'];
                                return Text(_size.toString(), textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Raleway',color: Colors.purple, fontSize: 50.0),);
                              }
                              return Text(
                                _size.toString(),                                 //Size of the object taken
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                fontFamily: 'Raleway',
                                  color: Colors.purple,
                                  fontSize: 50,
                                )
                            );}
                          )
                          */
                              Text(_size.toString(), //Size of the object taken
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Raleway',
                                    color: Colors.purple,
                                    fontSize: 50,
                                  ))),
                      Text(
                        'Object Size',
                        style: TextStyle(
                            fontFamily: 'Raleway', color: Colors.blue[300]),
                      )
                    ]),
                  ),
                  Expanded(
                    child: Column(children: <Widget>[
                      Container(
                        height: 60,
                        width: 60,
                        child: RaisedButton(
                          onPressed: pickUp,
                          child: Icon(Icons.play_arrow),
                          color: Colors.lightBlue,
                        ),
                      ),
                      Text(
                        'Pick Up',
                        style: TextStyle(
                            fontFamily: 'Raleway', color: Colors.blue[300]),
                      )
                    ]),
                  ),
                  Expanded(
                    child: Column(children: <Widget>[
                      Container(
                        height: 60,
                        width: 60,
                        child: RaisedButton(
                          onPressed:
                              drop, //Here might be impremented the drop function
                          child: Icon(Icons.stop),
                          color: Colors.lightBlue,
                        ),
                      ),
                      Text(
                        'Drop',
                        style: TextStyle(
                            fontFamily: 'Raleway', color: Colors.blue[300]),
                      )
                    ]),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              width: 100,
              child: RaisedButton(
                onPressed: () => _Move('u'),
                child: const Icon(Icons.arrow_upward),
                color: Colors.blue[300],
                //color:  Colors.white
              ),
            ),
            SizedBox(
                height: 50,
                width: 300,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                      onPressed: () => _Move('l'),
                      child: const Icon(Icons.arrow_left),
                      color: Colors.blue[300],
                      //color:  Colors.white,
                    )),
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Expanded(
                        child: RaisedButton(
                      onPressed: () => _Move('r'),
                      child: const Icon(Icons.arrow_right),
                      color: Colors.blue[300],
                      //color:  Colors.white
                    ))
                  ],
                )),
            SizedBox(
              height: 40,
              width: 100,
              child: RaisedButton(
                onPressed: () => _Move('d'),
                child: const Icon(Icons.arrow_downward),
                color: Colors.blue[300],
                //color:  Colors.white
              ),
            )
          ],
        ),
      ),
    );
  }
}
