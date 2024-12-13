import 'package:epp_user/app/routes/routes.dart';
import 'package:epp_user/core/base_class/base_state.dart';
import 'package:epp_user/core/constants/color_constants.dart';
import 'package:epp_user/core/enums/custom_enums.dart';
import 'package:epp_user/core/extensions/context_extension.dart';
import 'package:epp_user/core/networks/static_data/state_information.dart';
import 'package:epp_user/core/widgets/custom_button.dart';
import 'package:epp_user/core/widgets/custom_dropdown_button.dart';
import 'package:epp_user/core/widgets/custom_scaffold.dart';
import 'package:epp_user/core/widgets/custom_textfield.dart';
import 'package:epp_user/features/authentication/sign_up/application/sign_up_controller.dart';
import 'package:epp_user/features/authentication/sign_up/presentation/widgets/step_tracker_widget.dart';
import 'package:flutter/cupertino.dart';
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
  late final TextEditingController _affiliationController;
  late final TextEditingController _pincodeController;

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

  SchoolTypes? _schoolType;
  int? _stateIndex;
  int? _districtIndex;

  @override
  Widget build(BuildContext context) {
    _listenToSignupApi2Controller(context);
    final apiState = ref.watch(signupApi2Controller);
    return BackButtonListener(
      onBackButtonPressed: () async {
        ref.read(stepCounterCurrentIndexProvider.notifier).state = 1;
        context.pop();
        return true;
      },
      child: CustomScaffold(
          enableSafeArea: false,
          padding: EdgeInsets.zero,
          backgroundColor: ColorConstant.primaryColor,
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
                          CustomDropdownButton(
                            labelText: 'School Type',
                            items: const [
                              DropdownMenuItem(
                                value: SchoolTypes.Private,
                                child: Text('Primary'),
                              ),
                              DropdownMenuItem(
                                value: SchoolTypes.Public,
                                child: Text('Secondary'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value is SchoolTypes) {
                                setState(() {
                                  _schoolType = value;
                                });
                              }
                            },
                            value: _schoolType,
                            validator: (var name) {
                              if (name == null) {
                                return 'Please select a school type';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomDropdownButton(
                            labelText: 'State',
                            items: stateName
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: stateName.indexOf(e),
                                    child: Text(e["name"]),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value is int) {
                                setState(() {
                                  _districtIndex = null;
                                  _stateIndex = value;
                                });
                              }
                            },
                            value: _stateIndex,
                            validator: (var name) {
                              if (name == null) {
                                return 'Please select a state';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomDropdownButton(
                            labelText: 'Districts',
                            items: _stateIndex == null
                                ? []
                                : (stateName[_stateIndex!]["districts"]
                                        as List<String>)
                                    .map((e) => DropdownMenuItem(
                                          value: stateName[_stateIndex!]
                                                  ["districts"]
                                              .indexOf(e),
                                          child: Text(e),
                                        ))
                                    .toList(),
                            onChanged: (value) {
                              if (value is int) {
                                setState(() {
                                  _districtIndex = value;
                                });
                              }
                            },
                            value: _districtIndex,
                            validator: (var name) {
                              if (name == null) {
                                return 'Please select a district';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 16),
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
                          const SizedBox(height: 4),
                          CustomTextField(
                            controller: _pincodeController,
                            labelText: "PinCode",
                            textInputAction: TextInputAction.done,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter valid Pincode";
                              } else {
                                return null;
                              }
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
          })),
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
        if (_formKey.currentState?.validate() ?? false) {
          FocusManager.instance.primaryFocus?.unfocus();
          _signupPhase2ApiCall();
        }
      },
    );
  }

  void _signupPhase2ApiCall() {
    ref.read(signupApi2Controller.notifier).signupApi2(
          schoolName: _schoolNameController.text,
          schoolType: _schoolType?.name,
          schoolAffiliation: _affiliationController.text,
          stateName: stateName[_stateIndex ?? 0]["name"],
          district: stateName[_stateIndex ?? 0]["districts"][_districtIndex],
          pincode: _pincodeController.text,
        );
  }

  void _initialiseControllers() {
    _formKey = GlobalKey<FormState>();
    _schoolNameController = TextEditingController();
    _pincodeController = TextEditingController();
    _affiliationController = TextEditingController();
  }

  void _disposeControllers() {
    _schoolNameController.dispose();
    _pincodeController.dispose();
    _affiliationController.dispose();
  }

  void _listenToSignupApi2Controller(BuildContext context) {
    ref.listen(signupApi2Controller, (previous, next) async {
      if (next is SuccessState) {
        ref.read(stepCounterCurrentIndexProvider.notifier).state = 3;
        context.push(
          AppRoutes.signUpPhase3Screen,
        );
      } else if (next is FailureState) {
        context.showToast(message: next.failureResponse.errorMessage);
      }
    });
  }
}
