abstract class ExtraChargeEvent {}

class LoadChargeList extends ExtraChargeEvent {}

class AddNewCharge extends ExtraChargeEvent {
  final String flat;
  final String visitor;
  final String description;

  AddNewCharge({
    required this.flat,
    required this.visitor,
    required this.description,
  });
}

class RemoveCharge extends ExtraChargeEvent {
  final String flat;
  final String user;

  RemoveCharge({
    required this.flat,
    required this.user,
  });
}

class CancelCharge extends ExtraChargeEvent {
  final String user;
  final String flat;
  final String charge;

  CancelCharge({
    required this.user,
    required this.flat,
    required this.charge,
  });
}
