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

  Future<void> deleteProductToCart(Product product) async {
    final List<Product> products = fetchCartItem();
    final List<String> stringProducts = [];
    for (final item in products) {
      if (item.id != product.id) {
        stringProducts.add(productToJson(item));
      }
    }
    await prefs.setStringList(
      LocalPrefKeys.cartProductsKey,
      stringProducts,
    );
  }

  List<Product> fetchCartItem() {
    final List<Product> products = [];
    final List<String>? result = prefs.getStringList(
      LocalPrefKeys.cartProductsKey,
    );

    if (result != null) {
      final List<Product> resultList =
          result.map((e) => productFromJson(e)).toList();
      for (int index = 0; index < resultList.length; index++) {
        final productCatch = resultList[index];
        if (!_isDuplicate(products, productCatch)) {
          products.add(productCatch);
        } else {
          final newProduct = productCatch.updateQuatity(productCatch.quatity);
          products[index - 1] = newProduct;
        }
      }
    }
    log('All cart Items: ${products.toString()}');
    return products;
  }

  bool _isDuplicate(List<Product> products, Product indexProduct) {
    for (int index = 0; index < products.length; index++) {
      if (products[index].id == indexProduct.id) {
        return true;
      }
    }
    return false;
  }
}
