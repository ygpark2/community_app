import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'chat_controller.g.dart';

@Injectable()
class ChatController = _ChatControllerBase with _$ChatController;

abstract class _ChatControllerBase with Store implements Disposable {
  final pageController = PageController();

  @override
  void dispose(){
    pageController.dispose();
  }
}
