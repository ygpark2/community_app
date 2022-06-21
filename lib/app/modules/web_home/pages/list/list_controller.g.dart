// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $ListController = BindInject(
  (i) => ListController(i<WebHomeController>()),
  isSingleton: true,
  isLazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListController on _ListControllerBase, Store {
  final _$listBoardToDeleteAtom =
      Atom(name: '_ListControllerBase.listBoardToDelete');

  @override
  ObservableList<int> get listBoardToDelete {
    _$listBoardToDeleteAtom.reportRead();
    return super.listBoardToDelete;
  }

  @override
  set listBoardToDelete(ObservableList<int> value) {
    _$listBoardToDeleteAtom.reportWrite(value, super.listBoardToDelete, () {
      super.listBoardToDelete = value;
    });
  }

  final _$isDeleteAtom = Atom(name: '_ListControllerBase.isDelete');

  @override
  bool get isDelete {
    _$isDeleteAtom.reportRead();
    return super.isDelete;
  }

  @override
  set isDelete(bool value) {
    _$isDeleteAtom.reportWrite(value, super.isDelete, () {
      super.isDelete = value;
    });
  }

  final _$deletePasswordsSelectedsAsyncAction =
      AsyncAction('_ListControllerBase.deletePasswordsSelecteds');

  @override
  Future<dynamic> deletePasswordsSelecteds() {
    return _$deletePasswordsSelectedsAsyncAction
        .run(() => super.deletePasswordsSelecteds());
  }

  final _$_ListControllerBaseActionController =
      ActionController(name: '_ListControllerBase');

  @override
  void setIsDelete(bool value) {
    final _$actionInfo = _$_ListControllerBaseActionController.startAction(
        name: '_ListControllerBase.setIsDelete');
    try {
      return super.setIsDelete(value);
    } finally {
      _$_ListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectToDelete(int idPass) {
    final _$actionInfo = _$_ListControllerBaseActionController.startAction(
        name: '_ListControllerBase.selectToDelete');
    try {
      return super.selectToDelete(idPass);
    } finally {
      _$_ListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeToDelete(int idPass) {
    final _$actionInfo = _$_ListControllerBaseActionController.startAction(
        name: '_ListControllerBase.removeToDelete');
    try {
      return super.removeToDelete(idPass);
    } finally {
      _$_ListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listBoardToDelete: ${listBoardToDelete},
isDelete: ${isDelete}
    ''';
  }
}
