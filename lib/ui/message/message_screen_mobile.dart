import 'package:flutter/material.dart';
import 'package:theshowplayer/configs/routers/router_name.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/di/action_method_locator.dart';
import 'package:theshowplayer/ui/message/component/item_message.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/appbar/appbar_view_not_logo.dart';
import 'package:theshowplayer/widgets/divider/divider.dart';

class MessageScreenMobile extends StatelessWidget {
  const MessageScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarViewNotLogo(title: 'messages'.tr(context)),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.dimens_16, vertical: Dimens.dimens_16,),
          separatorBuilder: (context, index) => _divider(context),
          itemCount: 10,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                navigation.navigateTo(RouterName.messageDetail);
              },
              child: const ItemMessage(),
            );
          },
        ),
      ),
    );
  }

  Widget _divider(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: Dimens.dimens_16),
    child: CustomDivider(
      height: 1,
      color: Theme.of(context).colorScheme.surfaceTint,
    ),
  );

  
}
