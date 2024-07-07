import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/providers/booking_px.dart';
import 'package:patient/router/router.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class BookAppForm extends StatefulWidget {
  const BookAppForm({super.key});

  @override
  State<BookAppForm> createState() => _BookAppFormState();
}

class _BookAppFormState extends State<BookAppForm> {
  //todo: translate component
  //TODO: recieve and validate booking info
  final formKey = GlobalKey<FormState>();

  String? _nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.loc.validateName;
    }
    return null;
  }

  String? _phoneNumberValidator(String? value) {
    if (value == null || value.trim().isEmpty || value.trim().length != 11) {
      return context.loc.validateNumber;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 545,
      child: Form(
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
                        validator: _phoneNumberValidator,
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
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText:
                              "${context.loc.email} (${context.loc.optional})",
                          icon: const Icon(Icons.mail),
                          iconColor: AppTheme.appBarColor,
                        ),
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
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              //TODO: validate form && send booking request
                            }
                            //TODO: navigate to post booking info page
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
                              pathParameters: defaultPathParameters(context),
                            );
                            //TODO: nullify booking data
                            context.read<PxBooking>().setBookingData(null);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12.0,
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
      ),
    );
  }
}
