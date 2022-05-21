part of 'product_bloc.dart';

abstract class ProductEvent {}

class FetchProductEvents extends ProductEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
