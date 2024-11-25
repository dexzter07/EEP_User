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

final signupApi2Controller =
    StateNotifierProvider((ref) => SignupController(ref));

class SignUpPhase2Screen extends ConsumerStatefulWidget {
  const SignUpPhase2Screen({super.key});

  @override
  ConsumerState<SignUpPhase2Screen> createState() => _SignUpPhase2ScreenState();
}

class _SignUpPhase2ScreenState extends ConsumerState<SignUpPhase2Screen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _schoolNameController;
  late final TextEditingController _addressController;
  late final TextEditingController _typeController;
  late final TextEditingController _affiliationController;

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
    _listenToSignupApi2Controller(context);
    final apiState = ref.watch(signupApi2Controller);

    return BackButtonListener(
      onBackButtonPressed: ()async{
        ref.read(stepCounterCurrentIndexProvider.notifier).state  = 1;
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
            ref.read(stepCounterCurrentIndexProvider.notifier).state  = 1;
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
                            controller: _schoolNameController,
                            labelText: "School Name",
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
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
                            controller: _addressController,
                            labelText: "School Address",
                            textInputAction: TextInputAction.next,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter valid address";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 4),
                          CustomTextField(
                            controller: _typeController,
                            labelText: "School Type",
                            textInputAction: TextInputAction.next,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter valid school type";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 4),
                          CustomTextField(
                            controller: _affiliationController,
                            labelText: "Affiliation Type",
                            textInputAction: TextInputAction.done,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter valid affiliation type";
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
        ref.read(stepCounterCurrentIndexProvider.notifier).state = 3;
        FocusManager.instance.primaryFocus?.unfocus();
        context.push(
          AppRoutes.signUpPhase3Screen,
        );
      },
    );
  }

  void _initialiseControllers() {
    _formKey = GlobalKey<FormState>();
    _schoolNameController = TextEditingController();
    _addressController = TextEditingController();
    _typeController = TextEditingController();
    _affiliationController = TextEditingController();
  }

  void _disposeControllers() {
    _schoolNameController.dispose();
    _addressController.dispose();
    _typeController.dispose();
    _affiliationController.dispose();
  }

  void _listenToSignupApi2Controller(BuildContext context) {
    ref.listen(signupApi2Controller, (previous, next) async {
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
