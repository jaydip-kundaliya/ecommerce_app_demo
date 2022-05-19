import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_app_demo/models/product.dart';

import '../utils/private_keys.dart';

class ApiService {
  Dio _apiService = Dio();

  ApiService() {
    final base = BaseOptions(
      baseUrl: ApiKeys.ecommerceBaseApi,
      connectTimeout: 5000,
    );
    _apiService = Dio(base);
  }

  Future<List<Product>> fetchProducts() async {
    final List<Product> products = [];
    final response = await _apiService.get(ApiKeys.productListEndPoint);
    if (response.statusCode == 200) {
      var data = json.decode(response.data);
      for (final result in data.length) {
        products.add(Product.fromJson(result));
      }
      return products;
    } else {
      throw Exception();
    }
  }
}
