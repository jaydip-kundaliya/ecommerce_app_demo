import 'package:ecommerce_app_demo/models/product.dart';
import 'package:ecommerce_app_demo/services/local_preferences.dart';
import 'package:ecommerce_app_demo/ui/cart/cart_item_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final localPrefService = GetIt.I.get<LocalPrefService>();
  final List<Product> cartProducts = [];

  @override
  void initState() {
    super.initState();
    cartProducts.addAll(localPrefService.fetchCartItem());
    print(cartProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildCartProductList(),
    );
  }

  Widget buildCartProductList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ListView.separated(
        itemCount: cartProducts.length,
        itemBuilder: (context, index) => CartItemView(
          product: cartProducts[index],
        ),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: 10,
        ),
      ),
    );
  }
}
