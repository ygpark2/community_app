import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:commune_app/app/modules/board/board_routes.dart';
import 'package:commune_app/app/modules/common/common/utils/named_routes.dart';
// import 'package:commune_app/app/shared/common/common_module.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../blocs/app_bloc.dart';
import '../../app_module.dart';

class LoadingPage extends StatefulWidget {
  final String title;

  const LoadingPage({Key? key, this.title = "Loading"}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  // AppBloc appBloc = AppModule.to.get<AppBloc>();
  AppBloc appBloc = Modular.get<AppBloc>();

  @override
  void initState() {
    super.initState();
    remember();
    Modular.to.pushReplacementNamed(Modular.get<NamedRoutes>().webHomePage);
  }

  remember() async {
    if (kIsWeb) {

    } else {
      String? deviceData;
      try {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        if (Platform.isAndroid) {
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          deviceData = androidInfo.model;
        } else if (Platform.isIOS) {
          final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
          deviceData = iosInfo.name;
        } else if (Platform.isLinux) {
          deviceData = "linux";
        } else if (Platform.isMacOS) {
          deviceData = "mac";
        } else if (Platform.isWindows) {
          deviceData = "windows";
        } else {
          deviceData = "web";
        }
        // 소켓 연결이 자동으로 됨 그래서 주석 처리
        // appBloc.setDeviceName(deviceData);
      } on PlatformException {}
      // Move to home page
      print("================= move home page =======================");
      // Modular.to.pushNamed(Modular.get<NamedRoutes>().home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
        ),
      ),
    );
  }
}
