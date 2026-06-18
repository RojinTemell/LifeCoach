import 'package:flutter_test/flutter_test.dart';
import 'package:life_coach/app/app.dart';

void main() {
  testWidgets('App starts on dashboard', (tester) async {
    await tester.pumpWidget(const App());
    // pumpAndSettle tüm animasyon/geçişler bitene kadar bekler
    await tester.pumpAndSettle();
    expect(find.text('Bugün'), findsOneWidget);
  });
}
