import 'package:epp_user/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 6/16/2024, Sunday

class CustomTitleSubtitleWidget extends ConsumerWidget {
  final String title;
  final String subTitle;
  final bool isTitleCenter;
  final TextStyle? titleTextStyle;
  final TextStyle? subTitleTextStyle;
  final double? spacingBetweenTitleAndSubtitle;

  const CustomTitleSubtitleWidget({
    required this.title,
    required this.subTitle,
    this.isTitleCenter = false,
    this.titleTextStyle,
    this.subTitleTextStyle,
    this.spacingBetweenTitleAndSubtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          isTitleCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleTextStyle ??
              Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
        ),
        SizedBox(height: spacingBetweenTitleAndSubtitle ?? 12),
        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: subTitleTextStyle ??
              Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
        ),
        const Row(),
      ],
    );
  }
}
