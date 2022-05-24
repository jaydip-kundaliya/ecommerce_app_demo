import 'package:ecommerce_app_demo/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class NotificationBadge extends StatelessWidget {
  final int count;
  final Widget child;
  const NotificationBadge({
    Key? key,
    required this.child,
    this.count = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: child,
        ),
        Positioned(
          right: 8,
          top: 8,
          child: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.red,
            child: Center(
                child: Text(
              count < 9 ? count.toString() : '9+',
              style: AppTextStyle.poppins(
                fontSize: 10,
              ),
            )),
          ),
        )
      ],
    );
  }
}
