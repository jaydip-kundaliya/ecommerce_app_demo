import 'package:ecommerce_app_demo/services/api_service.dart';
import 'package:get_it/get_it.dart';

import '../models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}

class ProductRepositoryImpl extends ProductRepository {
  final apiService = GetIt.I.get<ApiService>();
  @override
  Future<List<Product>> getProducts() async {
    List<Product> productList = await apiService.fetchProducts();
    return productList;
  }
}
