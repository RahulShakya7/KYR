import 'package:flutter/material.dart';
import 'package:news_review_app/config/constants/theme_constant.dart';

class BlackButton extends StatelessWidget {
  final String message;
  final VoidCallback onPressed;
  final Color color;

  const BlackButton({
    Key? key,
    required this.message,
    required this.onPressed,
    this.color = AppColorConstant.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      child: Text(message),
    );
  }
}
