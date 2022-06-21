import 'package:commune_app/app/modules/web_home/pages/create/create_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

const String ROOT = "/";
const String BOARD = "/board";
const String CREATE = "/create";
const String LIST = "/list";

const String BOARD_LIST  = "$BOARD$LIST";
const String BOARD_CREATE  = "$BOARD$CREATE";

var web_home_routes = [
  // ModularRouter(LOGIN, child: (_, args) => LoginPage()),

  // ChildRoute(Modular.get<NamedRoutes>().home, child: (_, __) => HomePage()),
  // ModularRoute(HOME, child: (_, args) => HomePage()),

  ChildRoute(Modular.initialRoute, child: (_, __) => CreatePage()),

  /// 
  /// Criação de senha
  /// 
  // ChildRoute(CREATE, child: (_, __) => CreatePage()),

  /// 
  /// Alteração de compra
  /// 
  /// :id -> id da senha
  ///

  /*
  ChildRoute(
    "$CREATE/:id",
    child: (_, args) => CreatePage(
      id: int.parse(args.params['id'])
    )
  ),
   */

];