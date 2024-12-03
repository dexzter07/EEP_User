import 'package:epp_user/app/routes/routes.dart';
import 'package:epp_user/core/base_class/base_state.dart';
import 'package:epp_user/core/constants/color_constants.dart';
import 'package:epp_user/core/extensions/context_extension.dart';
import 'package:epp_user/core/widgets/custom_button.dart';
import 'package:epp_user/core/widgets/custom_scaffold.dart';
import 'package:epp_user/core/widgets/custom_textfield.dart';
import 'package:epp_user/features/authentication/sign_up/application/sign_up_controller.dart';
import 'package:epp_user/features/authentication/sign_up/presentation/widgets/step_tracker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 11/17/2024, Sunday

final signupApi1Controller =
    StateNotifierProvider((ref) => SignupController(ref));

class SignUpPhase1Screen extends ConsumerStatefulWidget {
  const SignUpPhase1Screen({super.key});

  @override
  ConsumerState<SignUpPhase1Screen> createState() => _SignUpPhase1ScreenState();
}

class _SignUpPhase1ScreenState extends ConsumerState<SignUpPhase1Screen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _fullNameController;
  late final TextEditingController _mobileNumberController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

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
    _listenToSignupApi1Controller(context);
    final apiState = ref.watch(signupApi1Controller);

    return CustomScaffold(
      enableSafeArea: false,
      backgroundColor: ColorConstant.primaryColor,
      padding: EdgeInsets.zero,
      body: LayoutBuilder(
        builder: (context, constraints) {
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
                    margin: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: MediaQuery.of(context)
                          .viewInsets
                          .bottom, // Adjust for keyboard
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        const StepTrackerWidget(),
                        const SizedBox(height: 24),
                        CustomTextField(
                          controller: _fullNameController,
                          labelText: "Full Name",
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter valid name";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 4),
                        CustomTextField(
                          controller: _mobileNumberController,
                          labelText: "Mobile Number",
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter valid mobile number";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 4),
                        CustomTextField(
                          controller: _emailController,
                          labelText: "Email Address",
                          textInputAction: TextInputAction.next,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter valid email address";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 4),
                        CustomTextField(
                          controller: _passwordController,
                          labelText: "Password",
                          textInputAction: TextInputAction.next,
                          obscureText: true,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter valid password";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 4),
                        CustomTextField(
                          controller: _confirmPasswordController,
                          labelText: "Confirm Password",
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter valid password";
                            } else if (value != _passwordController.text) {
                              return "Password and confirm password must be the same.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        _continueButton(
                          context,
                          apiState is LoadingState,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _continueButton(
    BuildContext context,
    bool isLoading,
  ) {
    return CustomButton(
      text: 'Continue',
      isLoading: isLoading,
      borderRadius: 8,
      onTap: () async {
        // if (_formKey.currentState?.validate() ?? false) {
        FocusManager.instance.primaryFocus?.unfocus();
        _signupPhase1ApiCall();
        // }
      },
    );
  }

  void _signupPhase1ApiCall() {
    ref.read(signupApi1Controller.notifier).signupApi1(
          teacherName: _fullNameController.text,
          teacherPhone: _mobileNumberController.text,
          teacherEmail: _emailController.text,
          password: _passwordController.text,
        );
  }

  void _initialiseControllers() {
    _formKey = GlobalKey<FormState>();
    _fullNameController = TextEditingController();
    _mobileNumberController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  void _disposeControllers() {
    _fullNameController.dispose();
    _mobileNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  void _listenToSignupApi1Controller(BuildContext context) {
    ref.listen(signupApi1Controller, (previous, next) async {
      if (next is SuccessState) {
        ref.read(stepCounterCurrentIndexProvider.notifier).state = 2;
        context.push(
          AppRoutes.signUpPhase2Screen,
        );
      } else if (next is FailureState) {
        context.showToast(message: next.failureResponse.errorMessage);
      }
    });
  }
}
