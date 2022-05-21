import 'package:ecommerce_app_demo/ui/product/products_view.dart';
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
  int productQuatity = 0;

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
                    _enableQuantitySheet(context).then(
                      (value) => setState(() {}),
                    );
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

  Future<void> _enableQuantitySheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.product.title ?? '',
                      style: AppTextStyle.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await _removeProductFromCart();
                      productInCart = productIsInCart();
                    },
                    icon: const Icon(
                      Icons.delete,
                      size: 30,
                    ),
                  )
                ],
              ),
              Text(
                widget.product.description ?? '',
                style: AppTextStyle.poppins(
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          child: IconButton(
                            onPressed: () {
                              if (productQuatity > 0) {
                                productQuatity--;
                                setState(() {});
                              }
                            },
                            icon: const Icon(Icons.remove),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          productQuatity.toString(),
                          style: AppTextStyle.poppins(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(width: 15),
                        CircleAvatar(
                          child: IconButton(
                            onPressed: () {
                              productQuatity++;
                              setState(() {});
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        onPressed: () async {
                          await _addProductToCart();
                          productInCart = productIsInCart();
                        },
                        icon: const Icon(Icons.check),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addProductToCart() async {
    final newProduct = widget.product.updateQuatity(productQuatity);
    if (productQuatity > 0) {
      await GetIt.I.get<LocalPrefService>().addProductToCart(newProduct);
    } else {
      _removeProductFromCart();
    }
    ProductsView.productsViewState.currentState?.updateCartBadge();
    ProductsView.productsViewState.currentState?.setState(() {});
    Navigator.of(context).maybePop();
  }

  Future<void> _removeProductFromCart() async {
    await GetIt.I.get<LocalPrefService>().deleteProductToCart(widget.product);
    ProductsView.productsViewState.currentState?.updateCartBadge();
    ProductsView.productsViewState.currentState?.setState(() {});
    Navigator.of(context).maybePop();
  }

  bool productIsInCart() {
    final localPrefService = GetIt.I.get<LocalPrefService>();
    List<Product> cartProducts = localPrefService.fetchCartItem();
    for (final product in cartProducts) {
      if (product.id == widget.product.id) {
        productQuatity = product.quatity;
        return true;
      }
    }
    return false;
  }

  @override
  void setState(VoidCallback fn) {
    // productInCart = !productInCart;
    super.setState(fn);
  }
}
