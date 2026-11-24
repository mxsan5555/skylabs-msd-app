import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:msd/m3_showcase.dart';

void main() {
  testWidgets('M3ShowcasePage renders without errors', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: M3ShowcasePage(),
      ),
    );
    await tester.pump();

    // The SliverAppBar.large title should be present in the widget tree
    expect(find.text('M3 Component Showcase'), findsAtLeastNWidgets(1));
  });
}
