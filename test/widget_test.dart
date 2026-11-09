
import 'package:flutter_test/flutter_test.dart';
import 'package:tripmate/main.dart';

void main() {
  testWidgets('TripMate home screen renders', (WidgetTester tester) async {
    await tester.pumpWidget(const TripMateApp());

    expect(find.text('Where to next?'), findsOneWidget);
    expect(find.text('Recommended'), findsOneWidget);
  });
}
