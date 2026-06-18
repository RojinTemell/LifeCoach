import 'package:flutter_test/flutter_test.dart';
import 'package:life_coach/app/app.dart';

void main() {
  testWidgets('App renders home text', (tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('Life Coach'), findsOneWidget);
  });
}
