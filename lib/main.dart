import 'dart:io'; // Needed for exit(0)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/app_router.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/networking/networkconnection/cubit/network_connection_cubit.dart';
import 'core/dependency_injection/dependency.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpGetIt();

  runApp(
    BlocProvider(
      create: (context) => NetworkConnectionCubit(),
      child: MyApp(appRouter: AppRouter()),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: false,
      splitScreenMode: true,
      builder: (context, child) {

        //Handle Connection 
        return BlocListener<NetworkConnectionCubit, NetworkConnectionState>(
          listener: (context, state) {
            final navigator = MyApp.navigatorKey.currentState;
            final overlayContext = MyApp.navigatorKey.currentContext; 

            if (state is NetworkDisconnected) {
              // ✅ Prevent showing multiple dialogs
              if (navigator?.canPop() == false) {
                if (overlayContext != null) {
                  showDialog(
                    context: overlayContext,
                    barrierDismissible: false,
                    builder: (context) {
                      return PopScope(
                        canPop: false,
                       onPopInvokedWithResult: (didPop, result) {
                           exit(0); 
                                                   },
                        child: AlertDialog(
                title: const Text("No Internet Connection"),
                content: Icon(Icons.wifi_off ,size: 40,),
                
              ),
            );
                    },
                  );
                }
              }
            }

            if (state is NetworkConnected) {
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
