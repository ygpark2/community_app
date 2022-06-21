import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'loading_controller.g.dart';

@Injectable()
class LoadingController = _LoadingControllerBase with _$LoadingController;

abstract class _LoadingControllerBase with Store implements Disposable {
  final pageController = PageController();

  @override
  void dispose(){
    pageController.dispose();
  }
}
