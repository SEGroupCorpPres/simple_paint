import 'package:simple_paint/app/app_barrels.dart';
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
      initialLocation: RouterNames.login,
      // initialLocation: RouterNames.register,
      // initialLocation: RouterNames.home,
      // initialLocation: RouterNames.paint,
      redirect: _redirect,
      refreshListenable: GoRouterRefreshStream(authBloc.stream),
      routes: [
        GoRoute(
          path: RouterNames.home,
          pageBuilder: (context, state) => _defaultPageBuilder(const HomePage(), state),
        ),
        GoRoute(
          path: RouterNames.paint,
          pageBuilder: (context, state) {
            final String? id = (state.extra as Map?)?['id'];
            final bool isEdit = (state.extra as Map?)?['isEdit'] ?? false;
            return _defaultPageBuilder(AddEditPaintPage(id: id, isEdit: isEdit), state);
          },
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
    if (authState is AuthInitialState || authState is AuthLoadingState) {
      return null; // splash da qolish
    }
    //
    //   // Auth state ga qarab yo'naltirish
    if (authState is AuthSignedInState) {
      return '/home';
    }
    //

    if (authState is AuthErrorState || authState is AuthSignedOutState) {
      // Xatolik bo'lsa login sahifaga
      return '/login';
    }
    return null; // redirect yo'q
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
