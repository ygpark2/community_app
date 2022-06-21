import 'package:commune_app/app/modules/board/pages/create/create_page.dart';
import 'package:commune_app/app/modules/board/pages/list/list_page.dart';
import 'package:commune_app/app/modules/board/services/board_api_service.dart';
import 'package:commune_app/app/modules/common/core/network/dio_client.dart';

import 'services/local_storage_hive_service.dart';
import 'repositories/local_storage/hive/hive_repository.dart';
import 'pages/create/create_controller.dart';
import 'pages/list/list_controller.dart';
import 'board_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'board_routes.dart';

class BoardModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => CreateController(i.get())),
        Bind((i) => ListController(i.get())),
        Bind((i) => HiveRepository()),
        Bind((i) => LocalStorageHiveService(i.get())),
        Bind((i) => BoardApiService(Modular.get<DioClient>().dio)),
        Bind((i) => BoardController()),
      ];

  @override
  List<ModularRoute> get routes => [
        // ModularRouter(LOGIN, child: (_, args) => LoginPage()),

        // ChildRoute(Modular.get<NamedRoutes>().home, child: (_, __) => HomePage()),
        // ModularRoute(HOME, child: (_, args) => HomePage()),

        ChildRoute(Modular.initialRoute, child: (_, __) => ListPage()),

        ///
        /// Criação de senha
        ///
        ChildRoute(CREATE, child: (_, __) => CreatePage()),

        ///
        /// Alteração de compra
        ///
        /// :id -> id da senha
        ///

        ChildRoute("$CREATE/:id",
            child: (_, args) => CreatePage(id: int.parse(args.params['id']))),
      ];

  // static Inject get to => Inject<ShoppingModule>.of();
}
