import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../models/product.dart';
import '../../services/local_preferences.dart';
import '../../utils/app_text_style.dart';

class ProductItemView extends StatefulWidget {
  final Product product;
  const ProductItemView({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductItemView> createState() => _ProductItemViewState();
}

class _ProductItemViewState extends State<ProductItemView> {
  bool productInCart = false;

  @override
  void initState() {
    productInCart = productIsInCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      semanticContainer: true,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Image.network(
                widget.product.featuredImage!,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.product.title ?? '',
                    style: AppTextStyle.poppins(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _addProductToCart();
                  },
                  focusColor: Colors.transparent,
                  icon: Icon(
                    productInCart
                        ? Icons.shopping_cart
                        : Icons.shopping_cart_outlined,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addProductToCart() async {
    await GetIt.I.get<LocalPrefService>().addProductToCart(widget.product);
    setState(() {});
  }

  bool productIsInCart() {
    final localPrefService = GetIt.I.get<LocalPrefService>();
    List<Product> cartProducts = localPrefService.fetchCartItem();
    for (final product in cartProducts) {
      if (product.id == widget.product.id) {
        return true;
      }
    }
    return false;
  }

  @override
  void setState(VoidCallback fn) {
    productInCart = !productInCart;
    super.setState(fn);
  }
}
