import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

ToastFuture showCustomToast(var text) {
  return showToast(
    text,
    textPadding: EdgeInsets.all(12),
    position: ToastPosition.bottom,
    animationCurve: Curves.easeIn,
    animationBuilder: Miui10AnimBuilder(),
    textDirection: TextDirection.rtl,
    textStyle:
        TextStyle(fontSize: 18, color: Colors.white, fontFamily: "YekanBakh"),
    radius: 10.0,
    animationDuration: Duration(milliseconds: 200),
    duration: Duration(seconds: 3),
  );
}
