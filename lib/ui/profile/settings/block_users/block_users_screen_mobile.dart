import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/empty_box/empty_box.dart';

import '../../../../constants/app_theme.dart';
import '../../../../constants/assets.dart';
import '../../../../widgets/appbar/appbar_view_not_logo.dart';
import '../../../../widgets/button/cs_icon_button.dart';
import '../../../../widgets/divider/divider.dart';
import '../../../../widgets/image/cache_image.dart';


class BlockUsersScreenMobile extends StatelessWidget {
  const BlockUsersScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarViewNotLogo(title: 'blocked_users'.tr(context)),
      body: SafeArea(
        child: Column(
          children: [
            _divider(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
                child: _buildBody(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final listBlockUser = List.generate(0, (index) => index);
    return listBlockUser.isEmpty
      ? EmptyBox(title: 'no_user_found_for_now'.tr(context))
      : ListView.builder(
        itemCount: listBlockUser.length,
        itemBuilder: (context, index) {
          return _itemBlock(
            context,
            avatar: 'https://vcdn1-giaitri.vnecdn.net/2022/09/23/-2181-1663929656.jpg?w=680&h=0&q=100&dpr=2&fit=crop&s=3WlbCM6dawFQQ1O6KarrCA',
            title: 'Rose',
            onPress: () async {},
          );
        },
      );
  }

  Widget _itemBlock(
    BuildContext context, {
    required String avatar,
    required String title,
    required AsyncCallback onPress,
  }) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.dimens_16),
          child: Row(
            children: <Widget>[
              _avatar(avatar),
              Gap(ScreenUtil().setWidth(Dimens.dimens_10)),
              Expanded(child: _title(context, title)),
              Gap(ScreenUtil().setWidth(Dimens.dimens_10)),
              _iconUnblock(context, onPress: onPress),
            ],
          ),
        ),
        _divider(context),
      ],
    );
  }

  Widget _iconUnblock(BuildContext context, { required AsyncCallback onPress }) {
    return CsIconButton(
      image: Assets.icUnblock,
      color: Theme.of(context).colorScheme.surfaceVariant,
      onPress: onPress,
    );
  }

  Widget _avatar(String avatar) {
    final size = ScreenUtil().setWidth(Dimens.dimens_40);
    return CacheImage(
      image: avatar,
      size: Size(size, size),
      borderRadius: Dimens.dimens_08,
      errorLoadingImage: Assets.icAvatarDefault,
    );
  }

  Text _title(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
        color: Theme.of(context).colorScheme.surfaceVariant,
        fontWeight: AppThemeData.regular,
      ),
    );
  }


  CustomDivider _divider(BuildContext context) => CustomDivider(height: 1, color: Theme.of(context).colorScheme.surfaceTint);

}
