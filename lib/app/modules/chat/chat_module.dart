import 'chat_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'chat_page.dart';

class ChatModule extends Module {

  @override
  List<Bind> get binds => [
    Bind((i) => ChatController()),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(Modular.initialRoute, child: (_, __) => ChatPage())
  ];

  // static Inject get to => Inject<ChatModule>.of();
}
