import 'package:epp_user/app/routes/routes.dart';
import 'package:epp_user/core/constants/color_constants.dart';
import 'package:epp_user/core/widgets/custom_inkwell.dart';
import 'package:epp_user/features/activities/infrastructure/response/activity_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 11/25/2024, Monday

class ActivityWidget extends ConsumerWidget {
  final ActivityResponseData? activityResponseData;

  const ActivityWidget({
    this.activityResponseData,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return activityResponseData == null
        ? const SizedBox()
        : CustomInkWell(
            onTap: () {
              context.push(
                AppRoutes.activityDetailScreen,
                extra: activityResponseData,
              );
            },
            child: Container(
                margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.07),
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: const Offset(-5, 5), // changes position of shadow
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.07),
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: const Offset(5, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: activityResponseData!.id ?? 0,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(8),
                        ),
                        child: Image.network(
                          activityResponseData!.image ?? '',
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            activityResponseData!.activityTitle ?? '',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstant.primaryColor,
                                      fontSize: 16,
                                    ),
                          ),
                          Text(
                            activityResponseData!.description ?? '',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            activityResponseData!.activityDateAndTime ?? '',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Location : ${activityResponseData!.location ?? ''}",
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    )
                  ],
                )),
          );
  }
}
