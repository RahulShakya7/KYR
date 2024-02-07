import 'package:flutter/material.dart';
import 'package:news_review_app/features/auth/presentation/view/profile_view.dart';

class StoreView extends StatelessWidget {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: ProfileView()),
    );
  }
}
