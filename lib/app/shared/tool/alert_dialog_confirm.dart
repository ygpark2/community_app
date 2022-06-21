
import 'package:flutter/material.dart';

import 'constants.dart';

class AlertDialogConfirm {

  BuildContext context;
  String title;
  String description;
  Function onPressNot;
  String titleNot;
  Function onPressYes;
  String titleYes;

  AlertDialogConfirm({
    required this.context,
    required this.title,
    required this.description,
    required this.onPressNot,
    this.titleNot: 'Não',
    required this.onPressYes,
    this.titleYes: 'Sim',
  });

  show() {

    Widget notButton = RaisedButton(
      color: themeColors.secondary,
      child: Text("$titleNot"),
      onPressed: onPressNot(),
    );

    Widget yesButton = RaisedButton(
      child: Text("$titleYes"),
      color: themeColors.secondary,
      onPressed: onPressYes(),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("$title"),
      content: Text("$description"),
      backgroundColor: themeColors.tertiary,
      titleTextStyle: TextStyle(
        color: themeColors.textPrimary,
        fontSize: 20,
      ),
      contentTextStyle: TextStyle(
        color: themeColors.textSecondary,
        fontSize: 18,
      ),
      actions: [
        notButton,
        yesButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}