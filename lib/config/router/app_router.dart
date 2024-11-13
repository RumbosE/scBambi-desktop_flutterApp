import 'package:go_router/go_router.dart';
import 'package:sc_flutter_app/presentation/screens/form-child/form_child_screen.dart';
import 'package:sc_flutter_app/presentation/screens/home/home_screen.dart';
import 'package:sc_flutter_app/presentation/screens/info-child/info-child_screen.dart';
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
      builder: (context, state) => const SystemScreen(),
      ),

    GoRoute(
      path: '/system/add',
      name: FormChildScreen.name,
      builder: (context, state) => const FormChildScreen(),
    ),

    GoRoute(
      path: '/system/info/:id',
      name: InfoChildScreen.name,
      builder: (context, state) => InfoChildScreen(idChild: state.pathParameters['id'] ?? ''),
    ),
  ],

);
