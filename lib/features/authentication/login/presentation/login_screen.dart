import 'package:epp_user/app/routes/routes.dart';
import 'package:epp_user/core/base_class/base_state.dart';
import 'package:epp_user/core/constants/color_constants.dart';
import 'package:epp_user/core/extensions/context_extension.dart';
import 'package:epp_user/core/widgets/custom_asset_image.dart';
import 'package:epp_user/core/widgets/custom_button.dart';
import 'package:epp_user/core/widgets/custom_inkwell.dart';
import 'package:epp_user/core/widgets/custom_scaffold.dart';
import 'package:epp_user/core/widgets/custom_textfield.dart';
import 'package:epp_user/features/authentication/login/application/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 11/17/2024, Sunday

final loginController = StateNotifierProvider((ref) => LoginController(ref));

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController _mobileNumberController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _initialiseControllers();
    super.initState();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _listenToLoginController(context);
    final loginApiState = ref.watch(loginController);
    return CustomScaffold(
        enableSafeArea: false,
        backgroundColor: ColorConstant.primaryColor,
        padding: EdgeInsets.zero,
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Form(
                key: _formKey,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: const CustomAssetImage(
                            'assets/images/logo.png',
                            height: 60,
                            width: 60,
                          ),
                        ),
                        Text(
                          "Eco Club Teachers",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstant.primaryColor,
                                    fontSize: 22,
                                  ),
                          textScaler: const TextScaler.linear(1),
                        ),
                        const SizedBox(height: 24),
                        CustomTextField(
                          controller: _mobileNumberController,
                          labelText: "Mobile Number",
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter valid mobile number";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 4),
                        CustomTextField(
                          controller: _passwordController,
                          labelText: "Password",
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter valid password";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 8),
                        _registerSection(context),
                        _loginButton(
                          context,
                          loginApiState is LoadingState,
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }

  CustomInkWell _registerSection(BuildContext context) {
    return CustomInkWell(
      onTap: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        context.push(
          AppRoutes.signUpPhase1Screen,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: RichText(
          text: TextSpan(
            text: "Don't have an account? ",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: "Poppins",
            ),
            children: [
              TextSpan(
                text: 'Register',
                style: TextStyle(
                  color: ColorConstant.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  fontFamily: "Poppins",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _listenToLoginController(BuildContext context) {
    ref.listen(loginController, (previous, next) async {
      if (next is SuccessState) {
        context.push(
          AppRoutes.bottomNavScreen,
        );
      } else if (next is FailureState) {
        context.showToast(message: next.failureResponse.errorMessage);
      }
    });
  }

  Widget _loginButton(
    BuildContext context,
    bool isLoading,
  ) {
    return CustomButton(
      text: 'Login',
      isLoading: isLoading,
      borderRadius: 8,
      onTap: () async {
        // if (_formKey.currentState?.validate() ?? false) {
        FocusManager.instance.primaryFocus?.unfocus();
        _loginApiCall();
        // }
      },
    );
  }

  void _loginApiCall() {
    ref.read(loginController.notifier).login(
          phone: _mobileNumberController.text,
          password: _passwordController.text,
        );
  }

  void _initialiseControllers() {
    _formKey = GlobalKey<FormState>();
    _mobileNumberController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void _disposeControllers() {
    _mobileNumberController.dispose();
    _passwordController.dispose();
  }
}
