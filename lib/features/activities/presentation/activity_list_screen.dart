import 'package:epp_user/core/base_class/base_state.dart';
import 'package:epp_user/core/widgets/custom_error_widget.dart';
import 'package:epp_user/core/widgets/custom_inkwell.dart';
import 'package:epp_user/core/widgets/custom_scaffold.dart';
import 'package:epp_user/features/activities/application/activity_controller.dart';
import 'package:epp_user/features/activities/infrastructure/response/activity_list_response.dart';
import 'package:epp_user/features/activities/presentation/widgets/activity_widget.dart';
import 'package:epp_user/features/bottom_navigation/presentation/bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../infrastructure/fake_data.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 11/25/2024, Monday

final fetchActivityListProvider =
    StateNotifierProvider((ref) => ActivityController(ref));

final loadMoreActivityListProvider =
    StateNotifierProvider((ref) => ActivityController(ref));

final activityListProvider =
    StateProvider<List<ActivityResponseData>>((ref) => []);

class ActivityListScreen extends ConsumerStatefulWidget {
  const ActivityListScreen({super.key});

  @override
  ConsumerState<ActivityListScreen> createState() =>
      _ActivitiesListScreenState();
}

class _ActivitiesListScreenState extends ConsumerState<ActivityListScreen> {
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    _fetchActivityList();
    super.initState();
  }

  void _fetchActivityList() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _pageNumber = 1;
      ref.read(fetchActivityListProvider.notifier).fetchActivityList();
    });
    if (ref.read(showRefreshIconInHomeScreenProvider)) {
      ref.read(showRefreshIconInHomeScreenProvider.notifier).state = false;
    }
  }

  int _pageNumber = 1;
  bool _enablePullUp = false;

  @override
  Widget build(BuildContext context) {
    final fetchActivityListApiState = ref.watch(fetchActivityListProvider);
    final activityListState = ref.watch(activityListProvider);
    final showRefreshIconState = ref.watch(showRefreshIconInHomeScreenProvider);

    ref.listen(fetchActivityListProvider, (previous, next) {
      if (next is SuccessState<ActivityListResponse>) {
        _pageNumber++;
        if (next.data.data != null && next.data.data!.length >= 5) {
          _enablePullUp = true;
        } else {
          _enablePullUp = false;
        }
        setState(() {});
      }
    });

    ref.listen(loadMoreActivityListProvider, (previous, next) {
      if (next is SuccessState<ActivityListResponse>) {
        _pageNumber++;
        if (next.data.data != null && next.data.data!.length >= 5) {
          _enablePullUp = true;
        } else {
          _enablePullUp = false;
        }
        setState(() {});
      }
    });

    return CustomScaffold(
        hideLeadingIcon: true,
        padding: EdgeInsets.zero,
        appBarTitle: 'Activity List',
        body: fetchActivityListApiState is LoadingState
            ? const Center(child: CircularProgressIndicator())
            : fetchActivityListApiState is SuccessState<ActivityListResponse>
                ? Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: showRefreshIconState ? 24 : 8,
                        ),
                        child: SmartRefresher(
                            // ignore: prefer_const_constructors
                            header: ClassicHeader(),
                            // ignore: prefer_const_constructors
                            footer: ClassicFooter(),
                            controller: _refreshController,
                            enablePullUp: _enablePullUp,
                            onRefresh: _fetchActivityList,
                            onLoading: _loadMore,
                            child: ListView.builder(
                              itemCount: activityListState.length,
                              itemBuilder: (context, index) {
                                return ActivityWidget(
                                  activityResponseData:
                                      activityListState[index],
                                );
                              },
                            )),
                      ),
                      if (showRefreshIconState)
                        CustomInkWell(
                          onTap: _fetchActivityList,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.refresh,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "Please refresh to load new content.",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        )
                    ],
                  )
                : fetchActivityListApiState is FailureState
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: CustomErrorWidget(
                            onPressed: _fetchActivityList,
                          ),
                        ),
                      )
                    : const SizedBox());
  }

  void _loadMore() {
    _refreshController.requestLoading();
    ref
        .read(loadMoreActivityListProvider.notifier)
        .loadMoreActivityList(_pageNumber);
    _refreshController.loadComplete();
  }
}
