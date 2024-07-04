import 'package:patient/providers/locale_px.dart';
import 'package:patient/providers/spec_gov_px.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => PxLocale()),
  ChangeNotifierProvider(create: (context) => PxSpecGov()),
];
