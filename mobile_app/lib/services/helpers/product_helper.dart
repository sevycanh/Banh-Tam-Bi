import 'package:http/http.dart' as http;
import 'package:mobile_app/models/response/products/products_res.dart';
import 'package:mobile_app/services/config.dart';

class ProductHelper {
  static var client = http.Client();

  static Future<List<ProductResponse>> getMainDish(
      int categoryId, int page) async {
    String? route;
    if (categoryId == 1) {
      route = "mon-chinh";
    } else if (categoryId == 2) {
      route = "mon-phu";
    } else {
      route = "nuoc-uong";
    }
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.http(Config.apiUrl, "${Config.productsUrl}/$route",
        {"page": page.toString()});
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var productsList = productResponseFromJson(response.body);
      return productsList;
    } else {
      throw Exception("Lỗi lấy sản phẩm");
    }
  }

  static Future<List<ProductResponse>> searchProducts(
      String key, int page) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.http(Config.apiUrl, "${Config.productsUrl}/search/$key",
        {"page": page.toString()});
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var productsList = productResponseFromJson(response.body);
      return productsList;
    } else {
      throw Exception("Lỗi tìm sản phẩm");
    }
  }
}
