import 'package:epp_user/core/base_class/base_state.dart';
import 'package:epp_user/core/constants/color_constants.dart';
import 'package:epp_user/core/widgets/custom_asset_image.dart';
import 'package:epp_user/core/widgets/custom_close_button.dart';
import 'package:epp_user/core/widgets/custom_shimmer.dart';
import 'package:epp_user/core/widgets/custom_textfield.dart';
import 'package:epp_user/features/activities/application/activity_controller.dart';
import 'package:epp_user/features/activities/infrastructure/response/comment_list_response.dart';
import 'package:epp_user/features/activities/presentation/widgets/comment_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fetchActivityCommentListProvider =
    StateNotifierProvider((ref) => ActivityController(ref));

class ActivityCommentSheet {
  static void showSheet(BuildContext context, int activityId) {
    showModalBottomSheet<dynamic>(
      context: context,
      backgroundColor: ColorConstant.scaffoldColor,
      isScrollControlled: true,
      builder: (context) {
        return ActivityCommentScreen(activityId: activityId);
      },
    );
  }
}

class ActivityCommentScreen extends ConsumerStatefulWidget {
  const ActivityCommentScreen({
    required this.activityId,
    super.key,
  });

  final int activityId;

  @override
  ConsumerState<ActivityCommentScreen> createState() =>
      _ActivityCommentScreenState();
}

class _ActivityCommentScreenState extends ConsumerState<ActivityCommentScreen> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _fetchCommentList();
    super.initState();
  }

  void _fetchCommentList() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(fetchActivityCommentListProvider.notifier)
          .fetchCommentList(widget.activityId);
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fetchCommentListState = ref.watch(fetchActivityCommentListProvider);
    return Container(
      decoration: BoxDecoration(
        color: ColorConstant.scaffoldColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      height: MediaQuery.sizeOf(context).height * 0.9,
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "  Comments",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              CustomCloseButton(),
            ],
          ),
          const SizedBox(height: 24),
          fetchCommentListState is LoadingState
              ? _loadingState()
              : fetchCommentListState is SuccessState<List<CommentData>?>
                  ? (fetchCommentListState.data?.length ?? 0) == 0
                      ? _emptyCommentWidget(context)
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: fetchCommentListState.data?.length,
                            itemBuilder: (context, index) {
                              return CommentWidget(
                                commentData: fetchCommentListState.data?[index],
                              );
                            },
                          ),
                        )
                  : _emptyCommentWidget(context),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: CustomTextField(
                controller: _textEditingController,
                labelText: 'Write a comment',
              )),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
                  child: Icon(
                    Icons.send,
                    color: ColorConstant.primaryColor.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6)
        ],
      ),
    );
  }

  Widget _emptyCommentWidget(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomAssetImage(
            'assets/images/empty_comment.png',
            height: 120,
            width: 240,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 12),
          Text(
            "No comments yet",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: ColorConstant.greyTextColor,
                ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _loadingState() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomShimmer(
                  height: 40,
                  isCircular: true,
                  width: 40,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: CustomShimmer(
                    height: 60,
                    width: 100,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
