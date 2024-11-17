import 'package:epp_user/app/routes/routes.dart';
import 'package:epp_user/core/base_class/base_state.dart';
import 'package:epp_user/core/constants/color_constants.dart';
import 'package:epp_user/core/enums/custom_enums.dart';
import 'package:epp_user/core/extensions/context_extension.dart';
import 'package:epp_user/core/widgets/custom_button.dart';
import 'package:epp_user/core/widgets/custom_scaffold.dart';
import 'package:epp_user/core/widgets/custom_textfield.dart';
import 'package:epp_user/features/authentication/login/application/login_controller.dart';
import 'package:epp_user/features/authentication/login/infrastructure/response/login_response.dart';
import 'package:flutter/gestures.dart';
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
  late final TextEditingController _otpController;

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
        padding: EdgeInsets.zero,
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Text(
                            "Welcome to",
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontFamily: 'EbGaramond',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 32,
                                    ),
                            textScaler: const TextScaler.linear(1),
                          ),
                          Text(
                            "EEP Environment App",
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontFamily: 'EbGaramond',
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstant.primaryColor,
                                      fontSize: 38,
                                    ),
                            textScaler: const TextScaler.linear(1),
                          ),
                          const SizedBox(height: 36),
                          CustomTextField(
                            controller: _mobileNumberController,
                            labelText: "Mobile Number",
                            prefixText: '+91-',
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
                            controller: _otpController,
                            labelText: "Password",
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter valid password";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: RichText(
                  text: TextSpan(
                    text: 'By continuing, you accept to ',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    // Default text style
                    children: [
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: ColorConstant.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      const TextSpan(
                        text: ' & ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: "Poppins",
                        ),
                      ),
                      TextSpan(
                        text: 'Terms of Services',
                        style: TextStyle(
                          color: ColorConstant.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Handle Terms of Services tap
                          },
                      ),
                      const TextSpan(
                        text: ' of AppName',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _loginButton(
                context,
                loginApiState is LoadingState,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ));
  }

  void _listenToLoginController(BuildContext context) {
    ref.listen(loginController, (previous, next) async {
      if (next is SuccessState<LoginResponse>) {
        context.showToast(
          message: "Login Successful",
          toastType: ToastType.success,
        );
        await Future.delayed(const Duration(milliseconds: 600));
        if (context.mounted) {
          context.push(
            AppRoutes.bottomNavScreen,
          );
        }
      } else if (next is FailureState) {
        context.showToast(message: "We face some issue while logging you in");
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
      margin: const EdgeInsets.symmetric(horizontal: 16),
      borderRadius: 8,
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          FocusManager.instance.primaryFocus?.unfocus();
          await ref.read(loginController.notifier).login(
                _mobileNumberController.text,
                _otpController.text,
              );
        }
      },
    );
  }

  void _initialiseControllers() {
    _formKey = GlobalKey<FormState>();
    _mobileNumberController = TextEditingController();
    _otpController = TextEditingController();
  }

  void _disposeControllers() {
    _mobileNumberController.dispose();
    _otpController.dispose();
  }
}
