import 'package:flutter_test/flutter_test.dart';
import 'package:contact_flutter/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ContactApp());
  });
}
