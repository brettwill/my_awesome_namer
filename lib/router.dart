//import 'package:english_words/english_words.dart';

import 'package:go_router/go_router.dart';
import 'package:namer_app/screens/hunde_suche_page.dart';
import 'package:namer_app/screens/login_screen.dart';

GoRouter router() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const MyLogin()),
      GoRoute(
        path: '/',
        builder: (context, state) => const HundeSuchePage(userName: ''),
      ),
      GoRoute(
        path: '/home/:username',
        builder: (context, state) {
          final username = state.pathParameters['username']!;
          return HundeSuchePage(userName: username);
        },
      ),
    ],
  );
}
