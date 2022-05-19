import 'package:flutter/material.dart';
import 'package:fooddelivery/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color iconColor;

  const IconAndTextWidget({Key? key, required this.iconData,
    required this.text,required this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData,color: iconColor,),
        SizedBox(width: 5,),
        SmallText(text: text,)
      ],
    );
  }
}
