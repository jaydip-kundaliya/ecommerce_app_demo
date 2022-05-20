import 'package:ecommerce_app_demo/models/product.dart';
import 'package:ecommerce_app_demo/ui/product/product_item_view.dart';
import 'package:flutter/material.dart';

import '../../repositories/product_repository.dart';
import '../cart/cart_view.dart';
import '../shared/app_bar.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  List<Product> products = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initializeList();
    });
    super.initState();
  }

  Future<void> initializeList() async {
    products = await ProductRepositoryImpl().getProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Shopping mall',
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CartView(),
                ),
              );
            },
            focusColor: Colors.transparent,
            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),
          )
        ],
      ),
      body: buildArticleList(products),

      /* BlocBuilder<ProductBloc, ProductState>(
        builder: (BuildContext context, state) {
          if (state is ProductInitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductLoadedState) {
            return buildArticleList(state.products);
          } else if (state is ProductErrorState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  state.message,
                  style: AppTextStyle.poppins(
                    color: Colors.red,
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),*/
    );
  }

  Widget buildArticleList(List<Product> products) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GridView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
        ),
        itemBuilder: (BuildContext context, int pos) => ProductItemView(
          product: products[pos],
        ),
      ),
    );
  }
}
