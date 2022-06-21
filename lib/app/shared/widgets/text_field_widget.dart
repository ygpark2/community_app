import 'package:flutter_modular/flutter_modular.dart';
import 'package:commune_app/app/modules/common/common/styles/color_palettes.dart';
import 'package:flutter/material.dart';

typedef onChangeText = void Function(String);
typedef onValidateText = String? Function(String?);

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({Key? key, this.maxLines = 1, this.hint, this.onChange, this.keyBoard, this.password, this.autovalidate, this.onValidate, this.style, this.value, this.inputBorder, this.controller}) : super(key: key);

  final String? hint;
  final onChangeText? onChange;
  final onValidateText? onValidate;
  final TextInputType? keyBoard;
  final bool? password;
  final bool? autovalidate;
  final TextStyle? style;
  final int? maxLines;
  final String? value;
  final InputBorder? inputBorder;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: Modular.get<ColorPalettes>().text).merge(style);
    return TextFormField(
      controller: controller,
      initialValue: value,
      style: textStyle,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: this.hint,
        border: inputBorder ?? UnderlineInputBorder()
      ),
      onChanged: this.onChange,
      keyboardType: this.keyBoard,
      // autovalidate: autovalidate != null ? autovalidate : false,
      obscureText: this.password == null ? false : this.password!,
      validator: onValidate,
    );
  }
}
