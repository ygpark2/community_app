import 'dart:async';
import 'dart:convert';

import 'package:commune_app/app/modules/web_home/models/board_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

part 'hive_repository.g.dart';


@Injectable()
class HiveRepository extends Disposable {
  
  Completer<Box> _boxBoards = Completer<Box>();
  Completer<Box> _boxIds = Completer<Box>();

  HiveRepository() {
    _init();
  }

  _init() async {
    if (kIsWeb) {
      // Set web-specific directory
    } else {
      // appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
      var dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
    }

    var openBoxBoards = await Hive.openBox('db_boards');
    var openBoxIds = await Hive.openBox('boards_next_id');

    _boxBoards.complete(openBoxBoards);
    _boxIds.complete(openBoxIds);
  }

  @override
  void dispose() {
    Hive.close();
  }

  Future<List<BoardStore>> getAllBoards() async {
    var box = await _boxBoards.future;
    
    if (box.values.isEmpty) {
      return [];
    }

    try {
      var lists = List.generate(box.values.toList().length, (i) {
        return BoardStore.fromJson(jsonDecode(box.values.toList()[i]));
      });

      return List.from(lists.reversed);
    } catch (e) {
      print(e);
    } 

    return [];
  }

  Future<BoardStore> getBoard(int key) async {
    var box = await _boxBoards.future;

    if (box.get('shopp_$key') == null) {
      return BoardStore(items: []);
    }

    try {
      return BoardStore.fromJson(
        jsonDecode(box.get('shopp_$key'))
      );      
    } catch (e) {
      print(e);
    }
    
    return BoardStore(items: []);
  }

  Future putBoard(int key, Map<String, dynamic> value) async {
    var box = await _boxBoards.future;
    box.put('shopp_$key', jsonEncode(value));
    putLastKey(key);
  }

  Future delete(String keys) async {

    List<int> arrKeys = keys.split(',').map((key) => int.parse(key)).toList();

    if (arrKeys.length == 0) {
      return null;
    }

    var box = await _boxBoards.future;

    for (var i = 0; i <= arrKeys.length - 1; i++) {
      int key = arrKeys[i];
      box.delete('shopp_$key');
    }
  }

  Future<int> getLastKey() async {
    var box = await _boxIds.future;
    
    if (box.get('last_key') == null) {
      return 0;
    }

    return box.get('last_key') as int;
  }

  Future putLastKey(int key) async {
    var boxIds = await _boxIds.future;
    boxIds.put('last_key', key);
  }
}
