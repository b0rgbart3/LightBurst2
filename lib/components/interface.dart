import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

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

class titleText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Text(
      "LIGHTBURST",
      textDirection: TextDirection.ltr,
      style: TextStyle(
        color: HexColor("#f2f2f2"),
        decoration: TextDecoration.none,
        fontFamily: 'Heebo',
      ),
    );
  }
}


Widget boxText(myString) {
    return Text(myString,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          decoration: TextDecoration.none,
          fontFamily: 'Heebo',
          fontSize: 30,
          shadows: [
            Shadow(
              color: Colors.black,
              offset: Offset(0, 0),
              blurRadius: 15,
            ),
          ],
        ));
  }
