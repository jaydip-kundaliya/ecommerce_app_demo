import 'package:ecommerce_app_demo/services/api_service.dart';

import '../models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    List<Product> productList = await ApiService().fetchProducts();
    return productList;
  }
}
