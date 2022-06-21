import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:commune_app/app/app_widget.dart';

import 'package:commune_app/app/blocs/app_bloc.dart';
import 'package:commune_app/app/modules/board/board_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/board/board_module.dart';
import 'modules/common/common/common_module.dart';
import 'modules/common/core/core_module.dart';
import 'modules/common/core/network/api_constant.dart';
import 'modules/home/home_module.dart';
import 'modules/loading/loading_module.dart';
import 'app_controller.dart';
import 'modules/common/common/utils/named_routes.dart';
import 'modules/web_home/web_home_module.dart';

class AppModule extends Module {

  // final preferences = await SharedPreferences.getInstance();

  @override
  List<Module> get imports => [
    CoreModule(
      baseUrl: ApiConstant.baseUrlDebug,
      wsBaseUrl: ApiConstant.wsBaseUrlDebug
    ),
    CommonModule()
  ];

  @override
  List<Bind> get binds => [
        Bind.factory((i) => AppController()),
        Bind.lazySingleton((i) => AppBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
    // ModuleRoute(Modular.initialRoute, module: LoadingModule()),
    ModuleRoute(Modular.initialRoute, module: WebHomeModule()),
    // ModuleRoute(Modular.get<NamedRoutes>().webHomePage, module: WebHomeModule()),
    // ModuleRoute(Modular.get<NamedRoutes>().homePage, module: HomeModule()),
  ];

  // static Inject get to => Inject<AppModule>();
}
