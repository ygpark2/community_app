// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_home_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $WebHomeController = BindInject(
  (i) => WebHomeController(),
  isSingleton: true,
  isLazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WebHomeController on _WebHomeControllerBase, Store {
  final _$boardsAtom = Atom(name: '_WebHomeControllerBase.boards');

  @override
  ObservableList<BoardStore> get boards {
    _$boardsAtom.reportRead();
    return super.boards;
  }

  @override
  set boards(ObservableList<BoardStore> value) {
    _$boardsAtom.reportWrite(value, super.boards, () {
      super.boards = value;
    });
  }

  final _$_WebHomeControllerBaseActionController =
      ActionController(name: '_WebHomeControllerBase');

  @override
  BoardStore getBoard(int id) {
    final _$actionInfo = _$_WebHomeControllerBaseActionController.startAction(
        name: '_WebHomeControllerBase.getBoard');
    try {
      return super.getBoard(id);
    } finally {
      _$_WebHomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
boards: ${boards}
    ''';
  }
}
