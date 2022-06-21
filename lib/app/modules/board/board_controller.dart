import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'models/board_store.dart';

part 'board_controller.g.dart';

@Injectable()
class BoardController = _BoardControllerBase with _$BoardController;

abstract class _BoardControllerBase with Store {
  
  @observable
  ObservableList<BoardStore> boards = <BoardStore>[].asObservable();

  _BoardControllerBase();

  @action
  BoardStore getBoard(int id){
    return boards.firstWhere((element) => element.id == id, orElse: () => BoardStore(items: []));
  }
}
