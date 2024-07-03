import 'package:flutter/material.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/theme/app_theme.dart';

enum CommonSearchType {
  lab,
  rad,
  pharm,
}

class CommonSearchSection extends StatefulWidget {
  const CommonSearchSection({super.key, required this.type});
  final CommonSearchType type;

  @override
  State<CommonSearchSection> createState() => _CommonSearchSectionState();
}

class _CommonSearchSectionState extends State<CommonSearchSection> {
  final formKey = GlobalKey<FormState>();
  //TODO: implement selection
  //TODO: navigate to appropriate search page with results
  //TODO: ask for location to arrange nearest to farthest

  String? _govValidator(String? value) {
    if (value == null || value.isEmpty) {
      return context.loc.selectGovValidator;
    }
    return null;
  }

  String? _areaValidator(String? value) {
    if (value == null || value.isEmpty) {
      return context.loc.selectAreaValidator;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.searchContainerDecoration,
      child: Form(
        key: formKey,
        child: Flex(
          direction: context.isMobile ? Axis.vertical : Axis.horizontal,
          children: [
            const SizedBox(width: 5),
            Expanded(
              child: Card.outlined(
                elevation: 6,
                borderOnForeground: false,
                shape: AppTheme.localizedCardBorder(context, 0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      icon: Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.green.shade500,
                      ),
                      alignment: Alignment.center,
                      validator: _govValidator,
                      hint: Text(context.loc.pickGov),
                      isExpanded: true,
                      items: [],
                      onChanged: (val) {},
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card.outlined(
                elevation: 6,
                borderOnForeground: false,
                shape: AppTheme.localizedCardBorder(context, 1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      validator: _areaValidator,
                      icon: Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.green.shade500,
                      ),
                      alignment: Alignment.center,
                      hint: Text(context.loc.pickArea),
                      isExpanded: true,
                      items: [],
                      onChanged: (val) {},
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(context.isMobile ? 16 : 0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 8,
                    shape: context.isMobile
                        ? null
                        : AppTheme.localizedCardBorder(context, 3),
                    fixedSize:
                        context.isMobile ? null : const Size.fromHeight(64),
                    backgroundColor: Colors.green.shade500,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {}
                  },
                  icon: const Icon(Icons.search),
                  label: Text(context.loc.search),
                ),
              ),
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
