import 'package:ecommerce_app_demo/models/product.dart';
import 'package:ecommerce_app_demo/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class CartItemView extends StatelessWidget {
  const CartItemView({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                product.featuredImage!,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title ?? '',
                      style: AppTextStyle.poppins(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price',
                          style: AppTextStyle.poppins(),
                        ),
                        Text(
                          product.price?.toStringAsFixed(0) ?? '' '₹',
                          style: AppTextStyle.poppins(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quatity',
                          style: AppTextStyle.poppins(),
                        ),
                        Text(
                          '0' ?? '',
                          style: AppTextStyle.poppins(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
