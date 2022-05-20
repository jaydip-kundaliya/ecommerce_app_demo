import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/product.dart';
import '../utils/private_keys.dart';

class LocalPrefService {
  late SharedPreferences prefs;
  Future<void> initialPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> addProductToCart(Product product) async {
    final List<Product> products = fetchCartItem();
    final List<String> stringProducts = [];
    for (final item in products) {
      stringProducts.add(productToJson(item));
    }
    stringProducts.add(productToJson(product));
    await prefs.setStringList(
      LocalPrefKeys.cartProductsKey,
      stringProducts,
    );
  }

  List<Product> fetchCartItem() {
    final List<Product> products = [];
    final result = prefs.getStringList(
      LocalPrefKeys.cartProductsKey,
    );
    for (final item in result ?? []) {
      products.add(productFromJson(item));
    }
    log('All cart Items: ${result.toString()}');
    return products;
  }
}
