import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:commune_app/generated/l10n.dart';
import 'package:commune_app/app/blocs/app_bloc.dart';
import 'package:commune_app/app/blocs/chat_bloc.dart';
import 'package:commune_app/app/app_module.dart';
import 'package:commune_app/app/shared/widgets/button_widget.dart';
import 'package:commune_app/app/shared/widgets/text_field_widget.dart';
import 'models/user/data_user.dart';
import 'widgets/item_peer.dart';
import 'widgets/item_user.dart';

import 'chat_controller.dart';

class ChatPage extends StatefulWidget {
  final String title;

  const ChatPage({Key? key, this.title = "Chat"}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends ModularState<ChatPage, ChatController> {

  // ChatBloc chat = AppModule.to.get<ChatBloc>();
  // AppBloc app = AppModule.to.get<AppBloc>();

  ChatBloc chat = Modular.get<ChatBloc>();
  AppBloc app = Modular.get<AppBloc>();
  var _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  onSendMessage() {
    if (_controller.text != "") {
      // chat.onSendMessage(_controller.text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(children: <Widget>[
          Expanded(
              child: StreamBuilder(
                initialData: [],
                //  stream: chat.getData,
                builder: (c, d) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: (d.data! as List).length,
                    itemBuilder: (c, i) {
                      var dl = d.data as List;
                      final DataUser item = dl[i];
                      /* ==============================================
                      if (chat.getDevice() == item.name) {
                        return ItemUser(item, key: Key("$i"),);
                      }
                      return ItemPeer(item, key: GlobalKey(debugLabel: "$i"),);
                       ============================================== */
                      return ItemPeer(item, key: GlobalKey(debugLabel: "$i"),);
                    }),
              )
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: TextFieldWidget(
                      controller: _controller,
                      maxLines: -1,
                      keyBoard: TextInputType.multiline,
                      style: TextStyle(color: Theme.of(context).textSelectionColor),
                      hint: S.current.enter_msg,
                    ),
                    color: Theme.of(context).bottomAppBarColor,
                  )),
              ButtonWidget(
                color: Theme.of(context).backgroundColor,
                padding: EdgeInsets.symmetric(vertical: 10),
                radius: 0,
                onPress: onSendMessage,
                child: Icon(Icons.send, color: Theme.of(context).textSelectionColor, size: 30,),)
            ],
          )
        ]));
  }
}
