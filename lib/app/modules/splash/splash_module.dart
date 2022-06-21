import 'package:flutter_modular/flutter_modular.dart';

import 'splash_controller.dart';
import 'splash_page.dart';

class SplashModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => SplashController()),
      ];

  @override
  List<ModularRoute> get routers => [
        ChildRoute(Modular.initialRoute, child: (_, args) => SplashPage()),
      ];

  // static Inject get to => Inject<SplashModule>.of();
}
