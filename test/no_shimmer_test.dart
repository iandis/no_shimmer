import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:no_shimmer/no_shimmer.dart';

void main() {
  testWidgets('Verify that NoShimmer can be rendered',
      (WidgetTester tester) async {
    await tester.pumpWidget(const NoShimmer(
      padding: EdgeInsets.all(10), // optional
      borderRadius: BorderRadius.all(Radius.circular(20)), // optional
    ));
    final Finder noShimmerFinder = find.byWidgetPredicate((widget) {
      return widget is NoShimmer && widget.color == Colors.grey[200];
    });
    expect(noShimmerFinder, findsOneWidget);
  });
}
