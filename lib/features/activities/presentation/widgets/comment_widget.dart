import 'package:epp_user/core/widgets/custom_network_image.dart';
import 'package:epp_user/features/activities/infrastructure/response/comment_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentWidget extends ConsumerWidget {
  final CommentData? commentData;

  const CommentWidget({
    this.commentData,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return commentData == null
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: CustomNetworkImage(
                    image: commentData?.userImage,
                    isCircular: true,
                    height: 32,
                    width: 32,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        commentData?.teacherName ?? '',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                      ),
                      Text(
                        commentData?.comment ?? '',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 12,
                            ),
                      )
                    ],
                  ),
                )),
              ],
            ),
          );
  }
}
