import 'package:equatable/equatable.dart';

enum DashboardStatus { initial, loading, success, failure }

class DashboardState extends Equatable {
  const DashboardState({
    this.status = DashboardStatus.initial,
    this.steps = 0,
    this.errorMessage,
  });

  final DashboardStatus status;
  final int steps;
  final String? errorMessage;

  DashboardState copyWith({
    DashboardStatus? status,
    int? steps,
    String? errorMessage,
  }) {
    return DashboardState(
      status: status ?? this.status,
      steps: steps ?? this.steps,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, steps, errorMessage];
}
