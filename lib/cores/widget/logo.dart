import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key, this.width, this.height}) : super(key: key);
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    var logo = FittedBox(
      fit: BoxFit.contain,
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/logo.svg",
            height: 20,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "سینای دیجیتال",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
    return Directionality(
      textDirection: TextDirection.rtl,
      child: width == null && height == null
          ? logo
          : SizedBox(
              width: width,
              height: height,
              child: logo,
            ),
    );
  }
}
