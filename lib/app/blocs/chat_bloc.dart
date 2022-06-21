import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:commune_app/generated/l10n.dart';
import 'package:commune_app/app/modules/chat/models/user/data_user.dart';
import 'package:commune_app/app/modules/common/core/network/socket.dart';
import 'package:commune_app/app/shared/tool/common.dart';

import 'app_bloc.dart';
import 'package:commune_app/app/app_module.dart';

class ChatBloc extends Disposable {
  final SocketCli socket;
  // AppBloc appBloc = AppModule.to.get<AppBloc>();
  AppBloc appBloc = Modular.get<AppBloc>();
  final data = BehaviorSubject<List<DataUser>>.seeded([]);

  ChatBloc(this.socket) {
    socket.listen(Common.EVENT.newmsg, onNewMsg);
    socket.listen(Common.EVENT.allData, onAllMsg);
    socket.listen(Common.EVENT.inComing, onInComming);
    socket.listen(Common.EVENT.onEndCall, onEndCall);
    socket.emit(Common.EVENT.getAllData);
  }

  String getDevice() {
    return appBloc.deviceName;
  }

  onNewMsg(data) {
    print("in data1 $data");
    setData([
      ...this.data.value!,
      ...[DataUser.fromJson(data)]
    ]);
  }

  onAllMsg(data) {
    List<DataUser> listUser = [];
    data.forEach((v) {
      listUser.add(DataUser.fromJson(v));
    });
    setData(listUser);
  }

  onInComming(data) {
    print("onInComming $data");
    appBloc.push(S.current.comming_title, S.current.in_comming(data), data);
  }

  onEndCall(_) {
    print("in end call");
    appBloc.resetPush();
  }
  
  onSendMessage(String message) {
    if (message != "") {
      Map<String, dynamic> params = Map<String, dynamic>();
      params['id'] = 1;
      params['name'] = getDevice();
      params['message'] = message;
      socket.emit(Common.EVENT.sendmsg, params);
    }
  }

  Function(List<DataUser>) get setData => data.sink.add;

  Stream<List<DataUser>> get getData => data.stream;

  @override
  void dispose() {
    data.close();
  }
}
