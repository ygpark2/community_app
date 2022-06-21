import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(
                flex: 2,
              ),
              ElevatedButton(
                onPressed: () {
                  Modular.to.pushReplacementNamed('/home');
                },
                child: Text('Will do dispose in LoginModule'),
              ),
              Spacer(),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                onPressed: () {
                  Modular.to.pushNamed('/signup');
                },
                child: Text(
                    'Navigate inside LoginModule and won\'t do dispose in LoginModule'),
              ),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
