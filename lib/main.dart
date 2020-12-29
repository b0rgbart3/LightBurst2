import 'package:flutter/material.dart';
// import 'dart:developer' as developer;
import 'components/board.dart';

void main() {
  runApp(LightBurst());
}

class BkgImageWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    AssetImage bkgAsset = AssetImage("images/bkg1.jpg");
    Image image = Image(image: bkgAsset,
    fit: BoxFit.fill,
    width: screenWidth,
    height: screenHeight

    );
    return Container(child: image );
  }

}

class ColorFilterWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Color c2 = const Color(0x440077ff); // fully opaque white (visible)

    return Container(
      color: c2,
      width: screenWidth,
      height: screenHeight
    );
  }
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
      boardKey.currentState.clearBoard();
      //board.currentState.clearBoard();
    });
  }

  var onState = true;
  GlobalKey<BoardState> boardKey = GlobalKey();
  var board;

  @override
  Widget build(BuildContext context) {
  var board = Board(key: boardKey);

    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: Container(
         color: Colors.blue[900],

        child: Stack(
          children: [
            // Image.asset('images/bkg1.jpg'),
            BkgImageWidget(),
            ColorFilterWidget(),
            Center(

          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

              board
              
            ,
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      )]
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.api),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
