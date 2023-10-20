import 'package:flutix/globals.dart';
import 'package:flutter/material.dart';

class ImageComponent extends StatelessWidget {
  String url;
  double height;
  double width;
  ImageComponent(
      {Key? key, required this.url, required this.height, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      clipBehavior: Clip.antiAlias,
      color: constPrimaryColor,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.cover,
            ),
          ),
          width: width,
          height: height,
        ),
      ),
    );
  }
}
