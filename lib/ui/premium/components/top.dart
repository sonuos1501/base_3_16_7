import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/app_theme.dart';
import 'package:theshowplayer/constants/assets.dart';
import 'package:theshowplayer/constants/colors.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/utils/regex/regex.dart';
import 'package:theshowplayer/widgets/input/basic_text_field.dart';

class TopPremium extends StatelessWidget {
  const TopPremium({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Dimens.dimens_215,
          child: Stack(
            children: [
              // const CacheImage(
              //   image: 'https://znews-photo.zingcdn.me/w1920/Uploaded/pwivovlb/2023_03_23/1O5A2699_.jpg',
              //   size: Size(double.infinity, Dimens.dimens_252),
              //   borderRadius: Dimens.dimens_00,
              // ),
              Image.asset(Assets.imgCoverPremium, width: double.infinity, height: Dimens.dimens_252),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: const [0, 0.1237, 0.8235],
                    colors: [
                      AppColors.black1E1919,
                      AppColors.black1B1313.withOpacity(0.8666),
                      AppColors.black504B4B.withOpacity(0),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'The world of 10.000+ \n premium video'.tr(context),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        fontWeight: AppThemeData.bold,
                      ),
                    ),
                    const Gap(Dimens.dimens_20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: BasicTextField(
                            controller: TextEditingController(),
                            regexConfig: RegexConstant.none,
                            keyboardType: TextInputType.text,
                            borderRadius: Dimens.dimens_12,
                            hintText: 'enter_search_item'.tr(context),
                          ),
                        ),
                        const Gap(Dimens.dimens_04),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: Dimens.dimens_14, horizontal: Dimens.dimens_18),
                            decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.error,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: SvgPicture.asset(Assets.icSearch),
                          ),
                        )
                      ],
                    ),
                    const Gap(Dimens.dimens_08),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding).copyWith(top: Dimens.dimens_16),
        //   child: Row(
        //     children: const [

        //     ],
        //   ),
        // ),
      ],
    );
  }
}
