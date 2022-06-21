import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './app/modules/common/core/core_module.dart';
import './app/modules/common/common/common_module.dart';
import './app/modules/common/core/network/api_constant.dart';
import './app/app_module.dart';
import './app/app_widget.dart';
import './bloc/ains_bloc_observer.dart';
import 'app_config.dart';

void main() async {
  // Bloc.observer = AinsBlocObserver();
  BlocOverrides.runZoned(
    () {
      // ...
    },
    blocObserver: AinsBlocObserver(),
    // eventTransformer: customEventTransformer(),
  );
  Config.appFlavor = Flavor.RELEASE;
  WidgetsFlutterBinding.ensureInitialized();
  /*
  final preferences = await SharedPreferences.getInstance();
  Modular.init(CoreModule(
      baseUrl: ApiConstant.baseUrlProd,
      wsBaseUrl: ApiConstant.wsBaseUrlProd,
      preferences: preferences));
  Modular.init(CommonModule());
   */
  // runApp(ModularApp(module: AppModule()));
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
