
import 'package:epp_user/core/local_data_source/local_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 9/30/2024, Monday

class SplashController {
  Future<bool> checkForAccessToken(WidgetRef ref) async {
    final accessToken =
    await ref.read(localDataSourceProvider).getAccessToken();
    if (accessToken.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

}
