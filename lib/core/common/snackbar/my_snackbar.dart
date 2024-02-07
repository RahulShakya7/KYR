import 'package:flutter/material.dart';
import 'package:news_review_app/config/constants/theme_constant.dart';

void showSnackBar({
  required String message,
  required BuildContext context,
  Color? color,
}) {
  final overlay = Overlay.of(context);

  final overlayEntry = OverlayEntry(
    builder: (BuildContext context) => Positioned(
      top: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          child: Card(
            color: color ?? AppColorConstant.accentColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  // Wait for 2 seconds and then remove the overlay
  Future.delayed(const Duration(seconds: 5), () {
    overlayEntry.remove();
  });
}
