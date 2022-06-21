import 'video_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'video_page.dart';

class VideoModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((i) => VideoController()),
      ];

  @override
  List<ModularRoute> get routers => [
    ChildRoute(Modular.initialRoute, child: (_, args) => VideoPage()),
      ];

  // static Inject get to => Inject<VideoModule>.of();
}
