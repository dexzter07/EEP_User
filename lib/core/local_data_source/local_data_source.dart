import 'package:epp_user/core/local_data_source/shared_preference_constants.dart';
import 'package:epp_user/core/local_data_source/shared_preference_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 9/30/2024, Monday

final localDataSourceProvider = StateProvider((ref) => LocalDataSource());

class LocalDataSource {
  Future<void> saveAccessToken(String accessToken) async {
    try {
      final SharedPreferencesService sharedPreferencesService =
          SharedPreferencesService();
      sharedPreferencesService.saveData(
        SharedPreferenceConstants.accessToken,
        accessToken,
      );
    } catch (e) {
      throw 'Error while saving access token : $e';
    }
  }

  Future<String> getAccessToken() async {
    try {
      final SharedPreferencesService sharedPreferencesService =
          SharedPreferencesService();
      final accessToken = sharedPreferencesService.getStringValue(
        SharedPreferenceConstants.accessToken,
      );
      return accessToken;
    } catch (e) {
      throw 'Error while fetching access token : $e';
    }
  }

  Future<void> saveTempAccessToken(String accessToken) async {
    try {
      final SharedPreferencesService sharedPreferencesService =
          SharedPreferencesService();
      sharedPreferencesService.saveData(
        SharedPreferenceConstants.tempAccessToken,
        accessToken,
      );
    } catch (e) {
      throw 'Error while saving access token : $e';
    }
  }

  Future<String> getTempAccessToken() async {
    try {
      final SharedPreferencesService sharedPreferencesService =
          SharedPreferencesService();
      final accessToken = sharedPreferencesService.getStringValue(
        SharedPreferenceConstants.tempAccessToken,
      );
      return accessToken;
    } catch (e) {
      throw 'Error while fetching access token : $e';
    }
  }
}
