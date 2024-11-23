
import 'package:bambi_socio_legal_scapp/config/router/app_router.dart';
import 'package:bambi_socio_legal_scapp/config/theme/app_theme.dart';
import 'package:bambi_socio_legal_scapp/injector.dart';
import 'package:bambi_socio_legal_scapp/presentation/blocs/delete-child/bloc/delete_child_bloc.dart';
import 'package:bambi_socio_legal_scapp/presentation/blocs/search-filter/search_filter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'infraestructure/core/enviroments.dart';
import 'presentation/blocs/children/child_bloc_bloc.dart';


void main() async {

  await Environment.initEnvironment();

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ChildrenBlocBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<DeleteChildBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<SearchFilterCubit>(),
        ),
      ],
      child: MaterialApp.router(
      title: 'Sistema Socio-legal Administrativo',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 0).getTheme(),
      ));
  }
}
