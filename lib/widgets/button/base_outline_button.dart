// ignore_for_file: avoid_multiple_declarations_per_line

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BaseOutlineButton extends StatefulWidget {
  const BaseOutlineButton({
    super.key,
    required this.title,
    this.onPress,
    this.borderRadius,
    this.padding,
    this.size,
    this.backgroundColor,
    this.colorBorderAndTitle,
    this.elevation,
  });
  final String title;
  final AsyncCallback? onPress;
  final double? borderRadius, elevation;
  final EdgeInsetsGeometry? padding;
  final Size? size;
  final Color? backgroundColor, colorBorderAndTitle;

  @override
  State<BaseOutlineButton> createState() => _BaseOutlineButtonState();
}

class _BaseOutlineButtonState extends State<BaseOutlineButton> {
  bool _condition = true;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: widget.backgroundColor,
        minimumSize: widget.size,
        elevation: widget.elevation ?? 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.borderRadius ?? 12)),
        padding: widget.padding,
        side: widget.onPress != null ? BorderSide(width: 1.5, color: widget.colorBorderAndTitle ?? Theme.of(context).colorScheme.primary) : null,
      ),
      onPressed: widget.onPress != null ? checkCondition : null,
      child: Text(
        widget.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(color: widget.colorBorderAndTitle ?? Theme.of(context).colorScheme.primary),
      ),
    );
  }

  Future<void> checkCondition() async {
    if (!_condition) {
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    _condition = false;
    await widget.onPress!().then((value) {
      _condition = true;
    });
  }
}
