import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'models/board_store.dart';

part 'web_home_controller.g.dart';


@Injectable()
class WebHomeController = _WebHomeControllerBase with _$WebHomeController;

abstract class _WebHomeControllerBase with Store {
  
  @observable
  ObservableList<BoardStore> boards = <BoardStore>[].asObservable();

  _WebHomeControllerBase();

  @action
  BoardStore getBoard(int id){
    return boards.firstWhere((element) => element.id == id, orElse: () => BoardStore(items: []));
  }
}
