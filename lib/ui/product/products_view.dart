import 'package:ecommerce_app_demo/models/product.dart';
import 'package:ecommerce_app_demo/services/local_preferences.dart';
import 'package:ecommerce_app_demo/ui/product/product_item_view.dart';
import 'package:ecommerce_app_demo/ui/shared/notification_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../bloc/product/product_bloc.dart';
import '../../repositories/product_repository.dart';
import '../../utils/app_text_style.dart';
import '../cart/cart_view.dart';
import '../shared/app_bar.dart';

class ProductsView extends StatefulWidget {
  static final productsViewState = GlobalKey<ProductsViewState>();
  ProductsView() : super(key: productsViewState);

  @override
  State<ProductsView> createState() => ProductsViewState();
}

class ProductsViewState extends State<ProductsView> {
  List<Product> products = [];
  List<Product> cartProducts = [];

  final productBloc = ProductBloc();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //  final bloc = BlocProvider.of<ProductBloc>(context, listen: false);
      // bloc.repository.getProducts();
      productBloc.add(FetchProductEvents());
      initializeList();
      updateCartBadge();
    });
    super.initState();
  }

  void updateCartBadge() {
    cartProducts = GetIt.I.get<LocalPrefService>().fetchCartItem();
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
          NotificationBadge(
            count: cartProducts.length,
            child: IconButton(
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
            ),
          )
        ],
      ),
      body: buildArticleList(products),

      //     BlocListener<ProductBloc, ProductState>(
      //   listener: (context, state) => setState(() {}),
      //   child: BlocBuilder<ProductBloc, ProductState>(
      //     builder: (BuildContext context, state) {
      //       if (state is ProductInitialState) {
      //         return const Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       } else if (state is ProductLoadingState) {
      //         return const Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       } else if (state is ProductLoadedState) {
      //         return buildArticleList(state.products);
      //       } else if (state is ProductErrorState) {
      //         return Center(
      //           child: Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: Text(
      //               state.message,
      //               style: AppTextStyle.poppins(
      //                 color: Colors.red,
      //               ),
      //             ),
      //           ),
      //         );
      //       } else {
      //         return const SizedBox.shrink();
      //       }
      //     },
      //   ),
      // ),
    );
  }

  Widget buildArticleList(List<Product> products) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: GridView.builder(
              itemCount: products.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
              ),
              itemBuilder: (BuildContext context, int pos) => ProductItemView(
                product: products[pos],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
