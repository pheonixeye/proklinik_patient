import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient/assets/assets.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:patient/widgets/footer_section/footer_section.dart';
import 'package:patient/widgets/homepage_btn/homepage_btn.dart';
import 'package:provider/provider.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({super.key});

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PxLocale>(
      builder: (context, l, _) {
        return ListView(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(Assets.bg),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withValues(alpha: 0.5),
                    BlendMode.modulate,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Container(
                    height: MediaQuery.sizeOf(context).height / 2,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: SvgPicture.asset(
                      Assets.bgSvg,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      context.loc.thankYouForBooking,
                      style: TextStyle(
                        fontSize: context.isMobile ? 24 : 42,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.appBarColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    context.loc.appConfirmed,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    context.loc.willBeNotified,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Spacer(),
                      HomepageBtn(),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
            const FooterSection(),
          ],
        );
      },
    );
  }
}
