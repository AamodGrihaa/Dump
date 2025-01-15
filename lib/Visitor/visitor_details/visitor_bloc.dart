import 'package:flutter_bloc/flutter_bloc.dart';
import 'visitor_event.dart';
import 'visitor_state.dart';

class VisitorBloc extends Bloc<VisitorEvent, VisitorState> {
  VisitorBloc() : super(VisitorInitial()) {
    on<LoadVisitors>((event, emit) async {
      emit(VisitorLoading());
      try {
        // Simulate fetching data from an API, DB, etc.
        await Future.delayed(const Duration(seconds: 1));

        final upcoming = [
          {
            'name': 'John Doe',
            'fromDate': '2025-01-15',
            'toDate': '2025-01-16',
            'flat': 'A-101',
            'photo': null
          },
          {
            'name': 'Jane Smith',
            'fromDate': '2025-01-17',
            'toDate': '2025-01-18',
            'flat': 'B-202',
            'photo': 'https://via.placeholder.com/150'
          },
          {
            'name': 'Sam Wilson',
            'fromDate': '2025-01-19',
            'toDate': '2025-01-20',
            'flat': 'C-303',
            'photo': null
          },
        ];

        final canceled = [
          {
            'name': 'Jack Sparrow',
            'fromDate': '2025-01-10',
            'toDate': '2025-01-11',
            'flat': 'D-404',
            'photo': null
          },
        ];

        final completed = [
          {
            'name': 'Tony Stark',
            'fromDate': '2025-01-01',
            'toDate': '2025-01-02',
            'flat': 'E-505',
            'photo': null
          },
        ];

        emit(
          VisitorLoaded(
            upcomingVisitors: upcoming,
            canceledVisitors: canceled,
            completedVisitors: completed,
          ),
        );
      } catch (error) {
        emit(VisitorError('Failed to load visitors: $error'));
      }
    });
  }
}
