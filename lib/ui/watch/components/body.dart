import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/app_text_styles.dart';
import 'package:theshowplayer/constants/app_theme.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/di/service_locator.dart';
import 'package:theshowplayer/ui/watch/bloc/watch_bloc.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/components/video_items.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final data2 = [
      VideoItems(
        avatar:'https://images.unsplash.com/photo-1574539602047-548bf9557352?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c2V4eSUyMGdpcmx8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
        imageBackground:'https://images.unsplash.com/photo-1574539602047-548bf9557352?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c2V4eSUyMGdpcmx8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
        name: 'Putin',
        onPress: () async {},
        onPressSettings: () async {},
        time: '00:00:00',
        title: 'Sexy black bikini kasama ang Korean girl [4K UHD]',
        pathVideo: 'http://techslides.com/demos/sample-videos/small.mp4',
      ),
      VideoItems(
        avatar: 'https://images.unsplash.com/photo-1506795660198-e95c77602129?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8c2V4eSUyMGdpcmx8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
        imageBackground: 'https://images.unsplash.com/photo-1506795660198-e95c77602129?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8c2V4eSUyMGdpcmx8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
        name: 'Putin',
        onPress: () async {},
        onPressSettings: () async {},
        time: '00:00:00',
        title: 'Sexy black bikini kasama ang Korean girl [4K UHD]',
        pathVideo: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding).copyWith(top: Dimens.dimens_08),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'next_video'.tr(context),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  fontWeight: AppThemeData.medium,
                ),
              ),
              const Spacer(),
              Text(
                'auto_play'.tr(context),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  fontWeight: FontWeight.w300,
                  fontSize: AppTextStyles.fontSize_13,
                ),
              ),
              const Gap(Dimens.dimens_08),
              BlocBuilder<WatchBloc, WatchState>(
                buildWhen: (previous, current) => current is AutoPlayWatchState && current != previous,
                builder: (context, state) {
                  return CupertinoSwitch(
                    value: state is AutoPlayWatchState ? state.autoPlay : true,
                    activeColor: Theme.of(context).primaryColor,
                    trackColor: Theme.of(context).colorScheme.surfaceTint,
                    onChanged: (bool value) {
                      sl.get<WatchBloc>().add(WatchEvent.autoPlay(autoPlay: value));
                    },
                  );
                },
              ),
            ],
          ),
          const Gap(Dimens.dimens_08),
          ...List.generate(data2.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: VideoItems(
                imageBackground: data2[index].imageBackground,
                avatar: data2[index].avatar,
                name: data2[index].name,
                time: data2[index].time,
                title: data2[index].title,
                onPressSettings: () async {},
                onPress: () async {},
              ),
            );
          })
        ],
      ),
    );
  }
}
