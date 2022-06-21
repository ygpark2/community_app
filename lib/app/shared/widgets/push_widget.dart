import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:commune_app/app/modules/chat/models/push/data_push.dart';
import 'package:commune_app/app/modules/common/common/utils/named_routes.dart';
import 'package:commune_app/app/shared/widgets/button_widget.dart';
import 'package:commune_app/app/shared/widgets/text_widget.dart';
import 'package:commune_app/generated/l10n.dart';

import 'package:commune_app/app/blocs/app_bloc.dart';
import 'package:commune_app/app/app_module.dart';

class PushWidget extends StatefulWidget {
  @override
  StatePushWidget createState() => StatePushWidget();
}

class StatePushWidget extends State<PushWidget> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animationPush;
  late AppBloc app;

  @override
  void initState() {
    super.initState();
    // app = AppModule.to.get<AppBloc>();
    app = Modular.get<AppBloc>();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animationPush =
        Tween(begin: -100.0, end: 0.0).animate(animationController);
    app.getPush.listen((event) {
      if (event != null) {
        animationController.forward();
      } else {
        animationController.reverse();

      }
    });
  }

  onPress() {
    Map<String, dynamic> params = new Map<String, dynamic>();
    app.dataPush.done.then((value) {
      params["name"] = value.title;
      params["isAnswer"] = true;
    });

    app.resetPush();
    Modular.to.pushNamed(Modular.get<NamedRoutes>().video, arguments: params);
  }

  Widget renderMessage() => Positioned(
    top: animationPush.value,
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ButtonWidget(
        radius: 0,
        padding: EdgeInsets.only(top: 36, bottom: 18, left: 10, right: 10),
        color: Colors.green,
        onPress: onPress,
        side: BorderSide(),
        text: '',
        loading: true,
        textStyle: TextStyle(color: Colors.white),
        child: Align(
          alignment: Alignment.topLeft,
          child: StreamBuilder<DataPush>(
            stream: app.getPush,
            builder: (c, v) => Row(
              children: [
                Icon(Icons.phone, size: 30,),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(v.data?.title ?? S.current.comming_title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 6,),
                    TextWidget(v.data?.message ?? '', style: TextStyle(color: Colors.white))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (c, v) => renderMessage(),
    );
  }
}
