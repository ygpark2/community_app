import 'package:commune_app/app/blocs/app_bloc.dart';
import 'package:commune_app/app/modules/common/core/network/dio_client.dart';
import 'package:commune_app/app/modules/web_home/pages/home/widget/home_body.dart';

import 'repositories/local_storage/hive/hive_repository.dart';
import 'pages/create/create_controller.dart';
import 'pages/list/list_controller.dart';
import 'pages/home/home_controller.dart';
import './pages/create/create_page.dart';
import 'pages/list/list_page.dart';
import './pages/home/home_page.dart';
import './services/board_api_service.dart';
import 'services/local_storage_hive_service.dart';
import 'web_home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'web_home_routes.dart';


class WebHomeModule extends Module {

  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => AppBloc(i())),
        Bind((i) => CreateController(i.get())),
        Bind((i) => ListController(i.get())),
        Bind((i) => HomeController(i.get())),
        Bind((i) => HiveRepository()),
        Bind((i) => LocalStorageHiveService(i.get())),
        Bind((i) => BoardApiService(Modular.get<DioClient>().dio)),
        Bind((i) => WebHomeController()),
      ];

  @override
  List<ModularRoute> get routes => [
        // ModularRouter(LOGIN, child: (_, args) => LoginPage()),

        // ChildRoute(Modular.get<NamedRoutes>().home, child: (_, __) => HomePage()),
        // ModularRoute(HOME, child: (_, args) => HomePage()),

        ChildRoute(Modular.initialRoute, child: (context, args) => HomePage(title: 'home'),
            children: [
              ChildRoute('/home', child: (context, args) => HomeBody()),
              ChildRoute('/create', child: (context, args) => CreatePage(id: 13)),
              ChildRoute('/list', child: (context, args) => ListPage(title: 'page 3')),
              ChildRoute("/view/:id",
                  child: (_, args) => CreatePage(id: int.parse(args.params['id']))),
            ]
        ),

        // ChildRoute(Modular.initialRoute,
        //     child: (_, __) => HomePage(title: 'home')),

        // ChildRoute(Modular.initialRoute, child: (_, __) => ListPage()),

      ];

}
