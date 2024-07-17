import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient/assets/assets.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:patient/widgets/footer_section/footer_section.dart';
import 'package:patient/widgets/homepage_btn/homepage_btn.dart';

class UnderConstructionPage extends StatelessWidget {
  const UnderConstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                Colors.white.withOpacity(0.5),
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
                  Assets.construction,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  context.loc.pageUnderConst,
                  style: TextStyle(
                    fontSize: context.isMobile ? 18 : 36,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.appBarColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                context.loc.sryMsg,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.mainFontColor,
                ),
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
  }
}
