
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      home: MyHomePage(title: 'Sirius'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final List<String> _objSize = ['1','2','3'];
  int _index = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _test(){

    setState(() {
      if(_index == 2)_index=0;
      else _index++;
      print(_index);
    });

  }

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
      backgroundColor: Colors.black,
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
                child: Text(
                  'Machine\nController',
                  style: TextStyle(
                    fontSize: 40.0,
                    decoration: TextDecoration.none,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w700,
                    color: Colors.deepPurple[300]
                  ),
                  ),
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
                          color: Colors.grey
                          ),
                          child: RaisedButton(
                            onPressed: _test,
                            child: Icon(Icons.play_arrow),
                          ),
                        ),
                        Text(
                          'Carry',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.white
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
                          color: Colors.grey
                          ),
                          child: RaisedButton(
                            onPressed: (){print('put');},   //Here might be impremented the carry function
                            child: Icon(Icons.stop),
                          ),
                        ),
                        Text(
                          'Left',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.white
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
                          child: Text(
                            _objSize[_index],                                 //String with the size of the object taken
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              color: Colors.red,
                              fontSize: 50,
                            )
                            )
                        ),
                        Text(
                          'Object Size',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.white
                          ),
                          )
                      ]
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
              width: 100,
              child: RaisedButton(
                onPressed: (){print('Up');},
                child: const Icon(Icons.arrow_upward),
                color: Colors.blue[300],
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
                        onPressed: (){print('left');},
                        child: const Icon(Icons.arrow_left),
                        color: Colors.blue[300],
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
                        onPressed: (){print('right');},
                        child: Icon(Icons.arrow_right),
                        color: Colors.blue[300],
                      )
                    )
              ],
              
            )),
            SizedBox(
              height: 40,
              width: 100,
              child: RaisedButton(
                onPressed: (){print('Down');},
                child: Icon(Icons.arrow_downward),
                color: Colors.blue[300],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

