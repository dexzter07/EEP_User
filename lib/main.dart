import 'package:epp_user/core/constants/color_constants.dart';
import 'package:epp_user/core/local_data_source/shared_preference_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';

final providerContainer = ProviderContainer();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.initializePreferences();

  runApp(UncontrolledProviderScope(
    container: providerContainer,
    child: const MyApp(),
  ));
}
