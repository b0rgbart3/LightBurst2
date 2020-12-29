import 'package:flutter/material.dart';

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