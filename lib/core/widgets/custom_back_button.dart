import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'custom_inkwell.dart';

class CustomIconContainer extends ConsumerWidget {
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Icon? icon;
  final void Function()? onTap;

  const CustomIconContainer({
    this.height,
    this.width,
    this.backgroundColor,
    this.icon,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomInkWell(
      onTap: onTap ?? Navigator.of(context).pop,
      child: Container(
        height: height ?? 48,
        width: width ?? 48,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.grey.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: icon ??
              Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black.withOpacity(0.7),
              ),
        ),
      ),
    );
  }
}
