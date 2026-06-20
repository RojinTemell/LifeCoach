import 'package:fpdart/fpdart.dart';
import 'package:life_coach/core/error/failures.dart';

abstract interface class HealthRepository {
  Future<bool> requestPermission();
  Future<Either<Failure, int>> getTodaySteps();
  Future<Either<Failure, double>> getTodayDistance();
}
