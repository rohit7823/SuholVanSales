import 'package:get/get.dart';
import 'package:objectbox/objectbox.dart';

class DatabaseService extends GetxService {
  Store? _dbInstance;

  Store? get db => _dbInstance;

  Future<DatabaseService> init() async {
    //_dbInstance = await create();
    return this;
  }

  // Future<Store> create() async {
  //   final docsDir = await getApplicationDocumentsDirectory();
  //   return await openStore(directory: p.join(docsDir.path, "suhol-sales-db"));
  // }

  @override
  void onClose() {
    _dbInstance?.close();
    _dbInstance = null;
    super.onClose();
  }
}
