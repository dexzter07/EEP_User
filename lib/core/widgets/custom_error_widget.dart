import 'package:epp_user/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomErrorWidget extends ConsumerWidget {
  const CustomErrorWidget({
    required this.onPressed,
    this.errorMessage,
    this.isAtCenter,
    super.key,
  });

  final String? errorMessage;
  final void Function() onPressed;
  final bool? isAtCenter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: isAtCenter == null
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Center(
          child: Text(
            'We faced some issue while processing your request',
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        InkWell(
          onTap: onPressed,
          child: Text(
            errorMessage ?? 'Retry',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: ColorConstant.primaryColor),
          ),
        )
      ],
    );
  }
}
