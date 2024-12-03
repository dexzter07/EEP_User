import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:epp_user/core/base_class/base_state.dart';
import 'package:epp_user/core/base_class/base_success_response.dart';
import 'package:epp_user/core/constants/color_constants.dart';
import 'package:epp_user/core/enums/custom_enums.dart';
import 'package:epp_user/core/extensions/context_extension.dart';
import 'package:epp_user/core/networks/static_data/state_information.dart';
import 'package:epp_user/core/widgets/custom_asset_image.dart';
import 'package:epp_user/core/widgets/custom_button.dart';
import 'package:epp_user/core/widgets/custom_dropdown_button.dart';
import 'package:epp_user/core/widgets/custom_inkwell.dart';
import 'package:epp_user/core/widgets/custom_network_image.dart';
import 'package:epp_user/core/widgets/custom_scaffold.dart';
import 'package:epp_user/core/widgets/custom_textfield.dart';
import 'package:epp_user/features/profile/application/profile_controller.dart';
import 'package:epp_user/features/profile/infrastructure/response/profile_details_response.dart';
import 'package:epp_user/features/profile/presentation/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 12/3/2024, Tuesday

final updateProfilePictureController =
    StateNotifierProvider((ref) => ProfileController(ref));
final updateProfileDetailsController =
    StateNotifierProvider((ref) => ProfileController(ref));

class ProfileDetailsScreen extends ConsumerStatefulWidget {
  final ProfileData? profileData;

  const ProfileDetailsScreen({
    this.profileData,
    super.key,
  });

  @override
  ConsumerState<ProfileDetailsScreen> createState() =>
      _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends ConsumerState<ProfileDetailsScreen> {
  late final GlobalKey<FormState> _formKey;
  String? _imagePath;

  ///Phase 1 Entity...
  late final TextEditingController _fullNameController;
  late final TextEditingController _mobileNumberController;
  late final TextEditingController _emailController;

  ///Phase 2 Entity...
  late final TextEditingController _schoolNameController;
  late final TextEditingController _affiliationController;
  late final TextEditingController _pincodeController;
  late final TextEditingController _enrolledCountController;
  SchoolTypes? _schoolType;
  int? _stateIndex;
  int? _districtIndex;

  ///Phase 3 Entity...
  late final TextEditingController _principalFullNameController;
  late final TextEditingController _principalMobileNumberController;
  late final TextEditingController _principalEmailController;

  @override
  void initState() {
    _initialiseControllers();
    _populateControllers();
    super.initState();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final updateProfileDetailsState = ref.watch(updateProfileDetailsController);
    _listenToUpdateProfileDetailsController(context);
    _listenToUpdateProfilePictureController(context);
    return CustomScaffold(

      appBarTitle: 'Profile Details',
      padding: const EdgeInsets.symmetric(vertical: 16),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Center(
              child: CustomInkWell(
                onTap: _pickImage,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (_imagePath != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(
                          File(_imagePath!),
                          height: 90,
                          width: 90,
                          fit: BoxFit.fill,
                        ),
                      )
                    else
                      _profileCircleImageAvatar(
                        context,
                        widget.profileData?.userImage ?? '',
                      ),
                    _iconWidget(context),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            _phase1Section(),
            const SizedBox(height: 24),
            _phase2Section(),
            const SizedBox(height: 24),
            _phase3Section(),
            const SizedBox(height: 24),
            _continueButton(
              context,
              updateProfileDetailsState is LoadingState,
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileCircleImageAvatar(BuildContext context, String imageUrl) {
    return CustomNetworkImage(
      image: widget.profileData?.userImage,
      isCircular: true,
      height: 90,
      width: 90,
    );
  }

  Positioned _iconWidget(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstant.scaffoldColor,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(3),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.edit,
            size: 15,
          ),
        ),
      ),
    );
  }

  void _listenToUpdateProfileDetailsController(BuildContext context) {
    ref.listen(updateProfileDetailsController, (previous, next) {
      if (next is SuccessState<BaseSuccessResponse>) {
        context.showToast(
          message: next.data.message ?? 'Profile Successfully Updated.',
          toastType: ToastType.success,
        );
        context.pop();
        ref.read(fetchProfileDetailsController.notifier).fetchProfileDetails();
      } else if (next is FailureState) {
        context.showToast(
          message: next.failureResponse.errorMessage,
        );
      }
    });
  }

  void _listenToUpdateProfilePictureController(BuildContext context) {
    ref.listen(updateProfilePictureController, (previous, next) {
      if (next is SuccessState<BaseSuccessResponse>) {
        ref.read(fetchProfileDetailsController.notifier).fetchProfileDetails();
      } else if (next is FailureState) {
        context.showToast(
          message: next.failureResponse.errorMessage,
        );
      }
    });
  }

  Container _phase3Section() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          const Text(
            "Principal's Information",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            controller: _principalFullNameController,
            labelText: "Principal Name",
            isEnabled: false,
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
            controller: _principalMobileNumberController,
            labelText: "Principal Mobile Number",
            isEnabled: false,
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
            controller: _principalEmailController,
            labelText: "Principal Email Address",
            isEnabled: false,
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
    );
  }

  Container _phase2Section() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          const Text(
            "School's Information",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            controller: _schoolNameController,
            labelText: "School Name",
            isEnabled: false,
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
          AbsorbPointer(
            absorbing: true,
            child: CustomDropdownButton(
              isEnabled: false,
              labelText: 'School Type',
              items: const [
                DropdownMenuItem(
                  value: SchoolTypes.Private,
                  child: Text('Private'),
                ),
                DropdownMenuItem(
                  value: SchoolTypes.Public,
                  child: Text('Public'),
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
            ),
          ),
          const SizedBox(height: 16),
          AbsorbPointer(
            absorbing: true,
            child: CustomDropdownButton(
              isEnabled: false,
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
            ),
          ),
          const SizedBox(height: 16),
          AbsorbPointer(
            absorbing: true,
            child: CustomDropdownButton(
              isEnabled: false,
              labelText: 'Districts',
              items: _stateIndex == null
                  ? []
                  : (stateName[_stateIndex!]["districts"] as List<String>)
                      .map((e) => DropdownMenuItem(
                            value:
                                stateName[_stateIndex!]["districts"].indexOf(e),
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
            ),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _affiliationController,
            labelText: "Affiliation Type",
            isEnabled: false,
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
            isEnabled: false,
            textInputAction: TextInputAction.done,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "Please enter valid Pincode";
              } else {
                return null;
              }
            },
          ),
          const SizedBox(height: 4),
          CustomTextField(
            controller: _enrolledCountController,
            labelText: "Enrolled Count",
            textInputAction: TextInputAction.done,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "Please enter valid Pincode";
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }

  Container _phase1Section() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          const Text(
            "Teacher's Info",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
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
            isEnabled: false,
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
            isEnabled: false,
            textInputAction: TextInputAction.next,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "Please enter valid email address";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _continueButton(
    BuildContext context,
    bool isLoading,
  ) {
    return CustomButton(
      text: 'Update',
      isLoading: isLoading,
      borderRadius: 8,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      onTap: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        ref.read(updateProfileDetailsController.notifier).updateProfile(
              profileData: _getProfileData(),
            );
      },
    );
  }

  void _initialiseControllers() {
    _formKey = GlobalKey<FormState>();

    _fullNameController = TextEditingController();
    _mobileNumberController = TextEditingController();
    _emailController = TextEditingController();

    _schoolNameController = TextEditingController();
    _pincodeController = TextEditingController();
    _affiliationController = TextEditingController();
    _enrolledCountController = TextEditingController();

    _principalFullNameController = TextEditingController();
    _principalMobileNumberController = TextEditingController();
    _principalEmailController = TextEditingController();
  }

  void _disposeControllers() {
    _fullNameController.dispose();
    _mobileNumberController.dispose();
    _emailController.dispose();

    _schoolNameController.dispose();
    _pincodeController.dispose();
    _affiliationController.dispose();
    _enrolledCountController.dispose();

    _principalFullNameController.dispose();
    _principalMobileNumberController.dispose();
    _principalEmailController.dispose();
  }

  void _populateControllers() {
    if (widget.profileData != null) {
      _fullNameController.text = widget.profileData?.teacherName ?? '';
      _emailController.text = widget.profileData?.teacherEmail ?? '';
      _mobileNumberController.text =
          widget.profileData?.teacherPhone?.toString() ?? '';

      _schoolNameController.text = widget.profileData?.schoolName ?? '';
      _affiliationController.text = widget.profileData?.schoolAffiliation ?? '';
      _pincodeController.text = widget.profileData?.pincode ?? '';
      _enrolledCountController.text =
          widget.profileData?.enrolledCount?.toString() ?? '';

      _principalFullNameController.text =
          widget.profileData?.principalName ?? '';
      _principalEmailController.text = widget.profileData?.principalEmail ?? '';
      _principalMobileNumberController.text =
          widget.profileData?.principalPhone?.toString() ?? '';

      _stateIndex = stateName.indexWhere((element) =>
          element["name"].toString().toLowerCase() ==
          widget.profileData?.state?.toLowerCase());
      if (_stateIndex != null && _stateIndex! >= 0) {
        _districtIndex =
            (stateName[_stateIndex ?? 0]["districts"] as List<String>)
                .indexWhere((element) =>
                    element.toLowerCase() ==
                    widget.profileData?.district?.toLowerCase());
      }
      if (_stateIndex != null && _stateIndex! < 0) {
        _stateIndex = null;
      }
      if (_districtIndex != null && _districtIndex! < 0) {
        _districtIndex = null;
      }

      if (widget.profileData?.schoolType?.toLowerCase() ==
          SchoolTypes.Private.name.toLowerCase()) {
        _schoolType = SchoolTypes.Private;
      } else if (widget.profileData?.schoolType?.toLowerCase() ==
          SchoolTypes.Public.name.toLowerCase()) {
        _schoolType = SchoolTypes.Public;
      }
      setState(() {});
    }
  }

  ProfileData _getProfileData() {
    return ProfileData(
      teacherName: _fullNameController.text.trim(),
      enrolledCount: int.tryParse(_enrolledCountController.text.trim()),
    );
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? img = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 20,
      );
      if (img == null) return;

      final File imageFile = File(img.path);
      final int fileSizeInBytes = await imageFile.length();
      final double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (fileSizeInMB > 1 && mounted) {
        context.showToast(message: "Image size must be less than 1MB");
        return;
      }
      setState(() {
        _imagePath = img.path;
      });

      ref
          .read(updateProfilePictureController.notifier)
          .uploadProfilePicture(File(_imagePath!));
    } catch (e) {
      if (mounted) {
        context.showToast(
            message: "We faced some issue while updating the image");
      }
    }
  }
}
