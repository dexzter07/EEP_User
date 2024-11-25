import 'package:epp_user/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'custom_textfield_border.dart';

class CustomDropdownButton extends ConsumerStatefulWidget {
  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.onChanged,
    required this.value,
    this.labelText,
    this.borderColor,
    this.hint,
    this.inputTextStyle,
    this.borderRadius,
    this.validator,
    this.autovalidateMode,
  });

  final List<DropdownMenuItem<Object>>? items;
  final void Function(Object?)? onChanged;
  final Color? borderColor;
  final dynamic value;
  final String? labelText;
  final Widget? hint;
  final TextStyle? inputTextStyle;
  final double? borderRadius;
  final String? Function(Object? value)? validator;
  final AutovalidateMode? autovalidateMode;

  @override
  CustomDropdownButtonState createState() => CustomDropdownButtonState();
}

class CustomDropdownButtonState extends ConsumerState<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      validator: widget.validator,
      hint: widget.hint,
      autovalidateMode: widget.autovalidateMode,
      style: Theme.of(context).textTheme.bodyMedium,
      items: widget.items,
      onChanged: widget.onChanged,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.grey,
      ),
      value: widget.value,
      isExpanded: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorConstant.textFieldColor,
        labelText: widget.labelText,
        border: InputBorder.none,
        errorBorder: CustomTextFieldBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
          borderSide: BorderSide(
            color: ColorConstant.textFieldColor,
          ),
          borderColor: Colors.red,
        ),
        enabledBorder: CustomTextFieldBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
          borderSide: BorderSide(
            color: widget.borderColor ?? ColorConstant.textFieldColor,
          ),
          borderColor: widget.borderColor ?? Colors.transparent,
        ),
        focusedBorder: CustomTextFieldBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
          borderSide: BorderSide(
            color: widget.borderColor ?? ColorConstant.textFieldColor,
          ),
          borderColor: widget.borderColor ?? Colors.transparent,
        ),
        focusedErrorBorder: CustomTextFieldBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
          borderSide: BorderSide(
            color: ColorConstant.textFieldColor,
          ),
          borderColor: Colors.red,
        ),
        disabledBorder: CustomTextFieldBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
          borderSide: BorderSide(
            color: ColorConstant.textFieldColor,
          ),
          borderColor: Colors.transparent,
        ),
        labelStyle: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: Colors.grey),
        helperStyle: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: const Color(0xFFa3a1a3)),
      ),
    );
  }
}
