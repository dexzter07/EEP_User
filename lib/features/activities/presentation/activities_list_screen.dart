import 'package:epp_user/core/base_class/base_state.dart';
import 'package:epp_user/core/widgets/custom_scaffold.dart';
import 'package:epp_user/features/activities/application/activity_controller.dart';
import 'package:epp_user/features/activities/presentation/widgets/activity_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../infrastructure/fake_data.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 11/25/2024, Monday

final fetchActivityListProvider =
    StateNotifierProvider((ref) => ActivityController(ref));

class ActivitiesListScreen extends ConsumerStatefulWidget {
  const ActivitiesListScreen({super.key});

  @override
  ConsumerState<ActivitiesListScreen> createState() =>
      _ActivitiesListScreenState();
}

class _ActivitiesListScreenState extends ConsumerState<ActivitiesListScreen> {
  @override
  void initState() {
    // _fetchActivityList();
    super.initState();
  }

  void _fetchActivityList() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(fetchActivityListProvider.notifier).fetchActivityList(1, 1);
    });
  }

  final activityList = activityResponseDataList;

  @override
  Widget build(BuildContext context) {
    final fetchActivityListApiState = ref.watch(fetchActivityListProvider);
    return CustomScaffold(
        hideLeadingIcon: true,
        padding: const EdgeInsets.only(top: 16),
        appBarTitle: 'Activity List',
        body: fetchActivityListApiState is LoadingState
            ? const Center(child: CircularProgressIndicator())
            : fetchActivityListApiState is SuccessState
                ? ListView.builder(
                    itemCount: activityList.length,
                    itemBuilder: (context, index) {
                      return ActivityWidget(
                        activityResponseData: activityList[index],
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: activityList.length,
                    itemBuilder: (context, index) {
                      return ActivityWidget(
                        activityResponseData: activityList[index],
                      );
                    },
                  )
/*        Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: CustomErrorWidget(
                        onPressed: _fetchActivityList,
                      ),
                    ),
                  )*/
        );
  }
}
