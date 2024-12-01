import 'dart:io';

import 'package:epp_user/core/base_class/base_state.dart';
import 'package:epp_user/core/constants/color_constants.dart';
import 'package:epp_user/core/enums/custom_enums.dart';
import 'package:epp_user/core/extensions/context_extension.dart';
import 'package:epp_user/core/widgets/custom_button.dart';
import 'package:epp_user/core/widgets/custom_dropdown_button.dart';
import 'package:epp_user/core/widgets/custom_inkwell.dart';
import 'package:epp_user/core/widgets/custom_scaffold.dart';
import 'package:epp_user/core/widgets/custom_textfield.dart';
import 'package:epp_user/features/activities/application/activity_controller.dart';
import 'package:epp_user/features/activities/infrastructure/response/activity_list_response.dart';
import 'package:epp_user/features/activities/infrastructure/response/activity_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 11/25/2024, Monday

final uploadActivityController =
    StateNotifierProvider((ref) => ActivityController(ref));

class CreateActivityScreen extends ConsumerStatefulWidget {
  const CreateActivityScreen({super.key});

  @override
  ConsumerState<CreateActivityScreen> createState() =>
      _CreateActivityScreenState();
}

class _CreateActivityScreenState extends ConsumerState<CreateActivityScreen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _locationController;

  late final TextEditingController _startDateController;
  late final TextEditingController _startTimeController;

  late final TextEditingController _endDateController;
  late final TextEditingController _endTimeController;

  String? _imagePath;
  int? _activityTypeIndex;

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
    final uploadActivityApiState = ref.watch(uploadActivityController);
    final activityDropDownList = ref.watch(activityDropDownListProvider);

    ref.listen(uploadActivityController, (previous, next) {
      if (next is SuccessState<ActivityCreateResponse>) {
        context.showToast(
          message: "Activity created successfully",
          toastType: ToastType.success,
        );
        context.pop();
      } else if (next is FailureState) {
        context.showToast(message: next.failureResponse.errorMessage);
      }
    });

    return CustomScaffold(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        appBarTitle: 'Create New Activity',
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
                        CustomTextField(
                          controller: _titleController,
                          labelText: "Title",
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter valid title";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 4),
                        CustomTextField(
                          controller: _descriptionController,
                          labelText: "Description",
                          textInputAction: TextInputAction.next,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter valid description";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 4),
                        CustomTextField(
                          controller: _locationController,
                          labelText: "Location",
                          textInputAction: TextInputAction.next,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter valid location";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 4),
                        _dateAndTimeWidget(context),
                        const SizedBox(height: 4),
                        _endDateAndTimeWidget(context),
                        const SizedBox(height: 4),
                        CustomDropdownButton(
                          labelText: 'Type',
                          validator: (_) {
                            if (_activityTypeIndex == null) {
                              return "Please select a valid type";
                            } else {
                              return null;
                            }
                          },
                          items: activityDropDownList
                              .map((e) => DropdownMenuItem(
                                    value: e?.id,
                                    child: Text(e?.title ?? ''),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value is int) {
                              setState(() {
                                _activityTypeIndex = value;
                              });
                            }
                          },
                          value: _activityTypeIndex,
                        ),
                        const SizedBox(height: 16),
                        _imageUploadWidget(context),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _continueButton(
                context,
                uploadActivityApiState is LoadingState,
              ),
            ],
          ),
        ));
  }

  Row _dateAndTimeWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              FocusScope.of(context).unfocus();
              var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1930),
                  lastDate: DateTime(2080));

              if (date != null) {
                _startDateController.text =
                    DateFormat('yyyy-MM-dd').format(date);
              }
            },
            child: CustomTextField(
              isEnabled: false,
              controller: _startDateController,
              labelText: 'Start Date',
              suffixIcon: const Icon(Icons.date_range_outlined),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: InkWell(
            onTap: () async {
              FocusScope.of(context).unfocus();
              var time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                builder: (BuildContext context, Widget? child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      alwaysUse24HourFormat: false,
                    ),
                    child: child!,
                  );
                },
              );
              if (time != null) {
                String hour = time.hour.toString().padLeft(2, '0');
                String minute = time.minute.toString().padLeft(2, '0');
                _startTimeController.text = '$hour:$minute';
              }
            },
            child: CustomTextField(
              isEnabled: false,
              controller: _startTimeController,
              labelText: 'Start Time',
              suffixIcon: const Icon(Icons.access_time_outlined),
            ),
          ),
        ),
      ],
    );
  }

  Row _endDateAndTimeWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              FocusScope.of(context).unfocus();
              var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1930),
                  lastDate: DateTime(2080));

              if (date != null) {
                _endDateController.text = DateFormat('yyyy-MM-dd').format(date);
              }
            },
            child: CustomTextField(
              isEnabled: false,
              controller: _endDateController,
              labelText: 'End Date',
              suffixIcon: const Icon(Icons.date_range_outlined),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: InkWell(
            onTap: () async {
              FocusScope.of(context).unfocus();
              var time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                builder: (BuildContext context, Widget? child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      alwaysUse24HourFormat: false,
                    ),
                    child: child!,
                  );
                },
              );

              if (time != null) {
                String hour = time.hour.toString().padLeft(2, '0');
                String minute = time.minute.toString().padLeft(2, '0');
                _endTimeController.text = '$hour:$minute';
              }
            },
            child: CustomTextField(
              isEnabled: false,
              controller: _endTimeController,
              labelText: 'Time',
              suffixIcon: const Icon(Icons.access_time_outlined),
            ),
          ),
        ),
      ],
    );
  }

  InkWell _imageUploadWidget(BuildContext context) {
    return InkWell(
      onTap: _pickImage,
      borderRadius: BorderRadius.circular(12),
      child: _imagePath == null
          ? Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: ColorConstant.textFieldColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Picture",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(width: 12),
                  Image.asset(
                    'assets/images/upload_image.png',
                    height: 64,
                    width: 64,
                  )
                ],
              ))
          : Stack(
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(_imagePath!),
                      height: 120,
                      width: 120,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: CustomInkWell(
                    onTap: () {
                      setState(() {
                        _imagePath = null;
                      });
                    },
                    child: Container(
                      height: 24,
                      width: 24,
                      margin: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Center(
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }

  Widget _continueButton(
    BuildContext context,
    bool isLoading,
  ) {
    return CustomButton(
      text: 'Post',
      isLoading: isLoading,
      borderRadius: 8,
      onTap: () async {
        if (_formKey.currentState?.validate() ?? false) {
          FocusManager.instance.primaryFocus?.unfocus();
          ref
              .read(uploadActivityController.notifier)
              .createActivity(ActivityResponseData(
                activityTitle: _titleController.text,
                location: _locationController.text,
                activityDateAndTime:
                    '${_startDateController.text} ${_startTimeController.text}:00',
                activityEndDateAndTime:
                    '${_endDateController.text} ${_endTimeController.text}:00',
                description: _descriptionController.text,
                activityType: ref
                    .read(activityDropDownListProvider)[ref
                        .read(activityDropDownListProvider)
                        .indexWhere(
                            (element) => element?.id == _activityTypeIndex)]
                    ?.id,
                image: _imagePath,
              ));
        }
      },
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );
    if (img == null) return;

    final File imageFile = File(img.path);
    final int fileSize = await imageFile.length(); // Get file size in bytes

    print("Image size: ${fileSize / (1024 * 1024)} MB");

    setState(() {
      _imagePath = img.path;
    });
  }

  void _initialiseControllers() {
    _formKey = GlobalKey<FormState>();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _locationController = TextEditingController();
    _startDateController = TextEditingController();
    _startTimeController = TextEditingController();
    _endDateController = TextEditingController();
    _endTimeController = TextEditingController();
  }

  void _disposeControllers() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _startDateController.dispose();
    _startTimeController.dispose();
    _endDateController.dispose();
    _endTimeController.dispose();
  }
}
