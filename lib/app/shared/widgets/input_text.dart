import 'package:flutter/material.dart';
import 'package:commune_app/app/shared/tool/constants.dart';
import 'package:commune_app/app/shared/tool/sizes.dart';

class InputText extends StatefulWidget {

  final String label;
  final String placeholder;
  final String msgError;
  final void Function(String) change;
  final bool error;
  final bool enable;
  final String value;

  const InputText({
    Key? key,
    required this.label,
    required this.change,
    required this.placeholder,
    required this.msgError,
    required this.error,
    this.enable = true,
    required this.value,
  }) : super(key: key);

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {

  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.text = widget.value;
  }

  @override
  void dispose() {
    super.dispose();

    if (controller.dispose != null){
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.defaultPadding / 2,
        left: SizeConfig.defaultPadding,
        right: SizeConfig.defaultPadding,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                bottom: 3
            ),
            alignment: Alignment.centerLeft,
            child: widget.label != null ? Text(
              widget.label,
              style: TextStyle(
                  fontSize: 14,
                  color: themeColors.textSecondary
              ),
            ) : null,
          ),
          Container(
            height: 56,
            decoration: BoxDecoration(
                color: themeColors.tertiary,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: themeColors.textSecondary
                )
            ),
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: controller,
              onChanged: widget.change,
              decoration: InputDecoration(
                  hintText: widget.placeholder,
                  hintStyle: TextStyle(
                    color: themeColors.textSecondary,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: SizeConfig.defaultPadding,
                    right: SizeConfig.defaultPadding,
                    top: 3,
                  )
              ),
              style: TextStyle(
                fontSize: 15,
                color: themeColors.textPrimary,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 5,
            ),
            alignment: Alignment.centerLeft,
            child: !widget.error ? null : Text(
              widget.msgError,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.red[600]
              ),
            ),
          ),
        ],
      ),
    );
  }
}