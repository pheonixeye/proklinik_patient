import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/providers/booking_px.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/router/router.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:patient/widgets/central_loading/central_loading.dart';
import 'package:provider/provider.dart';

const _visitTypes = {
  "C": (en: "Consultation", ar: "كشف"),
  "F": (en: "Followup", ar: "استشارة"),
};

class BookAppForm extends StatefulWidget {
  const BookAppForm({super.key});

  @override
  State<BookAppForm> createState() => _BookAppFormState();
}

class _BookAppFormState extends State<BookAppForm> {
  //todo: translate component
  //todo: recieve and validate booking info
  final formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String? _nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.loc.validateName;
    }
    return null;
  }

  String? _phoneNumberValidator(String? value) {
    if (value == null || value.trim().isEmpty || value.trim().length != 11) {
      return context.loc.validateMobileDigits;
    }
    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return null;
      // ignore: unnecessary_null_comparison
    } else if (value != null && !EmailValidator.validate(value)) {
      return context.loc.validateEmailOrLeaveEmpty;
    }
    return null;
  }

  String? _type;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 545,
      child: Consumer2<PxBooking, PxLocale>(
        builder: (context, b, l, _) {
          return Form(
            key: formKey,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 30,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            color: Colors.green,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            context.loc.enterYourInfo,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: TextFormField(
                            controller: _nameController,
                            validator: _nameValidator,
                            decoration: InputDecoration(
                              hintText: context.loc.ptNameForm,
                              icon: const Icon(Icons.person),
                              iconColor: AppTheme.appBarColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: TextFormField(
                            controller: _phoneController,
                            validator: _phoneNumberValidator,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              hintText: context.loc.mobileNumber,
                              icon: const Icon(Icons.phone),
                              iconColor: AppTheme.appBarColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  validator: _emailValidator,
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    hintText:
                                        "${context.loc.email}(${context.loc.optional})",
                                    icon: const Icon(Icons.mail),
                                    iconColor: AppTheme.appBarColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                flex: 2,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<String>(
                                    borderRadius: BorderRadius.circular(8),
                                    isExpanded: true,
                                    value: _type,
                                    elevation: 6,
                                    alignment: Alignment.center,
                                    icon: Icon(
                                      Icons.arrow_drop_down_circle,
                                      color: AppTheme.appBarColor,
                                    ),
                                    hint: Text(
                                      l.isEnglish
                                          ? "Visit Type."
                                          : "نوع الزيارة",
                                      style: TextStyle(
                                        fontSize: context.isMobile ? 10 : 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0))),
                                    ),
                                    items: _visitTypes.entries.map((e) {
                                      return DropdownMenuItem<String>(
                                        value: e.value.en,
                                        alignment: Alignment.center,
                                        child: Text(
                                          l.isEnglish ? e.value.en : e.value.ar,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      if (value != null) {
                                        b.setBookingData(b.data?.copyWith(
                                          type: value,
                                        ));
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            context.loc.bookToRecieveInfo,
                            style: TextStyle(
                              color: AppTheme.mainFontColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Divider(
                          thickness: 1,
                          height: 1,
                          color: AppTheme.mainFontColor.withOpacity(0.5),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.secondaryOrangeColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  //todo: validate form
                                  b.setBookingData(b.data?.copyWith(
                                    user_name: _nameController.text.trim(),
                                    user_phone: _phoneController.text.trim(),
                                    user_email: _emailController.text.trim(),
                                  ));
                                  if (kDebugMode) {
                                    print(b.data);
                                  }
                                  late final BuildContext dialogContext;
                                  showDialog(
                                      context: context,
                                      useRootNavigator: false,
                                      builder: (context) {
                                        dialogContext = context;
                                        return const CentralLoading();
                                      });

                                  //todo: send booking request
                                  await b.createAppointment().whenComplete(() {
                                    Navigator.pop(dialogContext);
                                  });
                                  //todo: navigate to post booking info page
                                  if (context.mounted) {
                                    GoRouter.of(context).goNamed(
                                      AppRouter.thankyou,
                                      pathParameters:
                                          defaultPathParameters(context),
                                    );
                                  }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 48,
                                ),
                                child: Text(
                                  context.loc.book,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: const BorderSide(),
                                ),
                              ),
                              onPressed: () {
                                //todo: navigate back to home
                                GoRouter.of(context).goNamed(
                                  AppRouter.home,
                                  pathParameters:
                                      defaultPathParameters(context),
                                );
                                //todo: nullify booking data
                                b.setBookingData(null);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 24,
                                ),
                                child: Text(
                                  context.loc.cancel,
                                  style: TextStyle(
                                    color: AppTheme.mainFontColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Divider(
                          thickness: 1,
                          height: 1,
                          color: AppTheme.mainFontColor.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
