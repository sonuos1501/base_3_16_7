import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatefulWidget {

  const CommonButton({super.key, this.onPress, required this.child});
  final Widget child;
  final AsyncCallback? onPress;

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  bool _condition = true;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: widget.key,
      onTap: widget.onPress == null ? null : checkCondition,
      child: widget.child,
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
