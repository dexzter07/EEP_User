import 'package:epp_user/core/widgets/custom_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/color_constants.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 9/13/2024, Friday

class CustomScaffold extends StatelessWidget {
  final String? appBarTitle;
  final Widget? appBarActionButton;
  final EdgeInsets? padding;
  final Widget body;
  final Widget? floatingActionButton;
  final bool hideLeadingIcon;
  final bool centerTitle;
  final bool enableSafeArea;
  final Color? backgroundColor;
  final void Function()? onLeadingIconPress;

  const CustomScaffold({
    required this.body,
    this.padding,
    this.appBarTitle,
    this.appBarActionButton,
    this.floatingActionButton,
    this.hideLeadingIcon = false,
    this.centerTitle = true,
    this.enableSafeArea = true,
    this.onLeadingIconPress,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: enableSafeArea,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: appBarTitle == null
            ? null
            : AppBar(
                elevation: 4,
                centerTitle: centerTitle,
                title: Text(
                  appBarTitle ?? '',
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
                leading: hideLeadingIcon
                    ? const SizedBox()
                    : CustomInkWell(
                        onTap: onLeadingIconPress ?? context.pop,
                        child: const Icon(Icons.arrow_back, size: 20),
                      ),
                backgroundColor: ColorConstant.scaffoldColor,
                actions: [appBarActionButton ?? const SizedBox()],
              ),
        backgroundColor: backgroundColor ?? ColorConstant.scaffoldColor,
        body: Padding(
          padding:
              padding ?? const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: body,
        ),
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
