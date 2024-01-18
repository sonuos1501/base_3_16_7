// ignore_for_file: use_named_constants

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/assets.dart';
import '../button/common_button.dart';
import 'cache_image.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({
    super.key,
    required this.images,
    this.size,
    this.backgroundColor,
    this.navigatorOverview = true,
  });
  final List<String> images;
  final Size? size;
  final Color? backgroundColor;
  final bool navigatorOverview;

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  Timer? timer;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (_currentIndex == widget.images.length - 1) {
          _currentIndex = 0;
          _pageController.jumpToPage(_currentIndex);
        } else {
          _currentIndex++;
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        }
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    timer!.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size?.width ?? double.infinity,
      height: widget.size?.height ?? double.infinity,
      child: Stack(
        children: [
          _buildPageView(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _buildIndicator(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageView() {
    if (widget.images.isEmpty) {
      return _buildImageDefault(context);
    }
    return PageView(
      controller: _pageController,
      onPageChanged: (value) {
        setState(() {
          _currentIndex = value;
        });
      },
      children: List.generate(
        widget.images.length,
        (index) => CommonButton(
          onPress: !widget.navigatorOverview ? null : () async {},
          child: CacheImage(
            image: widget.images[index],
            size: const Size(double.infinity, double.infinity),
            backgroundColor: widget.backgroundColor,
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator(BuildContext context) {
    if (widget.images.length <= 1) {
      return const SizedBox();
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 320),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Row(
        children: List.generate(widget.images.length, (index) {
          return Container(
            margin: index != widget.images.length - 1
                ? const EdgeInsets.only(right: 4)
                : null,
            child: CircleAvatar(
              backgroundColor:
                  index == _currentIndex ? Colors.white : Colors.grey,
              radius: 3,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildImageDefault(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: ColoredBox(
        color:
            widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: SvgPicture.asset(
            Assets.icErrorLoadingImage,
            height: 80,
            color: Theme.of(context).disabledColor,
          ),
        ),
      ),
    );
  }
}
