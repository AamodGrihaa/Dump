// This file defines our VisitorState classes.

abstract class VisitorState {}

class VisitorInitial extends VisitorState {}

class VisitorLoading extends VisitorState {}

class VisitorLoaded extends VisitorState {
  final List<Map<String, dynamic>> upcomingVisitors;
  final List<Map<String, dynamic>> canceledVisitors;
  final List<Map<String, dynamic>> completedVisitors;

  VisitorLoaded({
    required this.upcomingVisitors,
    required this.canceledVisitors,
    required this.completedVisitors,
  });
}

class VisitorError extends VisitorState {
  final String message;

  VisitorError(this.message);
}
