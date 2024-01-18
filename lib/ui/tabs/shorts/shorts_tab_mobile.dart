// ignore_for_file: inference_failure_on_instance_creation

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theshowplayer/models/channels/short_data.dart';
import 'package:theshowplayer/ui/short/bloc/short_bloc.dart';
import 'package:theshowplayer/ui/short/short_screen.dart';
import 'package:theshowplayer/ui/tabs/shorts/bloc/short_tab_bloc.dart';
import 'package:theshowplayer/widgets/components/short_items.dart';

import '../../../constants/dimens.dart';
import '../../../di/service_locator.dart';
import '../../../widgets/empty_box/empty_box.dart';
import '../../../widgets/loading/loading_view.dart';


class ShortsTabMobile extends StatefulWidget {
  const ShortsTabMobile({super.key, required this.channelId});

  final int channelId;

  @override
  State<ShortsTabMobile> createState() => _ShortsTabMobileState();
}

class _ShortsTabMobileState extends State<ShortsTabMobile> {
  late final _controller = BlocProvider.of<ShortTabBloc>(context, listen: false);

  final int _limit = 100;
  final int _offset = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.add(
        ShortTabEvent.loaded(argumentsShortData: ArgumentsShortData(
          channelId: widget.channelId,
          limit: _limit,
          offset: _offset,
          type: 'get_user_shorts',
        ),),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<ShortTabBloc, ShortTabState>(
      buildWhen: (previous, current) => current is ShortTabInitialState && current != previous,
      builder: (context, state) {
        final listShort = <ShortData>[];
        if (state is ShortTabInitialState) {
          listShort.addAll(state.listShort ?? []);
        }

        return listShort.isEmpty
          ? Center(
            child: SingleChildScrollView(
              child: BlocBuilder<ShortTabBloc, ShortTabState>(
                builder: (context, state) {
                  if (state is ShortTabLoadingState) {
                    return const LoadingView();
                  }

                  return const EmptyBox(title: '');
                },
              ),
            ),
          )
          : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listShort.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: Dimens.dimens_10,
              crossAxisSpacing: Dimens.dimens_10,
              mainAxisExtent: ScreenUtil().setHeight(Dimens.dimens_250),
            ),
            itemBuilder: (context, index) {
              final short = listShort[index];

              return ShortItems(
                imageBackground: short.thumbnail ?? '',
                title: short.title ?? '',
                onPress: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => sl<ShortBloc>(),
                        child: ShortScreen(
                          listShort: listShort,
                          index: index,
                        ),
                      ),
                    ),
                  );
                },
                size: Size(ScreenUtil().setWidth(Dimens.dimens_200), ScreenUtil().setHeight(Dimens.dimens_250)),
                numberView: (short.views ?? 0).toString(),
              );
            },
          );
      },
    );
  }
}
