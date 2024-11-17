import 'package:epp_user/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 6/14/2024, Friday

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.backgroundColor,
    this.isDisabled,
    this.padding,
    this.margin,
    this.prefixIcon,
    this.text,
    this.suffixIcon,
    this.textStyle,
    this.disabledTextStyle,
    this.onTap,
    this.isTransparentButton,
    this.borderColor,
    this.isSmallButton,
    this.isLoading,
  });

  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? backgroundColor;
  final bool? isDisabled;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final String? text;
  final Widget? prefixIcon;
  final Icon? suffixIcon;
  final TextStyle? textStyle;
  final TextStyle? disabledTextStyle;
  final void Function()? onTap;
  final bool? isTransparentButton;
  final Color? borderColor;
  final bool? isSmallButton;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          color: (isTransparentButton ?? false)
              ? backgroundColor ?? Colors.transparent
              : (isDisabled ?? false)
                  ? (backgroundColor ?? ColorConstant.primaryColor)
                      .withOpacity(0.24)
                  : backgroundColor ?? ColorConstant.primaryColor,
          borderRadius: BorderRadius.circular(
            borderRadius ?? ((isSmallButton ?? false) ? 12 : 12),
          ),
          border: Border.all(
            color: (isTransparentButton ?? false)
                ? borderColor ?? ColorConstant.primaryColor
                : Colors.transparent,
            width: (isTransparentButton ?? false) ? 1 : 0,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(
              borderRadius ?? ((isSmallButton ?? false) ? 32 : 48),
            ),
            onTap: (isDisabled ?? false) || (isLoading ?? false)
                ? () {}
                : onTap ?? () {},
            child: Container(
                height: height,
                width: width,
                padding: padding ??
                    const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                child: Row(
                  mainAxisSize: (isSmallButton ?? false)
                      ? MainAxisSize.min
                      : MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: (isLoading ?? false)
                      ? [
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        ]
                      : [
                          if (prefixIcon != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: prefixIcon!,
                            ),
                          Text(text ?? '',
                              style: textStyle ??
                                  const TextStyle(color: Colors.white)),
                          if (suffixIcon != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: suffixIcon!,
                            ),
                        ],
                )),
          ),
        ),
      ),
    );
  }
}
