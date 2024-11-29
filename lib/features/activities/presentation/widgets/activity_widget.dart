import 'package:epp_user/app/routes/routes.dart';
import 'package:epp_user/core/constants/color_constants.dart';
import 'package:epp_user/core/widgets/custom_inkwell.dart';
import 'package:epp_user/core/widgets/custom_network_image.dart';
import 'package:epp_user/features/activities/infrastructure/response/activity_list_response.dart';
import 'package:epp_user/features/activities/presentation/activity_comment_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 11/25/2024, Monday

class ActivityWidget extends ConsumerStatefulWidget {
  final ActivityResponseData? activityResponseData;

  const ActivityWidget({
    this.activityResponseData,
    super.key,
  });

  @override
  ConsumerState<ActivityWidget> createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends ConsumerState<ActivityWidget> {
  bool? _isLiked;
  int? _likeCount;

  @override
  void initState() {
    setState(() {
      _isLiked = widget.activityResponseData?.isLiked ?? false;
      _likeCount = widget.activityResponseData?.totalLikes ?? 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.activityResponseData == null
        ? const SizedBox()
        : Container(
            margin: const EdgeInsets.only(bottom: 16),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  _teacherProfileAndNameWidget(context),
                  const SizedBox(height: 8),
                  _activityTitleWidget(context),
                  const SizedBox(height: 8),
                  _activityImageWidget(),
                  Row(
                    children: [
                      CustomInkWell(
                        onTap: () {
                          setState(() {
                            _isLiked = !(_isLiked ?? false);
                            if (_isLiked == true) {
                              _likeCount = (_likeCount ?? 0) + 1;
                            } else {
                              _likeCount = (_likeCount ?? 0) - 1;
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 2),
                          child: Row(
                            children: [
                              Icon(
                                (_isLiked ?? false)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color:
                                    ColorConstant.primaryColor.withOpacity(0.8),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '$_likeCount Likes',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: ColorConstant.greyTextColor,
                                      fontSize: 12,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      CustomInkWell(
                        onTap: () {
                          if (widget.activityResponseData?.id != null) {
                            ActivityCommentSheet.showSheet(
                              context,
                              widget.activityResponseData!.id!,
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 2),
                          child: Row(
                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                color:
                                    ColorConstant.primaryColor.withOpacity(0.8),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${widget.activityResponseData!.totalLikes ?? 0} Comments',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: ColorConstant.greyTextColor,
                                      fontSize: 12,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  const SizedBox(height: 6),
                  CustomInkWell(
                    onTap: () {
                      if (widget.activityResponseData?.id != null) {
                        ActivityCommentSheet.showSheet(
                          context,
                          widget.activityResponseData!.id!,
                        );
                      }
                    },
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.transparent,
                            border:
                                Border.all(color: ColorConstant.textFieldColor),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          child: Text(
                            'Write a comment',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: const Color(0xFFa3a1a3),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ));
  }

  Widget _activityImageWidget() {
    return widget.activityResponseData?.image == null
        ? const SizedBox()
        : CustomInkWell(
            onTap: _navigateToActivityDetailScreen,
            child: Hero(
              tag: widget.activityResponseData!.id ?? 0,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CustomNetworkImage(
                    image: widget.activityResponseData?.image,
                    radius: 8,
                    height: 180,
                    width: double.infinity,
                  )),
            ),
          );
  }

  void _navigateToActivityDetailScreen() {
    context.push(
      AppRoutes.activityDetailScreen,
      extra: widget.activityResponseData,
    );
  }

  Padding _activityTitleWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        widget.activityResponseData!.activityTitle ?? '',
        maxLines: 2,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 14,
            ),
      ),
    );
  }

  Widget _teacherProfileAndNameWidget(BuildContext context) {
    return Row(
      children: [
        CustomNetworkImage(
          image: widget.activityResponseData?.userImage,
          isCircular: true,
        ),
        const SizedBox(width: 8),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.activityResponseData!.activityTitle ?? '',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 14,
                  ),
            ),
            Text(
              widget.activityResponseData!.activityTitle ?? '',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: ColorConstant.greyTextColor,
                    fontSize: 12,
                  ),
            ),
          ],
        ))
      ],
    );
  }
}
