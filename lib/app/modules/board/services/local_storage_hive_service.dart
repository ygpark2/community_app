import 'package:commune_app/app/modules/board/interfaces/local_storage.dart';
import 'package:commune_app/app/modules/board/models/board_store.dart';
import 'package:commune_app/app/modules/board/repositories/local_storage/hive/hive_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
