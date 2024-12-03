import 'package:epp_user/app/routes/routes.dart';
import 'package:epp_user/core/base_class/base_state.dart';
import 'package:epp_user/core/constants/color_constants.dart';
import 'package:epp_user/core/local_data_source/local_data_source.dart';
import 'package:epp_user/core/widgets/custom_button.dart';
import 'package:epp_user/core/widgets/custom_inkwell.dart';
import 'package:epp_user/core/widgets/custom_network_image.dart';
import 'package:epp_user/core/widgets/custom_scaffold.dart';
import 'package:epp_user/core/widgets/custom_shimmer.dart';
import 'package:epp_user/features/profile/application/profile_controller.dart';
import 'package:epp_user/features/profile/infrastructure/response/profile_details_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 12/3/2024, Tuesday

final fetchProfileDetailsController =
    StateNotifierProvider((ref) => ProfileController(ref));

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(fetchProfileDetailsController.notifier).fetchProfileDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileDetailState = ref.watch(fetchProfileDetailsController);
    return CustomScaffold(
      hideLeadingIcon: true,
      padding: EdgeInsets.zero,
      appBarTitle: 'Profile',
      body: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            fit: StackFit.loose,
            alignment: Alignment.center,
            children: [
              Container(
                height: 90,
                width: double.infinity,
                color: ColorConstant.statusBarColor,
              ),
              profileDetailState is LoadingState
                  ? const Positioned(
                      bottom: -40,
                      child: CustomShimmer(
                        isCircular: true,
                        height: 90,
                        width: 90,
                      ),
                    )
                  : profileDetailState is SuccessState<ProfileData?>
                      ? Positioned(
                          bottom: -40,
                          child: CustomNetworkImage(
                            image: profileDetailState.data?.userImage,
                            isCircular: true,
                            height: 90,
                            width: 90,
                          ),
                        )
                      : const SizedBox()
            ],
          ),
          profileDetailState is SuccessState<ProfileData?> &&
                  profileDetailState.data != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Center(
                        child: Text(
                          profileDetailState.data?.teacherName ?? '',
                          maxLines: 2,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Center(
                        child: Text(
                          '${profileDetailState.data?.district ?? ''}, ${profileDetailState.data?.state ?? ''}',
                          maxLines: 2,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                          child: CustomButton(
                        isSmallButton: true,
                        text: 'Edit Profile',
                        textStyle:
                            Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: ColorConstant.primaryColor,
                                  fontSize: 12,
                                ),
                        borderRadius: 6,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        isTransparentButton: true,
                        onTap: () {
                          context.push(
                            AppRoutes.profileDetailScreen,
                            extra: profileDetailState.data,
                          );
                        },
                      )),
                      const SizedBox(height: 48),
                      _getProfileOptionsWidget(
                        title: 'Settings',
                        iconData: Icons.settings,
                        onTap: () {},
                      ),
                      _getProfileOptionsWidget(
                        title: 'About us',
                        iconData: Icons.info_outline,
                        onTap: () {},
                      ),
                      _getProfileOptionsWidget(
                        title: 'Contact us',
                        iconData: Icons.call,
                        onTap: () {},
                      ),
                      _getProfileOptionsWidget(
                        title: 'Terms and Conditions',
                        iconData: Icons.mark_email_read,
                        onTap: () {},
                      ),
                      _getProfileOptionsWidget(
                        title: 'Privacy Policy',
                        iconData: Icons.bookmark_add_outlined,
                        onTap: () {},
                      ),
                      _getProfileOptionsWidget(
                        title: 'Log Out',
                        iconData: Icons.exit_to_app,
                        onTap: () {
                          ref.read(localDataSourceProvider).removeAccessToken();
                          context.go(AppRoutes.loginScreen);
                        },
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget _getProfileOptionsWidget({
    required String title,
    required IconData iconData,
    required void Function() onTap,
  }) {
    return CustomInkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
