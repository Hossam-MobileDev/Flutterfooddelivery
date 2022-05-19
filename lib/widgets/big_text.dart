
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overflow;
   BigText({Key? key,required this.text,this.color =const Color(0xFF332d2b),
    this.overflow=TextOverflow.ellipsis,this.size=20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: size
      ),
    );
  }
}
