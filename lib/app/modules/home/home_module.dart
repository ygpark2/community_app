import 'package:commune_app/app/modules/common/common/utils/named_routes.dart';

import 'home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

class HomeModule extends Module {

  @override
  List<Bind> get binds => [
    Bind((i) => HomeController()),
      ];

/*
  @override
  List<Bind> get binds => [
    Bind.singleton((i) => baseContent),
    Bind((i) => HomeController(i.args.data)),
    Bind((i) => NewsController()),
    Bind((i) => FeedController(),),
    Bind((i) => ProfileController(),),
    Bind((i) => NewPostController(i.args.data),)
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
        "/",
        child: (_, args) => HomePage(),
        children: [
          ChildRoute('/feed', child: (_, __) => FeedPage()),
          ChildRoute('/news', child: (_, __) => NewsPage()),
          ChildRoute('/profile', child: (_, __) => ProfilePage()),
        ]
    ),
    ChildRoute('/new_post', child: (_, __) => NewPostPage()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildModule(
      '/start',
      child: (context, args) => StartPage(),
      children: [
        ChildModule('/home', child: (_, __) => HomePage()),
        ChildModule('/product', child: (_, __) => ProductPage()),
        ChildModule('/config', child: (_, __) => ConfigPage()),
      ],
    ),
  ];
*/
  @override
  List<ModularRoute> get routes => [
    ChildRoute(Modular.initialRoute, child: (_, __) => HomePage()),
  ];

  // static Inject get to => Inject<HomeModule>.of();
}
