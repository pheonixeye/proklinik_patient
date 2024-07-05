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
  //TODO: translate component
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
                      child: const Text(
                        "Enter Your Info.",
                        style: TextStyle(
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
                          hintText: "Patient Name (Going To The Doctor)",
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
                          hintText: "Mobile Number",
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
                          hintText: "Email (Optional)",
                          icon: const Icon(Icons.mail),
                          iconColor: AppTheme.appBarColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Book now to receive the clinic’s address details and phone number",
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
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 48,
                            ),
                            child: Text(
                              "Book",
                              style: TextStyle(
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
                            //todo: nullify booking data
                            context.read<PxBooking>().setBookingData(null);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 24,
                            ),
                            child: Text(
                              "Cancel",
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
