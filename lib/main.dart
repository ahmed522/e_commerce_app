import 'package:e_commerce_app/features/start/view/screens/splash_screen.dart';
import 'package:e_commerce_app/global/routes/routes.dart';
import 'package:e_commerce_app/global/services/cache_helper.dart';
import 'package:e_commerce_app/global/services/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'global/themes/app_theme.dart';
import 'global/widgets/app_error_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(const MainWidget());
    },
  );
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appLightTheme,
      darkTheme: AppTheme.appDarkTheme,
      builder: (BuildContext context, Widget? widget) {
        ErrorWidget.builder = (_) {
          return const AppErrorWidget();
        };
        return widget!;
      },
      themeMode: ThemeMode.system,
      routes: AppRoutes.routes,
      initialRoute: SplashScreen.route,
    );
  }
}
