import 'package:flutter/cupertino.dart';

import '../constants/image_path.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 6/15/2024, Saturday

class CustomAssetImage extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const CustomAssetImage(
    this.path, {
    this.height,
    this.width,
    this.fit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      height: height ?? 16,
      width: width ?? 16,
      fit: fit ?? BoxFit.fill,
      errorBuilder: (_, __, ___) {
        return Image.asset(
          ImagePath.defaultUserImage,
          height: height ?? 16,
          width: width ?? 16,
          fit: fit ?? BoxFit.cover,
        );
      },
    );
  }
}
