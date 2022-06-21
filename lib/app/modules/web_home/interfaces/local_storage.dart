import 'package:commune_app/app/modules/web_home/models/board_store.dart';

abstract class ILocalStorage {
  Future<List<BoardStore>> getAllBoards();
  Future<BoardStore> getBoard(int key);
  Future putBoard(int key, Map<String, dynamic> value);
  Future delete(String keys);
  Future<int> getNextKey();
}