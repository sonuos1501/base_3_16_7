import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({ super.key, this.backgroundColor });

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        color: backgroundColor ?? Theme.of(context).colorScheme.surfaceVariant,
      ),
    );
  }
}
