import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/assets.dart';
import 'package:theshowplayer/constants/colors.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/ui/search/bloc/search_bloc.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/utils/regex/regex.dart';
import 'package:theshowplayer/widgets/input/basic_text_field.dart';

class CustomAppBarSearch extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBarSearch({super.key});

  @override
  State<CustomAppBarSearch> createState() => _CustomAppBarSearchState();

  @override
  Size get preferredSize => const Size.fromHeight(Dimens.dimens_100);
}

class _CustomAppBarSearchState extends State<CustomAppBarSearch> {
  late TextEditingController _textSearchController;

  @override
  void initState() {
    super.initState();
    _textSearchController = TextEditingController()
      ..addListener(() {
        if (_textSearchController.text != '') {
          BlocProvider.of<SearchBloc>(context).add(const IsSearchingEvent(isSearchingEvent: true));
        } else {
          BlocProvider.of<SearchBloc>(context).add(const IsSearchingEvent(isSearchingEvent: false));
        }
      });
  }

  @override
  void dispose() {
    _textSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.dimens_16).copyWith(bottom: Dimens.dimens_13),
      height: ScreenUtil().setHeight(Dimens.dimens_100),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color:Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.surfaceTint,
            width: Dimens.dimens_01,
          ),
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(Assets.icArrowBack),
          ),
          Gap(ScreenUtil().setWidth(Dimens.dimens_10)),
          Expanded(
            child: BasicTextField(
              regexConfig: RegexConstant.none,
              controller: _textSearchController,
              keyboardType: TextInputType.text,
              onChange: (p0) {},
              borderRadius: Dimens.dimens_12,
              contentPadding: const EdgeInsets.symmetric(vertical: Dimens.dimens_11).copyWith(left: Dimens.dimens_14),
              hintText: 'search'.tr(context),
              prefixIcon: InkWell(
                onTap: () {
                  BlocProvider.of<SearchBloc>(context).add(SearchEvent.searching(keySearch: _textSearchController.text));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: Dimens.dimens_14,
                    right: Dimens.dimens_11,
                  ),
                  child: BlocBuilder<SearchBloc, SearchState>(
                    buildWhen: (previous, current) => current is IsSearchingState && current != previous,
                    builder: (context, state) {
                      var isSearching = false;

                      if(state is IsSearchingState) {
                        isSearching = state.isSearch ?? false;
                      }
                      return SvgPicture.asset(
                        Assets.icSearch,
                        color: isSearching
                          ? AppColors.redFF5252
                          : AppColors.greyCACACA,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
