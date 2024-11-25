import 'package:epp_user/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 4/5/2024, Friday

final stepCounterCurrentIndexProvider = StateProvider<int>((ref) => 1);

class StepTrackerWidget extends StatelessWidget {
  const StepTrackerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomCircleIcon(
              index: 1,
              title: 'Teacher',
            ),
          ),
          Expanded(
            child: CustomCircleIcon(
              index: 2,
              title: 'School',
            ),
          ),
          CustomCircleIcon(
            index: 3,
            title: 'Principal',
          ),
        ],
      ),
    );
  }
}

class CustomCircleIcon extends ConsumerWidget {
  const CustomCircleIcon({
    super.key,
    required this.index,
    required this.title,
  });

  final int index;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndexState = ref.watch(stepCounterCurrentIndexProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstant.scaffoldColor,
                    border: Border.all(
                      color: currentIndexState > index
                          ? ColorConstant.primaryColor
                          : Colors.grey,
                    )),
                padding: const EdgeInsets.all(2),
                child: Center(
                  child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentIndexState > index
                          ? ColorConstant.primaryColor
                          : currentIndexState == index
                              ? Colors.black
                              : Colors.grey,
                    ),
                    child: Center(
                      child: currentIndexState > index
                          ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            )
                          : Text(
                              index.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                    ),
                  ),
                )),
            if (index != 3)
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  height: 1,
                  decoration: BoxDecoration(
                      color: currentIndexState > index
                          ? ColorConstant.primaryColor
                          : Colors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
          ],
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: currentIndexState == index
                    ? FontWeight.w600
                    : FontWeight.w400,
                color: currentIndexState == index ? Colors.black.withOpacity(0.75) : Colors.grey,
              ),
        ),
      ],
    );
  }
}
