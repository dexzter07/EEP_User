import 'package:cached_network_image/cached_network_image.dart';
import 'package:epp_user/core/constants/color_constants.dart';
import 'package:epp_user/core/constants/image_path.dart';
import 'package:flutter/material.dart';

import 'custom_shimmer.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    this.image,
    this.isCircular = false,
    this.height,
    this.width,
    this.radius,
    super.key,
  });

  final String? image;
  final bool isCircular;
  final double? radius;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return image == null
        ? _emptyImage()
        : CachedNetworkImage(
            imageUrl: image!,
            imageBuilder: (context, imageProvider) => Container(
              height: height ?? 40,
              width: width ?? 40,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(isCircular ? 100 : radius ?? 8),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => CustomShimmer(
              height: height ?? 40,
              width: width ?? 40,
              radius: isCircular ? 100 : radius ?? 8,
            ),
            errorWidget: (context, url, error) => _emptyImage(),
          );
  }

  Container _emptyImage() {
    return Container(
      height: height ?? 40,
      width: width ?? 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isCircular ? 100 : radius ?? 8),
        border: Border.all(color: ColorConstant.textFieldColor),
        image: const DecorationImage(
          image: AssetImage(
            ImagePath.defaultUserImage,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
