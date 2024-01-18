// ignore_for_file: cascade_invocations

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

@immutable
class BaseText {

  const BaseText({
    required this.text,
    this.maxLines,
    this.style,
  });

  factory BaseText.link({
    required String text,
    required VoidCallback onTapped,
    int? maxLines,
    TextStyle? style = const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),
  }) => LinkText(
    text: text,
    onTapped: onTapped,
    style: style,
    maxLines: maxLines,
  );

  factory BaseText.plain({
    required String text,
    int? maxLines,
    TextStyle? style = const TextStyle(),
  }) => BaseText(
    text: text,
    style: style,
    maxLines: maxLines,
  );

  final String text;
  final TextStyle? style;
  final int? maxLines;
}

@immutable
class LinkText extends BaseText {
  const LinkText({
    required super.text,
    required this.onTapped,
    super.maxLines,
    super.style,
  });
  final VoidCallback onTapped;
}

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    super.key,
    required this.texts,
    this.textAlign = TextAlign.start,
    this.styleForAll,
  });
  final TextStyle? styleForAll;
  final TextAlign textAlign;
  final Iterable<BaseText> texts;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        children: texts.map(
          (baseText) {
            if (baseText is LinkText) {
              final textLink = TextSpan(
                text: baseText.text,
                style: (styleForAll ?? const TextStyle()).merge(baseText.style),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    baseText.onTapped();
                  },
              );

              if (baseText.maxLines != null) {
                return _texSpaceHaveMaxLines(context, textSpan: textLink, maxLines: baseText.maxLines!);
              }

              return textLink;
            } else {
              final textSpan = TextSpan(
                text: baseText.text,
                style: (styleForAll ?? const TextStyle()).merge(baseText.style),
              );

              if (baseText.maxLines != null) {
                return _texSpaceHaveMaxLines(context, textSpan: textSpan, maxLines: baseText.maxLines!);
              }

              return textSpan;
            }
          },
        ).toList(),
      ),
    );
  }

  TextSpan _texSpaceHaveMaxLines(BuildContext context, { required TextSpan textSpan, required int maxLines }) {
    final textPainter = TextPainter(
      text: textSpan,
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    );
    final maxWidth = MediaQuery.of(context).size.width;
    textPainter.layout(maxWidth: maxWidth);
    if (textPainter.didExceedMaxLines) {
      final lastCharaterIndex = textPainter.getPositionForOffset(Offset(maxWidth, textPainter.size.height)).offset;
      final textSpanUseEllipsis = TextSpan(
        text: '${textSpan.text?.substring(0, lastCharaterIndex)}... ',
        style: textSpan.style,
      );

      return textSpanUseEllipsis;
    }
    return textSpan;
  }

}
