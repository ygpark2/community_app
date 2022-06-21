import 'loading_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'loading_page.dart';

class LoadingModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((i) => LoadingController()),
      ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(Modular.initialRoute, child: (_, __) => LoadingPage())
  ];

  // static Inject get to => Inject<LoadingModule>.of();
}
