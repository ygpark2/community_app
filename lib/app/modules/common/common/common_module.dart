import 'package:flutter_modular/flutter_modular.dart';
import 'package:commune_app/app/modules/common/core/network/dio_client.dart';

import 'services/opensearch_service.dart';
import 'styles/styles.dart';
import 'utils/utils.dart';


class CommonModule extends Module {

  @override
  List<Bind> get binds => [
    Bind((_) => ImageAssets(), export: true),
    Bind((_) => LocaleKeys(), export: true),
    Bind((_) => NamedRoutes(), export: true),
    Bind((_) => ColorPalettes(), export: true),
    Bind((i) => OpensearchService(Modular.get<DioClient>().dio), export: true),
  ];

  @override
  List<ModularRoute> get routes => [

  ];

}
