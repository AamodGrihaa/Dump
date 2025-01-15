abstract class ExtraChargeState {}

class ExtraChargeInitial extends ExtraChargeState {}

class ExtraChargeLoading extends ExtraChargeState {}

class ExtraChargeLoaded extends ExtraChargeState {
  final List<Map<String, String>> charges;

  ExtraChargeLoaded({required this.charges});
}

class ExtraChargeError extends ExtraChargeState {
  final String message;

  ExtraChargeError(this.message);
}
