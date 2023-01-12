import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_editor/main.dart';


void main() {
  testWidgets('Button tap test', (WidgetTester tester) async {
    // Build the widgets
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    // Find the button
    final button = find.byKey(const ValueKey('delete_image'));

    // Verify that the button is present
    expect(button, findsOneWidget);

    // Tap the button
    await tester.tap(button);
    await tester.pump();

    // Verify that the button has been tapped

  });
}


