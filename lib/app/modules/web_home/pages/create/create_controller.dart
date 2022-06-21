import 'dart:math';

import 'package:commune_app/app/modules/web_home/interfaces/local_storage.dart';
import 'package:commune_app/app/modules/web_home/models/board_item_store.dart';
import 'package:commune_app/app/modules/web_home/models/board_store.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../web_home_controller.dart';

part 'create_controller.g.dart';

@Injectable()
class CreateController = _CreateControllerBase with _$CreateController;

abstract class _CreateControllerBase with Store {
  
  final ILocalStorage _storage = Modular.get();
  late final WebHomeController webHomeController;
  final Random random = new Random();

  _CreateControllerBase(this.webHomeController) {

    // _init();

  }

  _init() async {
    // idNewBoard = await _storage.getNextKey();
    // setIdNewBoard(id);

    /*
    newBoard = BoardStore(id: 0, title: "title", amount: 10, qtItems: 30, selected: false, items: [new BoardItemStore(
        id: random.nextInt(1000000),
        name: null,
        qt: '1',
        value: '0.00',
        error: ''
    )]);
     */
    // setNewBoard(boardStore);

  }

  @observable
  BoardStore newBoard = BoardStore(id: 0, title: "title", amount: 10, qtItems: 30, selected: false, items: [
    /*
    new BoardItemStore(
      id: random.nextInt(1000000),
      name: null,
      qt: '1',
      value: '0.00',
      error: ''
    )
     */
  ]);

  @observable
  int idNewBoard = 239843;

  @observable
  bool erroTitle = false;

  @observable
  bool erroItems = false;

  @observable
  String msgErroItems = 'Deve haver ao menos um item.';

  @observable
  double amount = 0.0;

  @observable
  int qtItems = 0;

  @action
  void setNewBoard(BoardStore value) => newBoard = value;

  @action
  void setIdNewBoard(int value) => idNewBoard = value;

  @action
  void setErroTitle(bool value) => erroTitle = value;

  @action
  void setErroItems(bool value) => erroItems = value;

  @action
  void setMsgErroItems(String value) => msgErroItems = value;

  @action
  addItem() {
    // items = List.of<BoardItemStore>();
    newBoard = BoardStore(items: [new BoardItemStore(
        id: random.nextInt(1000000),
        name: null,
        qt: '1',
        value: '0.00',
        error: ''
    )]);

    setQtItems();
  }

  @action
  void setAmount() {
    amount = getDoubleTwoPrecision(
      newBoard.items.fold(0, 
        (prev, item) => int.parse(prev.toString()) + (int.parse(item.qt!) * double.parse(item.value!))
      ).toString()
    );

    setQtItems();
  }

  @action
  void setQtItems() {
    qtItems = newBoard.items.fold(0,
      (prev, item) => prev + int.parse(item.qt!)
    );
  }

  /// 
  /// Obtem o valor para o campo com duas casas decimais
  /// 
  double getDoubleTwoPrecision(String value){
    return double.parse(double.parse(value).toStringAsFixed(2));
  }

  /// 
  /// Obtem o valor para o campo com duas casas decimais
  /// 
  String getTwoPrecision(String value) {
    return (value != null) ? double.parse(value).toStringAsFixed(2) : "0.0";
  }

  @action
  Future createBoard(BoardStore boardStore) async {
    BoardStore newBoard = prepareBoardCreateOrUpdate(boardStore);

    webHomeController.boards.insert(0, newBoard);
    await _storage.putBoard(newBoard.id!, newBoard.toJson());
  }

  @action
  Future updateBoard(BoardStore boardStore) async {
    BoardStore newBoard = prepareBoardCreateOrUpdate(boardStore);
    
    for (var i = 0; i < webHomeController.boards.length; i++) {
      if (webHomeController.boards[i].id == newBoard.id) {
        webHomeController.boards[i] = newBoard;
      }
    }

    // atualiza no banco
    _storage.putBoard(newBoard.id!, newBoard.toJson());
  }

  ///
  /// Prepara a entidade antes de salvar ou atualziar
  ///
  BoardStore prepareBoardCreateOrUpdate(BoardStore boardStore) {
    BoardStore newBoard = BoardStore.fromJson(boardStore.toJson());

    newBoard.amount = amount;
    newBoard.qtItems = qtItems;
    newBoard.selected = false;
    newBoard.items = newBoard.items.map((item) {
      item.name = item.name!.trim();
      item.error = '';
      item.value = getTwoPrecision(item.value!);

      return item;
    }).toList().asObservable();

    return newBoard;
  }

  ///
  /// Prepara a entidade antes de salvar ou atualziar
  ///
  void prepareBoardToEdit(BoardStore boardStore) {
    BoardStore editBoard = BoardStore.fromJson(boardStore.toJson());
    setNewBoard(editBoard);
    setAmount();
  }

  bool boardIsValid() {
    bool validName = validateTitle();
    bool validItems = validateAllItems();

    if (validName && validItems) {
      return true;
    }

    return false;
  }

  bool validateTitle(){
    newBoard.title = newBoard.title == null ? "" : newBoard.title!.trim();

    if (newBoard.title == null || newBoard.title!.isEmpty) {
      setErroTitle(true);
      return false;
    }
    
    setErroTitle(false);
    return true;
  }

  bool validateAllItems(){
    bool valid = true;

    newBoard.items = newBoard.items.map((item) {
      bool name = (
        item.name != null && item.name!.isNotEmpty && item.name!.trim().length > 0);
      bool qt = (int.parse(item.qt!) != 0);

      if (!name || !qt) {
        item.error =
          "${name ? '' : 'name'}:${qt ? '' : 'qt'}";

        valid = false;
      } else {
        item.error = '';
      }

      return item;
    }).toList().asObservable();

    if (!valid) {
      setMsgErroItems('Há item invalido.');
    }
    
    if (newBoard.items.length == 0) {
      setMsgErroItems('Deve haver ao menos um item.');
    }

    if (!valid || (newBoard.items.length == 0)) {
      setErroItems(true);
      return false;
    }

    setErroItems(false);
    return true;
  }
}
