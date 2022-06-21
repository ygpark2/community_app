// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $BoardController = BindInject(
  (i) => BoardController(),
  isSingleton: true,
  isLazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BoardController on _BoardControllerBase, Store {
  final _$boardsAtom = Atom(name: '_BoardControllerBase.boards');

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

  final _$_BoardControllerBaseActionController =
      ActionController(name: '_BoardControllerBase');

  @override
  BoardStore getBoard(int id) {
    final _$actionInfo = _$_BoardControllerBaseActionController.startAction(
        name: '_BoardControllerBase.getBoard');
    try {
      return super.getBoard(id);
    } finally {
      _$_BoardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
boards: ${boards}
    ''';
  }
}
