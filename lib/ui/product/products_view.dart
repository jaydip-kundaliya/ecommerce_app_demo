import 'package:ecommerce_app_demo/bloc/product/product_bloc.dart';
import 'package:ecommerce_app_demo/bloc/product/product_state.dart';
import 'package:ecommerce_app_demo/models/product.dart';
import 'package:ecommerce_app_demo/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
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
      ),
    );
  }

  Widget buildArticleList(List<Product> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (ctx, pos) {
        return Container(
          height: 50,
          color: Colors.amber,
        );
      },
    );
  }
}
