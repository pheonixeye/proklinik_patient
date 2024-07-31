import 'package:proklinik_models/models/clinic_shift.dart';

extension ConcatTime on ClinicShift {
  ///get the concatenated hours and minutes (local use only - instead of id)
  String get concat => '$startH$startM$endH$endM';
}
