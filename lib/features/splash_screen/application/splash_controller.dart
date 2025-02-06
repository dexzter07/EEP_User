import 'package:epp_user/core/local_data_source/local_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
