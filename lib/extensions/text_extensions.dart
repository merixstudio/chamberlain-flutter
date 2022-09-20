import 'package:flutter/material.dart';

extension TextSizeExtension on Text {
  double width(BuildContext context) => (TextPainter(
        text: TextSpan(
          text: data,
          style: style,
        ),
        maxLines: maxLines,
        textScaleFactor: MediaQuery.of(context).textScaleFactor,
        textDirection: textDirection ?? TextDirection.ltr,
      )..layout())
          .size
          .width;
}
