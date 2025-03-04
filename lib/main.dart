import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
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



///  **Handle background notifications (when the app is completely closed)**
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(' Background Notification Received: ${message.messageId}');
  print(' Title: ${message.notification?.title}');
  print(' Body: ${message.notification?.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  setUpGetIt();
  Bloc.observer = MyBlocObserver();

  //  Initialize Notification Service
  await LocalNotificationService().initNotification();

  //  Listen for background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //  Get Firebase Messaging instance
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //  Request permission for notifications (iOS only)
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  print(' Notification permission status: ${settings.authorizationStatus}');

  //  Handle notification when the app is in the foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print(' Foreground Notification Received!');
    print(' Title: ${message.notification?.title}');
    print(' Body: ${message.notification?.body}');

    // **Show the notification using LocalNotificationService**
    LocalNotificationService().showNotification(
      title: message.notification?.title ?? "No Title",
      body: message.notification?.body ?? "No Body",
    );
  });

  //  Handle notification click when app is in the background or terminated
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("🚀 Notification Clicked! Navigating to a screen...");
    print(" Title: ${message.notification?.title}");
    print(" Body: ${message.notification?.body}");
    
    // TODO: Navigate to the correct screen (if needed)
  });
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
