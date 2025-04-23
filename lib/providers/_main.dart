import 'package:patient/api/app_constants_api/app_constants_api.dart';
import 'package:patient/api/visits_api/visits_api.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/providers/px_app_constants.dart';
import 'package:patient/providers/px_visits.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => PxLocale()),
  ChangeNotifierProvider(
    create: (context) => PxAppConstants(
      service: const AppConstantsApi(),
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => PxVisits(
      service: const VisitsApi(),
    ),
  ),
];
