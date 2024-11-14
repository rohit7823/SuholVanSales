import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:suhol_van_sales/domain/data_source/remote/products/response/products_response.dart';

import '../../../utils/static_data.dart';

typedef ProductsJson = Map<String, dynamic>;

class StaticProducts {
  StaticProducts._();

  static Future<ProductsResponse?> getData() async {
    try {
      var jsonStr = await rootBundle
          .loadString(StaticData.productsWithPackingAndUnitJSON);
      var productsJson = json.decode(jsonStr) as ProductsJson;
      if (productsJson.isNotEmpty) {
        log("productsJson $productsJson");
        return await compute(deserializeProductsResponse, productsJson);
      }
      return null;
    } catch (e) {
      debugPrint("exception ${e.toString()}");
      return null;
    }
  }
}
