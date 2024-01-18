import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../button/common_button.dart';
import '../button/contained_button.dart';
import 'cache_image.dart';

class ViewImage extends StatefulWidget {
  const ViewImage({
    super.key,
    required this.content,
    required this.title,
    required this.images,
    this.onPress,
  });

  final String content;
  final String title;
  final String images;
  final AsyncCallback? onPress;

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(10),
          child: WillPopScope(
            onWillPop: () async {
              Navigator.of(context).pop(false);
              return true;
            },
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                CacheImage(
                  image: widget.images,
                  size: Size(double.infinity,
                      MediaQuery.of(context).size.height * .78),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: CommonButton(
                          onPress: () async {
                            Navigator.of(context).pop(false);
                          },
                          child: Text(
                            'Đóng',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      if (widget.onPress != null)
                        Expanded(
                          child: ContainedButton(
                            title: 'Xoá ảnh',
                            onPress: () async {
                              Navigator.of(context).pop(true);
                              await widget.onPress!();
                            },
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
