import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theshowplayer/constants/colors.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/models/message/message_model.dart';
import 'package:theshowplayer/ui/message_detail/bloc/message_detail_bloc.dart';
import 'package:theshowplayer/ui/message_detail/component/custom_paint/lower_nip_message_clipper.dart';
import 'package:theshowplayer/ui/message_detail/message_detail_screen_mobile.dart';
import 'package:theshowplayer/widgets/image/cache_image.dart';

import '../../../../constants/enum/type_status_items.dart';

class ContentMessage extends StatelessWidget {
  const ContentMessage({super.key,});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<MessageDetailBloc, MessageDetailState>(
        buildWhen: (previous, current) => current is MessageDetailListMsgState && current != previous,
        builder: (context, state) {
          var listMsg = <MessageModel>[];
          if (state is MessageDetailListMsgState) {
            listMsg = state.listMsg ?? [];
          }
          return Column(
            children: List.generate(listMsg.length, (index) {
              final isOwner = listMsg[index].isOwnerMessage;

              return Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildContentMessage(
                  isOwner: isOwner,
                  msg: listMsg[index].content,
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Widget _buildContentMessage({bool isOwner = false, required String msg}) {
    return Padding(
      padding: EdgeInsets.only(
        left: !isOwner ? Dimens.horizontal_padding : 0,
        right: isOwner ? Dimens.horizontal_padding : 0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isOwner ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isOwner) ...[
            const CacheImage(
              image: 'https://znews-photo.zingcdn.me/w1920/Uploaded/pwivovlb/2023_03_23/1O5A2699_.jpg',
              size: Size(
                Dimens.dimens_38,
                Dimens.dimens_38,
              ),
              borderRadius: 19,
            ),
          ],
          ClipPath(
            clipper: LowerNipMessageClipper(
              isOwner ? MessageStatus.sent : MessageStatus.delivered,
            ),
            child: ContainerToClip(
              isOwner ? AppColors.redFF7B7B : AppColors.black393939,
              msg,
            ),
          )
        ],
      ),
    );
  }
}
