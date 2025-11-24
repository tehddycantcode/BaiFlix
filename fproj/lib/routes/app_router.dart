import 'package:go_router/go_router.dart';
import '../pages/home_page.dart';
import '../pages/browse_page.dart';
import '../pages/details_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/browse',
      builder: (context, state) => const BrowsePage(),
    ),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return DetailsPage(contentId: id);
      },
    ),
  ],
);

