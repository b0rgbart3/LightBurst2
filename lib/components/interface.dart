import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../model/settings.dart';
import 'dart:developer' as developer;

class fingerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    AssetImage fingerAsset = AssetImage("images/finger.png");
    Image fingerImage = Image(image: fingerAsset, fit: BoxFit.fill, width:70.0, height: 60.0);

    return Container(child: fingerImage);
  }
}
class BkgImageWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {


    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Settings mySettings = Settings();
    // developer.log("building background image: colorIndex: " + mySettings.colorIndex.toString());
    AssetImage bkgAsset = AssetImage("images/bkg5.jpg");
    Image image = Image(image: bkgAsset,
    fit: BoxFit.fill,
    width: screenWidth,
    height: screenHeight

    );
    return Container(child: 
    ColorFiltered( colorFilter: ColorFilter.mode(mySettings.myColorSet.background, BlendMode.overlay),
      child:image)
     );
     //   return Container(child: image);
   
  }

}

class ColorFilterWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Settings mySettings = Settings();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
   // Color c2 = const Color(0x440077ff); 
   // fully opaque white (visible)
    // Color c2 = const Color(0x4400FF9D); 
      Color c2 = mySettings.myColorSet.shadow;
    
    return Container(
      color: c2,
      width: screenWidth,
      height: screenHeight
    );
  }
}

class TitleText extends StatelessWidget {

  TitleText(this._myString);
  String _myString;
  
  @override
  Widget build(BuildContext context) {

    return Text(
      _myString,
      textDirection: TextDirection.ltr,
      style: TextStyle(
        color: HexColor("#f2f2f2"),
        decoration: TextDecoration.none,
        fontFamily: 'Heebo',
        fontSize: 44,
        fontWeight: FontWeight.w900,
        shadows: [
            Shadow(
              color: Colors.black,
              offset: Offset(0, 0),
              blurRadius: 15,
            ),
          ],
      ),
    );
  }
}


Widget boxText(myString, textColor, textShadowColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child:Text(myString,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          decoration: TextDecoration.none,
          fontFamily: 'Heebo',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          shadows: [
            Shadow(
              color: textShadowColor,
              offset: Offset(0, 0),
              blurRadius: 30,
            ),
          ],
        )));
  }

Widget infoText(myString, textColor, textShadowColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child:Text(myString,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: textColor,
          decoration: TextDecoration.none,
          fontFamily: 'Heebo',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          shadows: [
            Shadow(
              color: textShadowColor,
              offset: Offset(0, 0),
              blurRadius: 30,
            ),
          ],
        )));
  }

Widget subTitleText(myString) {
    return Padding(
      padding: EdgeInsets.only(top:10.0, bottom:16.0),
      child:Text(myString,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          decoration: TextDecoration.none,
          fontFamily: 'Heebo',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          shadows: [
            Shadow(
              color: Colors.black,
              offset: Offset(0, 0),
              blurRadius: 30,
            ),
          ],
        )));
  }
