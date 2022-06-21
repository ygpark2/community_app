import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red)),
          onPressed: () {
            Modular.to.pushReplacementNamed('/home');
          },
          child: Text('Navigate to home won\'t do dispose in LoginModule'),
        ),
      ),
    );
  }
}
