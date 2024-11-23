import 'package:go_router/go_router.dart';
import 'package:bambi_socio_legal_scapp/presentation/screens/form-child/form_child_screen.dart';
import 'package:bambi_socio_legal_scapp/presentation/screens/home/home_screen.dart';
import 'package:bambi_socio_legal_scapp/presentation/screens/info-child/info-child_screen.dart';
import 'package:bambi_socio_legal_scapp/presentation/screens/system/system_screen.dart';

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
      path: '/system/edit/:id',
      name: 'edit',
      builder: (context, state) {
        final id = state.pathParameters['id']?? '';
        return FormChildScreen(id: id);
      },
    ),

    GoRoute(
      path: '/system/form',
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
