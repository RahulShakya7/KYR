import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_review_app/features/home/presentation/view/bottom_bar.dart';

void main() {
  testWidgets('bottom bar test', (tester) async {
    int selectedIndex = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: AppNavigationBar(
            selectedIndex: selectedIndex,
            onItemSelected: (index) {
              selectedIndex = index;
            },
          ),
        ),
      ),
    );

    // Verify that the initial selected index is 0
    expect(selectedIndex, 0);

    // Tap on the second item (News)
    await tester.tap(find.byIcon(Icons.newspaper));
    await tester.pump();

    // Verify that the selected index is updated to 1
    expect(selectedIndex, 1);
  });
}
