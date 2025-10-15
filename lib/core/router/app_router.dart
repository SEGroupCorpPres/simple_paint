import 'package:simple_paint/core/router/router.dart';
import 'package:simple_paint/features/home/presentation/pages/home_page.dart';
import 'package:simple_paint/features/paint/presentation/pages/add_edit_paint_page.dart';
Page<dynamic> _defaultPageBuilder(Widget child, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final AuthBloc authBloc;
  late final GoRouter router;

  AppRouter({required this.authBloc}) {
    router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      // initialLocation: '/login',
      // initialLocation: '/registration',
      initialLocation: '/home',
      // initialLocation: '/paint',
      redirect: _redirect,
      refreshListenable: GoRouterRefreshStream(authBloc.stream),
      routes: [
        GoRoute(
          path: RouterNames.home,
          pageBuilder: (context, state) => _defaultPageBuilder(const HomePage(), state),
        ),
        GoRoute(
          path: RouterNames.paint,
          pageBuilder: (context, state) => _defaultPageBuilder(const AddEditPaintPage(), state),
        ),
        GoRoute(
          path: RouterNames.login,
          builder: (context, state) {
            return LoginPage();
          },
        ),

        GoRoute(
          path: RouterNames.register,
          builder: (context, state) {
            return RegistrationPage();
          },
        ),
      ],
    );
  }

  // static GoRouter goRouter
  String? _redirect(BuildContext context, GoRouterState state) {
    final authState = authBloc.state; // context.read o'rniga to'g'ridan-to'g'ri authBloc
    final currentLocation = state.matchedLocation;

      // Auth tekshiruvi boshlang'ich holatda bo'lsa, splash da qoladi
    //   if (authState is AuthInitial || authState is AuthLoading) {
    //     return null; // splash da qolish
    //   }
    //
    //   // Auth state ga qarab yo'naltirish
    //   if (authState is Authenticated) {
    //     return '/home';
    //   }
    //
    //   if (authState is AuthError) {
    //     // Xatolik bo'lsa login sahifaga
    //     return '/login';
    //   }
    //
    //   if (authState is AuthRequired) {
    //     // Auth talab qilingan, login ga yo'naltirish
    //     final redirect = authState.redirectAfterAuth;
    //     if (redirect != null && redirect.isNotEmpty) {
    //       return '/login?redirect=${Uri.encodeComponent(redirect)}';
    //     }
    //     return '/login';
    //   }
    //
    // // Auth bo'lgan foydalanuvchini login/register sahifalaridan home ga yo'naltirish
    // if (authState is Authenticated &&
    //     (currentLocation.startsWith('/login') || currentLocation.startsWith('/registration'))) {
    //   return '/home';
    // }
    //
    // // Onboarding logic - agar kerak bo'lsa
    // // GuestState yoki AuthenticatedState dan onboarding ga yo'naltirish
    // // Bu logic sizning business requirement ga bog'liq
    //
    // return null; // redirect yo'q
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((dynamic _) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
