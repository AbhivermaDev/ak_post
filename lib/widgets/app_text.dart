import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double height;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final bool? mandatory;
  final int? maxLines;

  const AppText({
    super.key,
    required this.title,
    this.fontSize = 12,
    this.fontWeight,
    this.height=1.3,
    this.color,
    this.textAlign,
    this.textOverflow,
    this.mandatory,
    this.maxLines, this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return  mandatory == true
        ? Row(
      children: [
        Text(
          title,
          maxLines: maxLines,
          textAlign: textAlign,
          style: TextStyle(
            height: height,
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            // fontFamily: fontFamily??'RethinkSans',
            overflow: textOverflow,

          ),
        ),
        Visibility(
          visible: mandatory ?? false,
          child: const Text(
            " *",
            style: TextStyle(color: Colors.red),
          ),
        )
      ],
    )
        : Text(
      title,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        overflow: textOverflow,
        // fontFamily: 'RethinkSans',
      ),
    );
  }
}
