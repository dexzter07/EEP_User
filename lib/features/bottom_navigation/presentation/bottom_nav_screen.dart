import 'package:epp_user/app/routes/routes.dart';
import 'package:epp_user/core/constants/color_constants.dart';
import 'package:epp_user/features/activities/application/activity_controller.dart';
import 'package:epp_user/features/activities/presentation/activities_list_screen.dart';
import 'package:epp_user/features/resources/presentation/resources_screen.dart';
import 'package:epp_user/features/temp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 11/17/2024, Sunday

final fetchDropDownListProvider =
    StateNotifierProvider((ref) => ActivityController(ref));

class BottomNavScreen extends ConsumerStatefulWidget {
  const BottomNavScreen({super.key});

  @override
  ConsumerState<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends ConsumerState<BottomNavScreen> {
  int _index = 0;
  final List<Widget> _screenList = const [
    ActivitiesListScreen(),
    ResourcesScreen(),
    TempScreen(),
    ResourcesScreen(),
  ];

  @override
  void initState() {
    _changeStatusBarColor();
    ref.read(fetchDropDownListProvider.notifier).fetchActivityDropdownList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenList[_index],
      bottomNavigationBar: _bottomNavBarWidget(context),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.push(
              AppRoutes.createActivityScreen,
            );
          },
          backgroundColor: ColorConstant.primaryColor,
          label: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_circle_outlined,
                size: 24,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Text(
                'Add New',
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          )),
    );
  }

  BottomNavigationBar _bottomNavBarWidget(BuildContext context) {
    return BottomNavigationBar(
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        iconSize: 25,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        selectedItemColor: ColorConstant.primaryColor,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
        selectedLabelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
        items: <BottomNavigationBarItem>[
          _customBottomNavigationBarItem(
            Icons.home_filled,
            'Home',
          ),
          _customBottomNavigationBarItem(
            Icons.area_chart,
            'Resources',
          ),
          _customBottomNavigationBarItem(
            Icons.local_activity_outlined,
            'Activities',
          ),
          _customBottomNavigationBarItem(
            Icons.person_2_rounded,
            'Profile',
          ),
        ],
        currentIndex: _index,
        onTap: (int index) {
          setState(() {
            _index = index;
          });
        });
  }

  BottomNavigationBarItem _customBottomNavigationBarItem(
    IconData icon,
    String title,
  ) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(
          bottom: 6,
        ),
        child: Icon(
          icon,
        ),
      ),
      label: title,
    );
  }

  void _changeStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorConstant.statusBarColor,
        statusBarIconBrightness: Brightness.dark, // For Android
        statusBarBrightness: Brightness.dark, // For IOS
      ),
    );
  }
}
