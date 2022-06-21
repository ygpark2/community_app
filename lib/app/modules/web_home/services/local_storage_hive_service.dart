import 'package:flutter_modular/flutter_modular.dart';

import '../interfaces/local_storage.dart';
import '../models/board_store.dart';
import '../repositories/local_storage/hive/hive_repository.dart';


part 'local_storage_hive_service.g.dart';

@Injectable()
class LocalStorageHiveService extends Disposable implements ILocalStorage {
  
  HiveRepository hiveRepo;

  LocalStorageHiveService(this.hiveRepo);

  //dispose will be called automatically
  @override
  void dispose() {}

  @override
  Future delete(String keys) async {
    return await hiveRepo.delete(keys);
  }
  
  @override
  Future<List<BoardStore>> getAllBoards() async {
    return await hiveRepo.getAllBoards();
  }

  @override
  Future<BoardStore> getBoard(int key) async {
    return await hiveRepo.getBoard(key);
  }

  @override
  Future putBoard(int key, Map<String, dynamic> value) async {
    await hiveRepo.putBoard(key, value);
  }

  @override
  Future<int> getNextKey() async {
    int id = await hiveRepo.getLastKey();
    return id + 2;
  }
  
}
