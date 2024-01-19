// ignore_for_file: inference_failure_on_untyped_parameter, sized_box_shrink_expand, inference_failure_on_function_return_type

import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../gen/assets.gen.dart';

class CacheImage extends StatelessWidget {
  const CacheImage({
    super.key,
    required this.image,
    required this.size,
    this.backgroundColor,
    this.borderRadius = 8,
    this.errorLoadingImage,
    this.imageBuilder,
    this.color,
    this.colorBlendMode,
  });
  final String image;
  final Size size;
  final Color? backgroundColor;
  final double borderRadius;
  final String? errorLoadingImage;
  final Function(BuildContext context, ImageProvider imageProvider)?
      imageBuilder;
  final Color? color;
  final BlendMode? colorBlendMode;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: (image.contains('http://') || image.contains('https://'))
            ? CachedNetworkImage(
                color: color,
                colorBlendMode: colorBlendMode,
                imageUrl: image,
                fit: BoxFit.cover,
                imageBuilder: imageBuilder == null
                    ? null
                    : (context, imageProvider) {
                        return imageBuilder!(context, imageProvider);
                      },
                placeholder: (context, url) {
                  return Shimmer.fromColors(
                    baseColor: Theme.of(context).dividerColor,
                    highlightColor: Theme.of(context)
                        .colorScheme
                        .surfaceVariant
                        .withOpacity(0.5),
                    child: ColoredBox(
                      color: backgroundColor ??
                          Theme.of(context).colorScheme.onTertiaryContainer,
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return ColoredBox(
                    color: backgroundColor ??
                        Theme.of(context).colorScheme.onTertiaryContainer,
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                        child: SvgPicture.asset(
                          errorLoadingImage ?? Assets.icons.icErrorLoadingImage.path,
                          height: min(80, size.height * .65),
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  );
                },
              )
            : Image.file(
                File(image),
                color: color,
                colorBlendMode: colorBlendMode,
                fit: BoxFit.cover,
                cacheHeight: 1000,
                errorBuilder: (context, error, stackTrace) {
                  return ColoredBox(
                    color: backgroundColor ??
                        Theme.of(context).colorScheme.onTertiaryContainer,
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                        child: SvgPicture.asset(
                          errorLoadingImage ?? Assets.icons.icErrorLoadingImage.path,
                          height: min(80, size.height * .65),
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
