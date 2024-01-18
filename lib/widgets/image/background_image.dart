import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../button/common_button.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    super.key,
    this.element,
    this.onPress,
    this.size = 110,
    this.colorSelected,
    this.isError = false,
  });

  final Widget? element;
  final AsyncCallback? onPress;
  final double size;
  final Color? colorSelected;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      onPress: onPress,
      child: Stack(
        children: [
          Container(
            width: size,
            height: size,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: isError ? Colors.red : Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  color: Theme.of(context).shadowColor,
                )
              ],
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                // color: const Color(0xFF5AC8FA).withOpacity(0.15),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: element,
            ),
          ),
          if (colorSelected != null)
            Positioned(
              right: 0,
              child: CircleAvatar(
                radius: size * 0.12,
                backgroundColor: colorSelected,
                child: Icon(
                  Icons.done,
                  size: size * 0.15,
                  color: Colors.white,
                ),
              ),
            )
        ],
      ),
    );
  }
}
