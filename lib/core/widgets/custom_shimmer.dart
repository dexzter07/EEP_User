import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    this.height,
    this.width,
    this.isCircular,
    this.radius,
    this.margin,
    super.key,
  });

  final double? height;
  final double? width;
  final bool? isCircular;
  final double? radius;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.3),
        highlightColor: Colors.grey.withOpacity(0.5),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: const Color(0xffF0F2F6),
            shape: isCircular == true ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isCircular == true
                ? null
                : BorderRadius.circular(
                    radius ?? 8,
                  ),
          ),
        ),
      ),
    );
  }
}
