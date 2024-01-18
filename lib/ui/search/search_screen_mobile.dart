import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theshowplayer/configs/routers/router_name.dart';
import 'package:theshowplayer/constants/assets.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/di/action_method_locator.dart';
import 'package:theshowplayer/ui/search/bloc/search_bloc.dart';
import 'package:theshowplayer/ui/search/components/app_bar_search.dart';
import 'package:theshowplayer/widgets/components/playlist_items.dart';
import 'package:theshowplayer/widgets/loading/loading_view.dart';
import 'package:theshowplayer/widgets/text/rich_text_link.dart';


class SearchScreenMobile extends StatelessWidget {
  const SearchScreenMobile({super.key, this.recentSearch, this.content});
  final List<String>? recentSearch;
  final List<String>? content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarSearch(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.dimens_09).copyWith(left: Dimens.dimens_17),
        child: BlocBuilder<SearchBloc, SearchState>(
          buildWhen: (previous, current) => current is SearchingState && current != previous,
          builder: (context, state) {
            if (state is SearchingState) {
              if (state.isLoading) {
                return const Center(child: LoadingView());
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.listSearchVideos.isNotEmpty) ...[
                    _buildTitle(
                      context,
                      txt1: 'About 20 results for ',
                      txt2: state.keySearch,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.listSearchVideos.length,
                        padding: const EdgeInsets.only(top: 16),
                        itemBuilder: (context, index) {
                          final video = state.listSearchVideos[index];
                          // final date = DateTime.fromMicrosecondsSinceEpoch(
                          //   video.time ?? 9,
                          // );
                          // final listLenght = state.listSearchVideos.length;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: PlaylistItems(
                              imageBackground: video.thumbnail ?? '',
                              avatar: video.owner?.avatar ?? '',
                              name: video.owner?.name ?? '',
                              time: video.duration ?? '00:00:00',
                              title: video.title ?? '',
                              numberView: video.views,
                              onPress: () async  {
                                await navigation.navigateTo(RouterName.watchScreen, arguments: video);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ] else ...[
                    _buildTitle(
                      context,
                      txt1: 'Your search - ',
                      txt2: state.keySearch,
                      txt3: ' - did not match any documents.',
                    ),
                    Expanded(child: Center(child: Image.asset(Assets.empty)))
                  ]
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildTitle(
    BuildContext context, {
    required String txt1,
    String? txt2,
    String? txt3,
  }) {
    return RichTextWidget(
      textAlign: TextAlign.start,
      texts: [
        BaseText.plain(
          text: txt1,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w300,
            color: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
        ),
        BaseText.plain(
          text: '"$txt2"',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w300,
            color: Theme.of(context).colorScheme.surfaceVariant,
          ),
        ),
        BaseText.plain(
          text: txt3 ?? '',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w300,
            color: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
        ),
      ],
    );
  }

  // Widget _buildItem(BuildContext context, {required SearchDataModel model}) {
  //   return Row(
  //     children: [
  //       SvgPicture.asset(Assets.icSearch),
  //       Gap(ScreenUtil().setWidth(Dimens.dimens_09)),
  //       Text(
  //         '',
  //         style: Theme.of(context).textTheme.bodyLarge!.copyWith(
  //           color: Theme.of(context).colorScheme.surfaceVariant,
  //           fontWeight: FontWeight.w300,
  //         ),
  //       )
  //     ],
  //   );
  // }
}
