import 'package:epp_user/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'custom_asset_image.dart';

class CustomCircularContainerWidget extends ConsumerWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? backgroundColor;

  const CustomCircularContainerWidget({
    required this.imagePath,
    this.height,
    this.width,
    this.fit,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        height: height ?? 48,
        width: width ?? 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? ColorConstant.primaryColor,
        ),
        child: CustomAssetImage(
          imagePath,
          fit: fit ?? BoxFit.fill,
        ));
  }
}
