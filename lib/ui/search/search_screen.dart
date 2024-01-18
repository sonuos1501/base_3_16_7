
import 'package:flutter/material.dart';
import 'package:theshowplayer/ui/search/search_screen_desktop.dart';
import 'package:theshowplayer/ui/search/search_screen_ipad.dart';
import 'package:theshowplayer/ui/search/search_screen_mobile.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultipleScreenUtil(
      mobiles: SearchScreenMobile(key: key),
      ipads: SearchScreenIpad(key: key),
      desktops: SearchScreenDesktop(key: key),
    );
  }
}
