import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routes/app_router.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 11/17/2024, Sunday

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final goRouter = ref.read(appRouterProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeAnimationCurve: Curves.linearToEaseOut,
      navigatorKey: navigatorKey,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Router(
        routeInformationProvider: goRouter.routeInformationProvider,
        routeInformationParser: goRouter.routeInformationParser,
        routerDelegate: goRouter.routerDelegate,
        backButtonDispatcher: goRouter.backButtonDispatcher,
      ),
    );
  }
}
