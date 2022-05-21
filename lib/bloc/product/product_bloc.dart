import 'package:ecommerce_app_demo/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product.dart';

part 'product_state.dart';
part 'product_event.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitialState()) {
    on<ProductEvent>((event, emit) async {
      try {
        emit(ProductInitialState());
        final mList = await ProductRepositoryImpl().getProducts();
        emit(ProductLoadedState(products: mList));
      } catch (e) {
        print(e);
      }
    });
  }
}
