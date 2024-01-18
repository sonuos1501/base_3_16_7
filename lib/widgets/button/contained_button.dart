// ignore_for_file: avoid_multiple_declarations_per_line

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ContainedButton extends StatefulWidget {
  const ContainedButton({
    super.key,
    required this.title,
    this.onPress,
    this.color,
    this.borderRadius,
    this.padding,
    this.size,
    this.textStyle,
    this.colorTitle,
    this.elevation,
  });

  final String title;
  final AsyncCallback? onPress;
  final Color? color, colorTitle;
  final double? borderRadius, elevation;
  final EdgeInsetsGeometry? padding;
  final Size? size;
  final TextStyle? textStyle;

  @override
  State<ContainedButton> createState() => _ContainedButtonState();
}

class _ContainedButtonState extends State<ContainedButton> {
  bool _condition = true;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: widget.size,
        backgroundColor: widget.color,
        elevation: widget.elevation ?? 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
        ),
        padding: widget.padding,
      ),
      onPressed: widget.onPress != null ? checkCondition : null,
      child: Text(
        widget.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: widget.textStyle ?? Theme.of(context).textTheme.labelMedium!.copyWith(color: widget.colorTitle),
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
