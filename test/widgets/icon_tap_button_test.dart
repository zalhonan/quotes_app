import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:statusquotes/widgets/icon_tap_button.dart';

void main() {
  const testIcon = Icons.ac_unit;

  group('IconTabButton should', () {
    testWidgets('contain expected icon', (WidgetTester tester) async {
      await tester.pumpWidget(_wrap(IconTapButton(
        icon: testIcon,
      )));

      final iconFinder = find.byIcon(testIcon);
      expect(iconFinder, findsOneWidget);
    });
  });
}

Widget _wrap(Widget child) => MaterialApp(
      home: Scaffold(body: child),
    );
