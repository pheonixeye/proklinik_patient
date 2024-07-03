import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/widgets/footer_section/footer_section.dart';
import 'package:patient/theme/app_theme.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final int _textFieldExpandedRatio = 5;

  String? Function(String?)? _messagedValidator(String message) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return message;
      }
      return null;
    };
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      cacheExtent: 3000,
      children: [
        Container(
          height: context.isMobile ? 1024 : null,
          decoration: const BoxDecoration(
            color: AppTheme.greyBackgroundColor,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: context.isMobile ? 10 : 40,
            vertical: 20,
          ),
          child: Flex(
            direction: context.isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 13,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.isMobile ? 10 : 40),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                context.loc.contactUs,
                                style: TextStyle(
                                  color: AppTheme.mainFontColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            subtitle: Text(context.loc.weHappySuggestions),
                          ),
                        ),
                        const Gap(10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(context.isMobile ? 10 : 40),
                            SizedBox(
                              width: 100,
                              child: Text(context.loc.yourName),
                            ),
                            const Spacer(),
                            Expanded(
                              flex: _textFieldExpandedRatio,
                              child: TextFormField(
                                validator: _messagedValidator(
                                    context.loc.validateName),
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: context.loc.firstLastName,
                                ),
                              ),
                            ),
                            Gap(context.isMobile ? 10 : 40),
                          ],
                        ),
                        const Gap(10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(context.isMobile ? 10 : 40),
                            SizedBox(
                              width: 100,
                              child: Text(context.loc.mobileNumber),
                            ),
                            const Spacer(),
                            Expanded(
                              flex: _textFieldExpandedRatio,
                              child: TextFormField(
                                validator: _messagedValidator(
                                    context.loc.validateNumber),
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: context.loc.mobileNumber,
                                ),
                              ),
                            ),
                            Gap(context.isMobile ? 10 : 40),
                          ],
                        ),
                        const Gap(10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(context.isMobile ? 10 : 40),
                            SizedBox(
                              width: 100,
                              child: Text(context.loc.email),
                            ),
                            const Spacer(),
                            Expanded(
                              flex: _textFieldExpandedRatio,
                              child: TextFormField(
                                validator: _messagedValidator(
                                    context.loc.validateEmail),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "example@domain.com",
                                ),
                              ),
                            ),
                            Gap(context.isMobile ? 10 : 40),
                          ],
                        ),
                        const Gap(10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(context.isMobile ? 10 : 40),
                            SizedBox(
                              width: 100,
                              child: Text(context.loc.message),
                            ),
                            const Spacer(),
                            Expanded(
                              flex: _textFieldExpandedRatio,
                              child: TextFormField(
                                validator: _messagedValidator(
                                    context.loc.validateMessage),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                expands: false,
                                maxLines: 3,
                              ),
                            ),
                            Gap(context.isMobile ? 10 : 40),
                          ],
                        ),
                        const Gap(30),
                        Row(
                          children: [
                            const Spacer(),
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.orange.shade500,
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    //TODO: validate && send feedback
                                  }
                                },
                                label: Text(context.loc.send),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                        const Gap(10),
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(20),
              Expanded(
                flex: 9,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.isMobile ? 10 : 40),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              context.loc.contactUs,
                              style: TextStyle(
                                color: AppTheme.mainFontColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          subtitle: Text(context.loc.costRegular),
                        ),
                      ),
                      const Gap(10),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.isMobile ? 10 : 40),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              context.loc.address,
                              style: TextStyle(
                                color: AppTheme.mainFontColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          subtitle: Text(context.loc.addressString),
                        ),
                      ),
                      const Gap(10),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.isMobile ? 10 : 40),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              context.loc.mailUs,
                              style: TextStyle(
                                color: AppTheme.mainFontColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          subtitle: const Text("customercare@ProKliniK.app"),
                        ),
                      ),
                      const Gap(10),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.isMobile ? 10 : 40),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              context.loc.social,
                              style: TextStyle(
                                color: AppTheme.mainFontColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  FontAwesomeIcons.facebookF,
                                  color: AppTheme.mainFontColor,
                                ),
                              ),
                              const Gap(10),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  FontAwesomeIcons.linkedinIn,
                                  color: AppTheme.mainFontColor,
                                ),
                              ),
                              const Gap(10),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  FontAwesomeIcons.squareYoutube,
                                  color: AppTheme.mainFontColor,
                                ),
                              ),
                              const Gap(10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const FooterSection(),
      ],
    );
  }
}
