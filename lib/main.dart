import 'package:life_coach/app/app.dart';
import 'package:life_coach/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
