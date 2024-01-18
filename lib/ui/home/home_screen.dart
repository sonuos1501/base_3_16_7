import 'package:flutter/material.dart';
import 'package:theshowplayer/ui/home/home_screen_ipad.dart';
import 'package:theshowplayer/ui/home/home_screen_mobile.dart';
import 'package:theshowplayer/ui/home/home_sreen_desktop.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import '../../models/home/categories_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ super.key, required this.categories });

  final List<DetailCategory> categories;

  @override
  Widget build(BuildContext context) {
    return MultipleScreenUtil(
      mobiles: HomeScreenMobile(categories: categories),
      ipads: const HomeScreenIpad(),
      desktops: const HomeScreenDesktop(),
    );
  }
}
