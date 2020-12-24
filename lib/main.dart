import 'package:flutter/material.dart';
// import 'dart:developer' as developer;
import 'board.dart';

void main() {
  runApp(LightBurst());
}

class LightBurst extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LightBurst',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Game(title: 'LightBurst'),
    );
  }
}

class Game extends StatefulWidget {
  Game({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  var onState = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: Container(
         color: Colors.blue,

        child: Center(

          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

              Board()
              
            ,
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
