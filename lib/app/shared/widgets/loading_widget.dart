import 'package:flutter_modular/flutter_modular.dart';
import 'package:commune_app/app/modules/common/common/styles/color_palettes.dart';
import 'package:flutter/material.dart';

import 'package:commune_app/app/blocs/app_bloc.dart';
import 'package:commune_app/app/app_module.dart';

class LoadingWidget extends StatefulWidget {
  @override
  StateLoadingWidget createState() => StateLoadingWidget();
}

class StateLoadingWidget extends State<LoadingWidget> {
  late AppBloc app;
  @override
  void initState() {
    // app = AppModule.to.get<AppBloc>();
    app = Modular.get<AppBloc>();
    super.initState();
  }
  Widget renderLoading() => Scaffold(
    backgroundColor: Color.fromRGBO(0, 0, 0, 0.6),
    body: Center(
       child: CircularProgressIndicator(
         backgroundColor: Colors.red,
         valueColor: AlwaysStoppedAnimation<Color>(Modular.get<ColorPalettes>().grey),
       ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: app.getLoad,
      builder: (context, value) {
        return value.data != null && value.data! ? renderLoading() : Container();
      },
    );
  }
}
