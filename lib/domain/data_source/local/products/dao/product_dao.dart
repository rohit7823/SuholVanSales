import 'package:get/get.dart';
import 'package:objectbox/objectbox.dart';
import 'package:suhol_van_sales/data/utils/extensions.dart';
import 'package:suhol_van_sales/domain/data_source/local/products/entities/product_db.dart';
import 'package:suhol_van_sales/domain/di/database_service.dart';
import 'package:suhol_van_sales/domain/utils/extenstions.dart';
import 'package:suhol_van_sales/objectbox.g.dart';

import '../../../../models/product.dart';

mixin ProductDao {
  final Map<int, List<Product>> _productsCache = {};

  final byName = 1;

  final _dbInstance = Get.find<DatabaseService>().db;

  Box<ProductDB>? get _productDB => _dbInstance?.box<ProductDB>();

  int? get dataCount => _productDB?.count();

  Future<int?> insertProduct(Product product) async {
    var pDB = product.toDB;
    return _productDB?.putAsync(pDB);
  }

  Future<bool?> insertAllProducts(List<Product> products) async {
    var isSuccess = await _dbInstance?.runInTransactionAsync(TxMode.write,
        (store, products) {
      var tmp = products
          .map(
            (e) => e.toDB,
          )
          .toList();
      var db = store.box<ProductDB>();
      var ids = db.putMany(tmp);
      return ids.every((id) => id != 0);
    }, products);
    return isSuccess;
  }

  Future<List<Product>?> getAllProducts(String nameQuery) async {
    return await _productDB
        ?.getAllAsync()
        .then((value) => value.map((e) => e.toData).toList());
  }
}
