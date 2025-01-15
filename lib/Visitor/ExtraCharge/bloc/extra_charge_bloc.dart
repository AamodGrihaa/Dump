import 'package:flutter_bloc/flutter_bloc.dart';
import 'extra_charge_event.dart';
import 'extra_charge_state.dart';

class ExtraChargeBloc extends Bloc<ExtraChargeEvent, ExtraChargeState> {
  ExtraChargeBloc() : super(ExtraChargeInitial()) {
    on<LoadChargeList>((event, emit) async {
      emit(ExtraChargeLoading());
      try {
        // Simulate fetching data
        await Future.delayed(const Duration(seconds: 1));

        final chargeList = [
          {'user': 'John Doe', 'flat': 'A-101', 'charge': 'Parking Fee'},
          {'user': 'Jane Smith', 'flat': 'B-202', 'charge': 'Maintenance Fee'},
        ];

        emit(ExtraChargeLoaded(charges: chargeList));
      } catch (error) {
        emit(ExtraChargeError('Failed to load charges: $error'));
      }
    });

    on<AddNewCharge>((event, emit) async {
      emit(ExtraChargeLoading());
      // Suppose we add a new charge to DB
      await Future.delayed(const Duration(seconds: 1));
      // Reload
      add(LoadChargeList());
    });

    on<RemoveCharge>((event, emit) async {
      emit(ExtraChargeLoading());
      // Suppose we remove a charge
      await Future.delayed(const Duration(seconds: 1));
      // Reload
      add(LoadChargeList());
    });

    on<CancelCharge>((event, emit) async {
      emit(ExtraChargeLoading());
      // Suppose we cancel a specific charge
      await Future.delayed(const Duration(seconds: 1));
      // Reload
      add(LoadChargeList());
    });
  }
}
