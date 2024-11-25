import 'dart:io';

import 'package:epp_user/core/constants/color_constants.dart';
import 'package:epp_user/core/enums/custom_enums.dart';
import 'package:epp_user/core/extensions/context_extension.dart';
import 'package:epp_user/core/widgets/custom_button.dart';
import 'package:epp_user/core/widgets/custom_dropdown_button.dart';
import 'package:epp_user/core/widgets/custom_inkwell.dart';
import 'package:epp_user/core/widgets/custom_scaffold.dart';
import 'package:epp_user/core/widgets/custom_textfield.dart';
import 'package:epp_user/features/authentication/sign_up/application/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 11/25/2024, Monday

final signupApi1Controller =
    StateNotifierProvider((ref) => SignupController(ref));

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
  late final TextEditingController _dateController;
  late final TextEditingController _timeController;
  late final TextEditingController _statusController;
  late final TextEditingController _locationController;
  String? _imagePath;

  final int _dropDownIndex = 1;
  bool _isLoading = false;

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
    final apiState = ref.watch(signupApi1Controller);
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
                        _dateAndTimeWidget(context),
                        const SizedBox(height: 4),
                        CustomTextField(
                          controller: _statusController,
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
                        CustomDropdownButton(
                          labelText: 'Type',
                          items: const [
                            DropdownMenuItem(
                              value: 1,
                              child: Text('Option 1'),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text('Option 2'),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Text('Option 3'),
                            ),
                          ],
                          onChanged: (value) {},
                          value: _dropDownIndex,
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
                _isLoading,
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
                _dateController.text = DateFormat('yyyy-MM-dd').format(date);
              }
            },
            child: CustomTextField(
              isEnabled: false,
              controller: _dateController,
              labelText: 'Date',
              suffixIcon: const Icon(Icons.date_range_outlined),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: InkWell(
            onTap: () async {
              FocusScope.of(context).unfocus();
              var date = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );

              if (date != null) {
                final formattedTime = date.hourOfPeriod == 0
                    ? 12
                    : date.hourOfPeriod; // Convert 0 to 12 for AM.
                final minute = date.minute
                    .toString()
                    .padLeft(2, '0'); // Add leading zero to minutes.
                final period =
                    date.period == DayPeriod.am ? 'AM' : 'PM'; // Add AM/PM.
                _timeController.text = '$formattedTime:$minute $period';
              }
            },
            child: CustomTextField(
              isEnabled: false,
              controller: _timeController,
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
        FocusManager.instance.primaryFocus?.unfocus();
        setState(() {
          _isLoading = true;
        });
        await Future.delayed(const Duration(seconds: 1));
        context.showToast(
          message: "Activity created successfully",
          toastType: ToastType.success,
        );
        await Future.delayed(const Duration(milliseconds: 600));
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      },
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(
      source: ImageSource.gallery, // alternatively, use ImageSource.gallery
      maxWidth: 400,
    );
    if (img == null) return;
    setState(() {
      _imagePath = img.path; // convert it to a Dart:io file
    });
  }

  void _initialiseControllers() {
    _formKey = GlobalKey<FormState>();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _dateController = TextEditingController();
    _timeController = TextEditingController();
    _statusController = TextEditingController();
    _locationController = TextEditingController();
  }

  void _disposeControllers() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _statusController.dispose();
    _locationController.dispose();
  }
}
