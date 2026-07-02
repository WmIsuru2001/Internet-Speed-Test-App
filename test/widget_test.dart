import 'package:flutter_test/flutter_test.dart';
import 'package:internet_speed_test_app/main.dart';

void main() {
  testWidgets('renders the speed test screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Speed Test'), findsOneWidget);
    expect(find.text('START TEST'), findsOneWidget);
    expect(find.text('Download'), findsOneWidget);
    expect(find.text('Upload'), findsOneWidget);
  });
}
