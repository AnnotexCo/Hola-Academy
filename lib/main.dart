import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/app_router.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/networking/networkconnection/cubit/network_connection_cubit.dart';
import 'core/bloc_observer/bloc_observer.dart';
import 'core/dependency_injection/dependency.dart';
import 'core/local_notification_service/local_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  setUpGetIt();
  Bloc.observer = MyBlocObserver();
  // initialize notification
  await LocalNotificationService().initNotification();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<NetworkConnectionCubit>(
          create: (context) => NetworkConnectionCubit(),
          lazy: false,
        ),
      ],
      
      child: MyApp(appRouter: AppRouter()),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: false,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocListener<NetworkConnectionCubit, NetworkConnectionState>(
          listener: (context, state) {
            final navigator = MyApp.navigatorKey.currentState;
            final overlayContext = navigator?.overlay?.context;

            if (state is NetworkDisconnected) {
              if (overlayContext != null) {
                showDialog(
                  context: overlayContext,
                  barrierDismissible:
                      false, // Prevents tapping outside to dismiss
                  builder: (context) => PopScope(
                    canPop: false, // Prevents swipe back (system back button)
                    child: AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.wifi_off, size: 40),
                          const SizedBox(height: 10),
                          const Text("No Internet Connection"),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () =>
                                exit(0), // Closes the app when clicked
                            child: const Text("Exit"),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            } else if (state is NetworkConnected) {
              if (navigator?.canPop() == true) {
                navigator?.pop();
              }
            }
          },
          child: MaterialApp(
            navigatorKey: MyApp.navigatorKey,
            initialRoute: Routes.splashScreen,
            onGenerateRoute: appRouter.generateRoute,
            debugShowCheckedModeBanner: false,
            title: 'Hola Academy',
            theme: ThemeData(
              scaffoldBackgroundColor: ColorManager.whiteColor,
              primaryColor: ColorManager.textRedColor,
              colorScheme: ColorScheme.fromSeed(
                seedColor: ColorManager.primaryOrangeColor,
              ),
              useMaterial3: true,
            ),
          ),
        );
      },
    );
  }
}
