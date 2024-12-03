import 'package:epp_user/app/routes/routes.dart';
import 'package:epp_user/features/activities/infrastructure/response/activity_list_response.dart';
import 'package:epp_user/features/activities/presentation/activity_detail_screen.dart';
import 'package:epp_user/features/activities/presentation/create_activity_screen.dart';
import 'package:epp_user/features/authentication/login/presentation/login_screen.dart';
import 'package:epp_user/features/authentication/sign_up/presentation/sign_up_phase1_screen.dart';
import 'package:epp_user/features/authentication/sign_up/presentation/sign_up_phase2_screen.dart';
import 'package:epp_user/features/authentication/sign_up/presentation/sign_up_phase3_screen.dart';
import 'package:epp_user/features/bottom_navigation/presentation/bottom_nav_screen.dart';
import 'package:epp_user/features/profile/infrastructure/response/profile_details_response.dart';
import 'package:epp_user/features/profile/presentation/profile_details_screen.dart';
import 'package:epp_user/features/splash_screen/presentation/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 11/26/2023, Sunday

final appRouterProvider = Provider<GoRouter>((ref) => _appRouter);

final _appRouter = GoRouter(
  initialLocation: AppRoutes.splashScreen,
  routes: [
    GoRoute(
        path: AppRoutes.splashScreen,
        builder: (context, state) {
          return const SplashScreen();
        }),
    GoRoute(
        path: AppRoutes.loginScreen,
        builder: (context, state) {
          return const LoginScreen();
        }),
    GoRoute(
        path: AppRoutes.signUpPhase1Screen,
        builder: (context, state) {
          return const SignUpPhase1Screen();
        }),
    GoRoute(
        path: AppRoutes.signUpPhase2Screen,
        builder: (context, state) {
          return const SignUpPhase2Screen();
        }),
    GoRoute(
        path: AppRoutes.signUpPhase3Screen,
        builder: (context, state) {
          return const SignUpPhase3Screen();
        }),
    GoRoute(
        path: AppRoutes.bottomNavScreen,
        builder: (context, state) {
          return const BottomNavScreen();
        }),
    GoRoute(
        path: AppRoutes.createActivityScreen,
        builder: (context, state) {
          return const CreateActivityScreen();
        }),
    GoRoute(
        path: AppRoutes.activityDetailScreen,
        builder: (context, state) {
          if (state.extra is ActivityResponseData) {
            return ActivityDetailScreen(
              activityResponseData: state.extra as ActivityResponseData,
            );
          } else {
            return const ActivityDetailScreen();
          }
        }),
    GoRoute(
        path: AppRoutes.profileDetailScreen,
        builder: (context, state) {
          if (state.extra is ProfileData) {
            return ProfileDetailsScreen(
              profileData: state.extra as ProfileData,
            );
          } else {
            return const ProfileDetailsScreen();
          }
        }),
  ],
);
