import 'package:ecommerce_app_demo/bloc/product/product_event.dart';
import 'package:ecommerce_app_demo/bloc/product/product_state.dart';
import 'package:ecommerce_app_demo/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({
    required this.repository,
  }) : super(ProductInitialState()) {
    on<ProductEvent>((event, emit) async {
      try {
        emit(ProductInitialState());
        final mList = await ProductRepositoryImpl().getProducts();
        emit(ProductLoadedState(products: mList));
      } catch (e) {}
    });
  }
}
