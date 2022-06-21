import 'login_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'login_page.dart';
import 'sign_up_page.dart';

class LoginModule extends Module {

  @override
  List<Bind> get binds => [
    Bind((i) => LoginController()),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(Modular.initialRoute, child: (_, __) => LoginPage()),
    ChildRoute('/signup', child: (_, __) => SignUpPage())
  ];

  // static Inject get to => Inject<LoginModule>.of();
}
