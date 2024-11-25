import 'package:epp_user/app/routes/routes.dart';
import 'package:epp_user/core/base_class/base_state.dart';
import 'package:epp_user/core/enums/custom_enums.dart';
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

final signupApi3Controller =
    StateNotifierProvider((ref) => SignupController(ref));

class SignUpPhase3Screen extends ConsumerStatefulWidget {
  const SignUpPhase3Screen({super.key});

  @override
  ConsumerState<SignUpPhase3Screen> createState() => _SignUpPhase3ScreenState();
}

class _SignUpPhase3ScreenState extends ConsumerState<SignUpPhase3Screen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _fullNameController;
  late final TextEditingController _mobileNumberController;
  late final TextEditingController _emailController;

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
    _listenToSignupApi3Controller(context);
    final apiState = ref.watch(signupApi3Controller);

    return BackButtonListener(
      onBackButtonPressed: ()async{
        ref.read(stepCounterCurrentIndexProvider.notifier).state  = 2;
        context.pop();
        return true;
      },
      child: CustomScaffold(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          appBarTitle: 'Register',
          onLeadingIconPress: (){
            ref.read(stepCounterCurrentIndexProvider.notifier).state  = 2;
            context.pop();
          },
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          const StepTrackerWidget(),
                          const SizedBox(height: 24),
                          CustomTextField(
                            controller: _fullNameController,
                            labelText: "Principal Name",
                            textInputAction: TextInputAction.next,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter valid name";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 4),
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
                            controller: _emailController,
                            labelText: "Email Address",
                            textInputAction: TextInputAction.next,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter valid email address";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _continueButton(
                  context,
                  apiState is LoadingState,
                ),
              ],
            ),
          )),
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
        FocusManager.instance.primaryFocus?.unfocus();
        context.push(
          AppRoutes.bottomNavScreen,
        );
      },
    );
  }

  void _initialiseControllers() {
    _formKey = GlobalKey<FormState>();
    _fullNameController = TextEditingController();
    _mobileNumberController = TextEditingController();
    _emailController = TextEditingController();
  }

  void _disposeControllers() {
    _fullNameController.dispose();
    _mobileNumberController.dispose();
    _emailController.dispose();
  }

  void _listenToSignupApi3Controller(BuildContext context) {
    ref.listen(signupApi3Controller, (previous, next) async {
      if (next is SuccessState<int>) {
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
}
