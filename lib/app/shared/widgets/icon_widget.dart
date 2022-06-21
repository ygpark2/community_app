import 'package:flutter_modular/flutter_modular.dart';
import 'package:commune_app/app/modules/common/common/styles/color_palettes.dart';
import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  const IconWidget(this.text, {
    Key? key,
    required this.style,
    required this.textAlign,
    required this.font,
    required this.size,
    required this.color,
    required this.maxLines
  }) : assert(
  text != null,
  'A non-null String must be provided to a Text widget.',
  ),
        super(key: key);
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final String font;
  final double size;
  final Color color;
  final int maxLines;
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: Modular.get<ColorPalettes>().text).merge(style);
    return Text(text,
        textAlign: textAlign ?? TextAlign.start,
        style: textStyle.merge(TextStyle(fontFamily: font)).merge(TextStyle(fontSize: size)).merge(TextStyle(color: color)),
        maxLines: maxLines,
        overflow: maxLines == null ? TextOverflow.visible : TextOverflow.ellipsis);
  }
}
