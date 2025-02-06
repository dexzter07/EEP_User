import 'package:epp_user/core/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../infrastructure/response/activity_list_response.dart';

class ActivityDetailScreen extends ConsumerStatefulWidget {
  final ActivityResponseData? activityResponseData;

  const ActivityDetailScreen({
    this.activityResponseData,
    super.key,
  });

  @override
  ConsumerState<ActivityDetailScreen> createState() =>
      _ActivityDetailScreenState();
}

class _ActivityDetailScreenState extends ConsumerState<ActivityDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: widget.activityResponseData?.activityTitle ?? '',
      padding: const EdgeInsets.only(bottom: 16),
      body: widget.activityResponseData == null
          ? const SizedBox()
          : ListView(
              children: [
                Hero(
                  tag: widget.activityResponseData!.id ?? 0,
                  child: Image.network(
                    widget.activityResponseData!.image ?? '',
                    height: 320,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Text(
                        widget.activityResponseData!.description ?? '',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
