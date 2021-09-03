import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';
import 'package:no_shimmer/no_shimmer.dart';

void main() {
  testWidgets('NoShimmerExample test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    final Finder listViewFinder = find.byType(ListView);
    expect(listViewFinder, findsOneWidget);

    final Finder noShimmersFinder = find.byType(NoShimmer);
    // Verify that NoShimmerExample has NoShimmer widgets
    expect(
      noShimmersFinder,
      findsWidgets,
    );

    // Skip 5 seconds of Future.delayed in NoShimmerExample's _delayedText method
    await tester.pump(const Duration(seconds: 5));

    final Finder textsFinder = find.byType(Text);
    // Verify that NoShimmerExample now has texts rendered after 5 seconds of delay.
    expect(
      textsFinder,
      findsWidgets,
    );
  });
}
