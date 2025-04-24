import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:patient/extensions/first_where_or_null.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/models/filter_model.dart/filter_model.dart';
import 'package:patient/models/user_location_data_model/user_location_data_model.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/providers/px_app_constants.dart';
import 'package:provider/provider.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition(bool isEnglish) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

class FilterColumnItems extends StatefulWidget {
  const FilterColumnItems({super.key, this.isForMobile = false});
  final bool isForMobile;

  @override
  State<FilterColumnItems> createState() => _FilterColumnItemsState();
}

class _FilterColumnItemsState extends State<FilterColumnItems> {
  void _navigateAndFilter(String key, String? value) {
    final currentUri = GoRouter.of(context).routeInformationProvider.value.uri;
    final newUri = currentUri.replace(
      queryParameters: {
        ...currentUri.queryParameters,
        key: value,
      },
    );
    GoRouter.of(context).go(newUri.toString());
    if (widget.isForMobile) {
      Navigator.of(context).pop(true);
    }
  }

  void _navigateAndFilterByLocation(UserLocationDataModel model) {
    final currentUri = GoRouter.of(context).routeInformationProvider.value.uri;
    final newUri = currentUri.replace(
      queryParameters: {
        ...currentUri.queryParameters,
        ...model.toJson(),
      },
    );
    GoRouter.of(context).go(newUri.toString());
    if (widget.isForMobile) {
      Navigator.of(context).pop(true);
    }
  }

  final TextStyle _filterTitleStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.green.shade600,
  );

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxLocale, PxAppConstants>(
      builder: (context, l, a, _) {
        while (a.model == null) {
          return const SizedBox();
        }
        return Column(
          children: [
            ExpansionTile(
              initiallyExpanded: true,
              title: Row(
                children: [
                  const Icon(Icons.calendar_month_outlined),
                  const SizedBox(width: 10),
                  Text(
                    context.loc.avalability,
                    style: _filterTitleStyle,
                  ),
                ],
              ),
              children: [
                ...FilterModel.availabilityFilterItems.map((av) {
                  return RadioListTile(
                    groupValue: GoRouter.of(context)
                        .routeInformationProvider
                        .value
                        .uri
                        .queryParameters['av'],
                    title: Text(l.isEnglish ? av.name_en : av.name_ar),
                    value: av.value,
                    onChanged: (value) {
                      //todo: implement filtering
                      _navigateAndFilter("av", value);
                    },
                  );
                }),
              ],
            ),
            const Divider(),
            ExpansionTile(
              initiallyExpanded: true,
              title: Row(
                children: [
                  const Icon(FontAwesomeIcons.userDoctor),
                  const SizedBox(width: 10),
                  Text(
                    context.loc.degree,
                    style: _filterTitleStyle,
                  ),
                ],
              ),
              children: [
                ...FilterModel.degreeFilterItems.map((deg) {
                  final _degree_id = a.model!.degrees
                          .firstWhereOrNull((modelDegree) =>
                              deg.name_en == modelDegree.name_en)
                          ?.id ??
                      '';
                  return RadioListTile(
                    groupValue: GoRouter.of(context)
                        .routeInformationProvider
                        .value
                        .uri
                        .queryParameters['deg'],
                    title: Text(l.isEnglish ? deg.name_en : deg.name_ar),
                    value: _degree_id,
                    onChanged: (value) {
                      _navigateAndFilter("deg", _degree_id);
                    },
                  );
                }),
              ],
            ),
            const Divider(),
            ExpansionTile(
              initiallyExpanded: true,
              title: Row(
                children: [
                  const Icon(Icons.location_on),
                  const SizedBox(width: 10),
                  Text(
                    context.loc.distance,
                    style: _filterTitleStyle,
                  ),
                ],
              ),
              children: [
                ...FilterModel.distanceFilterItems.map((lo) {
                  return RadioListTile(
                    groupValue: GoRouter.of(context)
                        .routeInformationProvider
                        .value
                        .uri
                        .queryParameters['lo'],
                    title: Text(l.isEnglish ? lo.name_en : lo.name_ar),
                    value: lo.value,
                    onChanged: (value) async {
                      //todo: implement filtering by location
                      //TODO: check if location search implementation is correct

                      try {
                        final _userPositionData =
                            await _determinePosition(l.isEnglish);

                        if (value != null) {
                          final _model = UserLocationDataModel(
                            lon: '${_userPositionData.longitude}',
                            lat: '${_userPositionData.latitude}',
                            lo: value,
                          );
                          _navigateAndFilterByLocation(_model);
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      e.toString(),
                                      maxLines: 3,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.info,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 5),
                                ],
                              ),
                            ),
                          );
                        }
                      }
                    },
                  );
                }),
              ],
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}
