import 'package:epp_user/app/routes/routes.dart';
import 'package:epp_user/features/authentication/login/presentation/login_screen.dart';
import 'package:epp_user/features/authentication/sign_up/presentation/sign_up_screen.dart';
import 'package:epp_user/features/bottom_navigation/presentation/bottom_nav_screen.dart';
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
        path: AppRoutes.signUpScreen,
        builder: (context, state) {
          return const SignUpScreen();
        }),
    GoRoute(
        path: AppRoutes.bottomNavScreen,
        builder: (context, state) {
          return const BottomNavScreen();
        }),
    /*  GoRoute(
        path: AppRoutes.loginScreen,
        builder: (context, state) {
          if (state.extra is LoginType) {
            return LoginScreen(loginType: state.extra as LoginType);
          } else if (state.extra == true) {
            return const LoginScreen(isFromSignupScreen: true);
          } else {
            return const LoginScreen();
          }
        }),*/
  ],
);
