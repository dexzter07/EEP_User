import 'package:flutter/material.dart';

class CustomCloseButton extends StatelessWidget {
  const CustomCloseButton({
    this.onTap,
    super.key,
    this.circleBackgroundColor,
    this.closeIconColor,
    this.padding,
  });

  final Color? circleBackgroundColor;
  final Color? closeIconColor;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap ??
          () {
            Navigator.of(context).pop();
          },
      child: Padding(
        padding: padding ?? const EdgeInsets.only(right: 0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: circleBackgroundColor ?? Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.close,
                size: 22,
                color: closeIconColor ?? Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
