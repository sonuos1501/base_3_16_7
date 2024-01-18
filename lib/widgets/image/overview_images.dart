// ignore_for_file: no_logic_in_create_state, avoid_dynamic_calls

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OverviewImages extends StatefulWidget {

  const OverviewImages({
    super.key,
    required this.images,
    this.initialPage = 0,
    this.imageUrl = '',
  });
  final String imageUrl;
  final List<dynamic> images;
  final int initialPage;

  @override
  State<OverviewImages> createState() => _OverviewImagesState(initialPage);
}

class _OverviewImagesState extends State<OverviewImages> {

  _OverviewImagesState(int index) {
    _controller = PageController(initialPage: index);
  }

  late PageController _controller;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: PageView(
        controller: _controller,
        children: List.generate(
          widget.images.length,
          (index) => InteractiveViewer(
            maxScale: 3,
            child: _buildItem(context, index),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if (widget.images[index] == null) {
      return const SizedBox();
    }
    if (widget.images[index].runtimeType == String) {
      return _buildCacheImage(context, widget.images[index]);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(
        widget.images[index],
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildCacheImage(BuildContext context, String name) {
    if (name == '') {
      return const SizedBox();
    }

    return CachedNetworkImage(
      imageUrl: '${widget.imageUrl}$name',
      fit: BoxFit.contain,
      errorWidget: (context, url, error) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          color: Colors.black,
          child: SvgPicture.asset(
            'assets/images/icons/ic_error_loading.svg',
            height: 80,
            color: Theme.of(context).hintColor,
          ),
        );
      },
    );
  }
}
