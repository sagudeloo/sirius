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

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;          //Library to handle http requests.
import 'package:web_socket_channel/io.dart';
import 'dart:async';                      //Asyncronus library for http requests.
import 'dart:convert';                    //Library for json transformation.
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
//import 'package:flutter/services.dart'; 
//import 'package:holding_gesture/holding_gesture.dart';          //Currently not used but will be needed in posterior improvements.

void main() {
  // See https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // See https://github.com/flutter/flutter/wiki/Desktop-shells#fonts
        fontFamily: 'Roboto',
      ),
      home: MyHomePage(
        title: 'Sirius',
        channel: new IOWebSocketChannel.connect('ws://echo.websocket.org'),
        ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  final WebSocketChannel channel;
  final String title;
  
  MyHomePage({Key key, @required this.title, @required this.channel}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  
  final String _host = 'Enter your Host';   //For get
  final String _url = 'Enter your url';     //for Post
  int _size = 0;
  String _position = ' ';
  //Map _data;
  int _magnet_On;
  //http.Client _client;
  Map fromStream;

  void _Move(String direction){

    switch(direction){

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


  /* @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch(state){
      
      case AppLifecycleState.resumed:
        // _client = http.Client();
        break;
      case AppLifecycleState.inactive:
        
        break;
      case AppLifecycleState.paused:
        // _client.close();
        break;
      case AppLifecycleState.suspending:
        print('Suspending');
        // _client.close();
        break;
    }
  } */


  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    print('disposed');
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    _magnet_On = 0;
    //_client = http.Client();                                   Delete if not needed before WebSocket test.
    //getData();                                                 Delete if not needed before WebSocket test.
    WidgetsBinding.instance.addObserver(this);
    print('Initialized');
    _position = '0';

  }

  void drop(){
   if(_magnet_On == 1){
     _magnet_On = 0;
     sendData('x');
   }
  } 

  void pickUp(){
    if(_magnet_On == 0){
      sendData('e');
    }
  }

  void sendData(String message){
    widget.channel.sink.add(message);
  }


/*
  void sendData(String message) async{
    try{
      var response = await _client.get(_url, headers: {'data' : message});            //The message goes as a map in headers.
      response.statusCode == 200? print('Succesfuly sent'):print('Unsuccesful sent');
    } on Exception catch(e){
      print('Send Error: $e');
    }
  }
*/

/*
  void getData() async{
    try{
      var response = await _client.get(_host);         //Change host for the host path to use.
      _data = json.decode(response.body);
      setState(() {
        _size = _data['tamanno_disc'];
        _size<=3 && _size>=0 ? _size = _size : _size=0;
        _position = _data['posicion'];
        _magnet_On = _data['iman'];
      });
    } on Exception catch(e){
      print('Get Error: $e');
    }
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 30.0
          ),
          ),
        centerTitle: true,
        
      ),
      backgroundColor: Colors.white,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/Logo.PNG')
                    )
                  ),
                )
                 /*Text(
                  'Machine\nController',
                  style: TextStyle(
                    fontSize: 40.0,
                    decoration: TextDecoration.none,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w700,
                    color: Colors.deepPurple[300]
                  ),
                  ),
                  */
              ),
            ),

            SizedBox(
              height: 100,
              width: double.infinity,
              child: Row(
                children: <Widget>[

                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300]
                          ),
                          child: StreamBuilder(
                            stream: widget.channel.stream,
                            builder:(context,snapshot){

                              if(snapshot.hasError){
                                return Icon(Icons.warning);
                              }

                              if(snapshot.hasData){
                                fromStream = json.decode(snapshot.data);
                                _position = fromStream['posicion'].toString();
                                _magnet_On = fromStream['iman'];
                                return Text(_position, textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Raleway',color: Colors.purple, fontSize: 50.0),);
                              }
                              
                              return Text(
                                _position,                                 //Size of the object taken
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                fontFamily: 'Raleway',
                                  color: Colors.purple,
                                  fontSize: 50,
                                )
                            );}
                          )
                        ),
                        Text(
                          'Position',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.blue[300]
                          ),
                          )
                      ]
                    ),
                  ),
                  
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300]
                          ),
                           child: StreamBuilder(
                            stream: widget.channel.stream,
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
                        ),
                        Text(
                          'Object Size',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.blue[300]
                          ),
                          )
                      ]
                    ),
                  ),

                  Expanded(
                    child: Column(
                      children: <Widget>[
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
                            fontFamily: 'Raleway',
                            color: Colors.blue[300]
                          ),
                          )
                      ]
                    ),
                  ),

                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: 60,
                          child: RaisedButton(
                            onPressed: drop,   //Here might be impremented the drop function
                            child: Icon(Icons.stop),
                            color: Colors.lightBlue,
                          ),
                        ),
                        Text(
                          'Drop',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.blue[300]
                          ),
                          )
                      ]
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              width: 100,
              child: RaisedButton(
                onPressed: ()=>_Move('u'),
                child: const Icon(Icons.arrow_upward),
                color: Colors.blue[300],
                //color:  Colors.white
              ),
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: 
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        onPressed: ()=>_Move('l'),
                        child: const Icon(Icons.arrow_left),
                        color: Colors.blue[300],
                        //color:  Colors.white,
                      )
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        onPressed: ()=>_Move('r'),
                        child: const Icon(Icons.arrow_right),
                        color: Colors.blue[300],
                        //color:  Colors.white
                      )
                    )
              ],
              
            )),
            SizedBox(
              height: 40,
              width: 100,
              child: RaisedButton(
                onPressed: ()=>_Move('d'),
                child: const Icon(Icons.arrow_downward),
                color: Colors.blue[300],
                //color:  Colors.white
              ),
            )
          ],
        ),
      ),
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: getData,
        tooltip: 'Get Machine Data',
        child: Icon(Icons.data_usage),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      */
    );
  }
}
