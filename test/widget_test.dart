import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_layout_basico/main.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const GamersBrawlApp());

    expect(find.text('Gamers Brawl'), findsOneWidget);
  });
}