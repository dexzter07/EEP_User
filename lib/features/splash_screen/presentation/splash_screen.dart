import 'package:epp_user/app/routes/routes.dart';
import 'package:epp_user/core/constants/color_constants.dart';
import 'package:epp_user/core/widgets/custom_scaffold.dart';
import 'package:epp_user/features/splash_screen/application/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 11/17/2024, Sunday

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  final SplashController _splashController = SplashController();

  @override
  void initState() {
    _changeStatusBarColor();
    checkForAccessToken();
    super.initState();
  }

  Future<void> checkForAccessToken() async {
    bool hasAccessToken = await _splashController.checkForAccessToken(ref);
    if (hasAccessToken) {
      context.push(AppRoutes.bottomNavScreen);
    } else {
      context.push(AppRoutes.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(body: Container());
  }

  void _changeStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorConstant.primaryColor,
        statusBarIconBrightness: Brightness.light, // For Android
        statusBarBrightness: Brightness.light, // For IOS
      ),
    );
  }
}
