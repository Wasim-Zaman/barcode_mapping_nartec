// ignore_for_file: avoid_print, file_names

import 'dart:convert';

import 'package:barcode_mapping/core/constants/app_preferences.dart';
import 'package:barcode_mapping/core/constants/app_urls.dart';
import 'package:barcode_mapping/models/reveiving/supplier_receipt/GetTblStockMasterByItemIdModel.dart';
import 'package:http/http.dart' as http;

class GetTblStockMasterByItemIdController {
  static Future<List<GetTblStockMasterByItemIdModel>> getData(
      String itemId) async {
    String? tokenNew;
    await AppPreferences.getToken().then((value) => tokenNew = value);

    String url =
        "${AppUrls.baseUrlWithPort}getTblStockMasterByItemId?itemid=$itemId";

    final uri = Uri.parse(url);

    final headers = <String, String>{
      "Authorization": tokenNew!,
      "Host": AppUrls.host,
      "Accept": "application/json",
    };

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        print("Status Code: ${response.statusCode}");

        var data = json.decode(response.body) as List;
        List<GetTblStockMasterByItemIdModel> shipmentData = data
            .map((e) => GetTblStockMasterByItemIdModel.fromJson(e))
            .toList();
        return shipmentData;
      } else {
        print("Status Code: ${response.statusCode}");
        var data = json.decode(response.body);
        var msg = data['message'];
        throw Exception(msg);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
