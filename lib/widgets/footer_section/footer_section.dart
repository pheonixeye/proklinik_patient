import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:proklinik_patient/extensions/is_mobile_context.dart';
import 'package:proklinik_patient/extensions/loc_ext.dart';
import 'package:proklinik_patient/router/router.dart';
import 'package:proklinik_patient/widgets/footer_section/footer_btn.dart';
import 'package:proklinik_patient/providers/locale_px.dart';
import 'package:provider/provider.dart';
import 'package:web/web.dart' as web;

class FlexibleWrapContainer extends StatelessWidget {
  // ignore: unused_element
  const FlexibleWrapContainer({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return context.isMobile
        ? GridView(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.9,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            children: children,
          )
        : Row(
            children: [
              ...children.map((x) {
                return Flexible(child: x);
              })
            ],
          );
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  final _titleStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.isMobile ? 550 : 250,
      decoration: BoxDecoration(
        color: Colors.green.shade500,
      ),
      child: Consumer<PxLocale>(
        builder: (context, l, _) {
          return FlexibleWrapContainer(
            children: [
              ListTile(
                title: Text.rich(
                  TextSpan(
                    text: "ProKliniK",
                    recognizer: TapGestureRecognizer()
                      ..onTap = context.isMobile
                          ? null
                          : () {
                              GoRouter.of(context).go("/${l.lang}");
                            },
                  ),
                  style: _titleStyle,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(10),
                    FooterBtn(
                      title: context.loc.aboutUs,
                      onTap: () {},
                    ),
                    FooterBtn(
                      title: context.loc.termsOfUse,
                      onTap: () {},
                    ),
                    FooterBtn(
                      title: context.loc.privacyPolicy,
                      onTap: () {},
                    ),
                    FooterBtn(
                      title: context.loc.privacyPolicyDoctors,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  context.loc.ourServices,
                  style: _titleStyle,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(10),
                    FooterBtn(
                      title: context.loc.clinic,
                      onTap: () {
                        GoRouter.of(context).go("/${l.lang}");
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  context.loc.forProviders,
                  style: _titleStyle,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(10),
                    FooterBtn(
                      title: context.loc.joinNetwork,
                      onTap: () {
                        //TODO
                        GoRouter.of(context).goNamed(
                          AppRouter.underconstruction,
                          pathParameters: defaultPathParameters(context),
                        );
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  context.loc.needHelp,
                  style: _titleStyle,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(10),
                    FooterBtn(
                      title: context.loc.contactUs,
                      onTap: () {
                        GoRouter.of(context).goNamed(
                          AppRouter.contactus,
                          pathParameters: defaultPathParameters(context),
                        );
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  "",
                  style: _titleStyle,
                ),
                subtitle: Flex(
                  direction: context.isMobile ? Axis.horizontal : Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        //TODO
                        web.window.open('https://', 'Facebook', '_blank');
                      },
                      icon: Icon(
                        FontAwesomeIcons.facebookF.data,
                        color: Colors.white,
                      ),
                    ),
                    const Gap(5),
                    IconButton(
                      onPressed: () {
                        //TODO
                        web.window.open('https://', 'LinkedIn', '_blank');
                      },
                      icon: Icon(
                        FontAwesomeIcons.linkedinIn.data,
                        color: Colors.white,
                      ),
                    ),
                    const Gap(5),
                    IconButton(
                      onPressed: () {
                        //TODO
                        web.window.open('https://', 'YouTube', '_blank');
                      },
                      icon: Icon(
                        FontAwesomeIcons.squareYoutube.data,
                        color: Colors.white,
                      ),
                    ),
                    const Gap(5),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
