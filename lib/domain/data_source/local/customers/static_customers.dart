import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:suhol_van_sales/domain/models/customer_details.dart';
import 'package:suhol_van_sales/domain/utils/static_data.dart';

typedef CustomersJson = Map<String, dynamic>;

class StaticCustomers {
  StaticCustomers._();

  static Future<CustomerDetails?> getData() async {
    try {
      var jsonStr = await rootBundle.loadString(StaticData.customersWithLocationsJSON);
      var customersJson = json.decode(jsonStr) as Map<String, dynamic>;
      if (customersJson.isNotEmpty) {
        return await compute(customerDetailsFromJson, customersJson);
      }
      return null;
    } catch(e) {
      debugPrint("exception ${e.toString()}");
      return null;
    }


  }
}
