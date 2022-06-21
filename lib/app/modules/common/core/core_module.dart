import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'local/shared_pref_helper.dart';
import 'network/dio_client.dart';
import 'network/socket.dart';

class CoreModule extends Module {
  final String baseUrl;
  final String wsBaseUrl;
  late final SharedPreferences preferences;
  late final String rootCaData;

  CoreModule({required this.baseUrl, required this.wsBaseUrl}) {
    SharedPreferences.getInstance().then((value) => preferences = value);
    // preferences = SharedPreferences.getInstance() as SharedPreferences;
    getRootCa().then((value) => rootCaData = value);
  }

  @override
  List<Bind> get binds => [
        // Bind((_) => preferences),
        Bind((_) => SharedPrefHelper(preferences: this.preferences), export: true),
        // Bind((_) => Modular.get<DioClient>().dio),
        Bind((_) => DioClient(
            rootCaData: rootCaData,
            apiBaseUrl: baseUrl,
            sharedPrefHelper: Modular.get<SharedPrefHelper>()), export: true),
        // Bind((_) => SharedPreferences.getInstance()),
        Bind((i) => SocketCli(wsBaseUrl), export: true),
      ];

  @override
  List<ModularRoute> get routes => [];

  Future<String> getRootCa() async {
    return await rootBundle.loadString("root-ca.pem");
  }
}
