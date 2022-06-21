import 'package:flutter/foundation.dart';
import 'package:layout/layout.dart';
import 'package:commune_app/app/shared/models/theme/theme_data.dart';
import 'package:commune_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import './blocs/app_bloc.dart';
import 'app_module.dart';
import './shared/widgets/alert_widget.dart';
import './shared/widgets/loading_widget.dart';
import './shared/widgets/push_widget.dart';
import './modules/common/common/styles/themes.dart';


class AppWidget extends StatefulWidget {

  @override
  _AppWidget createState() => _AppWidget();

}

class _AppWidget extends State<AppWidget> {

  // AppBloc appBloc = AppModule.to.get<AppBloc>();
  AppBloc appBloc = Modular.get<AppBloc>();

  Widget renderMain(snapshot) => MaterialApp(
    debugShowCheckedModeBanner: false,
    // navigatorKey: Modular.navigatorKey,
    title: 'WebRTC Demo',
    theme: snapshot.hasData
        ? snapshot.data.themeData
        : getThemeMode(THEME_MODE.LIGHT).themeData,
    darkTheme: darkThemeData,
    builder: (context, child) => Stack(
      alignment: Alignment.center,
      children: [
        child!,
        LoadingWidget(),
        AlertWidget(),
        PushWidget()
      ],
    ),
    routerDelegate: Modular.routerDelegate,
    routeInformationParser: Modular.routeInformationParser,
    // onGenerateRoute: Modular.generateRoute,

    initialRoute: Modular.initialRoute,
    localizationsDelegates: [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
  ); // . .modular();

  @override
  Widget build(BuildContext context) {

    if (kIsWeb) {
      return Layout(
          child: StreamBuilder<ThemeModes>(
            stream: appBloc.getTheme,
            builder: (context, snapshot) {
              print("---------------------***********************************");
              print(snapshot.data);
              print(snapshot.hasData);
              // print(snapshot.data!.theme_mode);
              return DynamicColor(
                value: getColorTheme(snapshot.hasData
                    ? snapshot.data!.theme_mode
                    : THEME_MODE.LIGHT),
                child: renderMain(snapshot),
              );
            },
          )
      );
    } else {
      return StreamBuilder<ThemeModes>(
        stream: appBloc.getTheme,
        builder: (context, snapshot) {
          return DynamicColor(
            value: getColorTheme(snapshot.hasData
                ? snapshot.data!.theme_mode
                : THEME_MODE.LIGHT),
            child: renderMain(snapshot),
          );
        },
      );
    }

    return MaterialApp.router(
      title: 'My Smart App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    ); //added by extension

  }
}

