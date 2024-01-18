import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:theshowplayer/constants/assets.dart';
import 'package:theshowplayer/constants/colors.dart';
import 'package:theshowplayer/constants/dimens.dart';
import 'package:theshowplayer/models/message/message_model.dart';
import 'package:theshowplayer/ui/message_detail/bloc/message_detail_bloc.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/utils/regex/regex.dart';
import 'package:theshowplayer/widgets/input/basic_text_field.dart';

import '../../../../constants/enum/type_status_items.dart';

class InputMessage extends StatefulWidget {
  const InputMessage({super.key, this.ontapEmoji});
  final void Function()? ontapEmoji;

  @override
  State<InputMessage> createState() => _InputMessageState();
}

class _InputMessageState extends State<InputMessage> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.text != '') {
        BlocProvider.of<MessageDetailBloc>(context).add(const MessageDetailEvent.hasMessage(hasMessage: true));
      } else {
        BlocProvider.of<MessageDetailBloc>(context).add(const MessageDetailEvent.hasMessage(hasMessage: false));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: dummy regex textfield
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
      child: BasicTextField(
        regexConfig: RegexConstant.email,
        controller: _controller,
        fillColor: Theme.of(context).colorScheme.background,
        hintText: 'enter_message'.tr(context),
        suffixIcon: _buildSuffixIconInputMessage(context),
      ),
    );
  }

  Widget _buildSuffixIconInputMessage(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(ScreenUtil().setWidth(Dimens.dimens_12)),
            BlocBuilder<MessageDetailBloc, MessageDetailState>(
              buildWhen: (previous, current) => current is MessageDetailHasMsgState && current != previous,
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    final msg = MessageModel(
                      id: '4',
                      type: MessageType.text,
                      content: _controller.text,
                    );

                    BlocProvider.of<MessageDetailBloc>(context).add(MessageDetailEvent.addMsg(msg: msg));
                    _controller.clear();
                  },
                  child: SvgPicture.asset(
                    Assets.icSendMessage,
                    color: state is MessageDetailHasMsgState
                      ? (state.hasMsg
                        ? AppColors.redFF5252
                        : AppColors.greyCACACA)
                      : AppColors.greyCACACA,
                  ),
                );
              },
            ),
            Gap(ScreenUtil().setWidth(Dimens.dimens_12)),
          ],
        ),
      ],
    );
  }
}
