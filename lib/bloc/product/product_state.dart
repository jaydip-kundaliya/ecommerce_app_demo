part of 'product_bloc.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoadingState extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoadedState extends ProductState {
  final List<Product> products;

  ProductLoadedState({required this.products});

  @override
  List<Object> get props => [Product];
}

class ProductErrorState extends ProductState {
  final String message;

  ProductErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
