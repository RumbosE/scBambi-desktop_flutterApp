import 'package:go_router/go_router.dart';
import 'package:sc_flutter_app/presentation/screens/home/home_screen.dart';
import 'package:sc_flutter_app/presentation/screens/system/system_screen.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [

    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: '/system',
      name: SystemScreen.name,
      builder: (context, state) => SystemScreen(),
      )
  ],
);
