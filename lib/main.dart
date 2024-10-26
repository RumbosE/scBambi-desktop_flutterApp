
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:sc_flutter_app/config/router/app_router.dart';
import 'package:sc_flutter_app/config/theme/app_theme.dart';
import 'package:sc_flutter_app/infraestructure/core/enviroments.dart';
import 'package:sc_flutter_app/injector.dart';


void main() async {

  // await Environment.initEnvironment();

  // Register Blocs in service locator
  Injector().setUp();

  runApp(const MainApp());
  doWhenWindowReady(() {
    var initialState = const Size(1200, 700);
    appWindow.size = initialState;
    appWindow.minSize=initialState;
    appWindow.title = "Bambi Socio-Legal";
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
      return MaterialApp.router(
      title: 'Sistema Socio-legal Administrativo',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 0).getTheme(),
    );
  }
}
