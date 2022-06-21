import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

part 'video_controller.g.dart';


@Injectable()
class VideoController = _VideoControllerBase with _$VideoController;

abstract class _VideoControllerBase with Store implements Disposable {
  final pageController = PageController();

  @override
  void dispose(){
    pageController.dispose();
  }
}
