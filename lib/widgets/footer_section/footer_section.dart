import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:patient/assets/assets.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/widgets/footer_section/footer_btn.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:provider/provider.dart';

class _FlexibleWrapContainer extends StatelessWidget {
  // ignore: unused_element
  const _FlexibleWrapContainer({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return GridView(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: children,
      );
    } else {
      return Row(
        children: [
          ...children.map((x) {
            return Flexible(child: x);
          })
        ],
      );
    }
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
          return _FlexibleWrapContainer(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: InkWell(
                  mouseCursor:
                      context.isMobile ? null : SystemMouseCursors.click,
                  onTap: context.isMobile
                      ? null
                      : () {
                          GoRouter.of(context).go("/${l.lang}");
                        },
                  child: Row(
                    children: [
                      SizedBox(width: context.isMobile ? 16 : 50),
                      Image.asset(
                        Assets.icon,
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(width: context.isMobile ? 10 : 20),
                      Text(
                        "ProKliniK",
                        style: _titleStyle,
                      ),
                    ],
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.isMobile ? 16 : 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(10),
                      FooterBtn(
                        title: context.loc.aboutUs,
                        onTap: () {},
                      ),
                      FooterBtn(
                        title: context.loc.ourTeam,
                        onTap: () {},
                      ),
                      FooterBtn(
                        title: context.loc.careers,
                        onTap: () {},
                      ),
                      FooterBtn(
                        title: context.loc.press,
                        onTap: () {},
                      ),
                    ],
                  ),
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
                      onTap: () {},
                    ),
                    FooterBtn(
                      title: context.loc.lab,
                      onTap: () {},
                    ),
                    FooterBtn(
                      title: context.loc.rad,
                      onTap: () {},
                    ),
                    FooterBtn(
                      title: context.loc.pharma,
                      onTap: () {},
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
                      onTap: () {},
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
                  "",
                  style: _titleStyle,
                ),
                subtitle: Flex(
                  direction: context.isMobile ? Axis.horizontal : Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.facebookF,
                        color: Colors.white,
                      ),
                    ),
                    const Gap(5),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.linkedinIn,
                        color: Colors.white,
                      ),
                    ),
                    const Gap(5),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.squareYoutube,
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
