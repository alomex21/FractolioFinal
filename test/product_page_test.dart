import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fractoliotesting/views/product_page.dart';

void main() {
  group('BuildListTile widget', () {
    testWidgets('should display title and value', (WidgetTester tester) async {
      const title = 'Title';
      const value = 'Value';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BuildListTile(
              title: title,
              value: value,
            ),
          ),
        ),
      );

      expect(find.text(title), findsOneWidget);
      expect(find.text(value), findsOneWidget);
    });

    testWidgets('should display leading and trailing widgets',
        (WidgetTester tester) async {
      const title = 'Title';
      const value = 'Value';
      const leading = Icon(Icons.ac_unit);
      const trailing = Icon(Icons.access_alarm);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BuildListTile(
              title: title,
              value: value,
              leading: leading,
              trail: trailing,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.ac_unit), findsOneWidget);
      expect(find.byIcon(Icons.access_alarm), findsOneWidget);
    });
  });
}
