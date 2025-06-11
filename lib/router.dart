//import 'package:english_words/english_words.dart';

import 'package:go_router/go_router.dart';
import 'package:namer_app/screens/cart.dart';
import 'package:namer_app/screens/catalog.dart';
import 'package:namer_app/screens/home.dart';
import 'package:namer_app/screens/hunde_suche_page.dart';
import 'package:namer_app/screens/login_screen.dart';

GoRouter router() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const MyLogin()),
      GoRoute(path: '/', builder: (context, state) => const HundeSuchePage()),
      GoRoute(
        path: '/home/:username',
        builder: (context, state) {
          final username = state.pathParameters['username']!;
          return MyHomePage(userId: username);
        },
      ),
      // GoRoute(
      //     path: '/home/:userId',
      //     builder: (context, state) {
      //       final userId = state.pathParameters['userId']!;
      //       return MyHomePage(userId: userId);
      //     },
      //     routes: [
      //       GoRoute(
      //         path: 'catalog',
      //         builder: (context, state) => const MyCatalog(),
      //       ),
      //     ],
      //   ),
      GoRoute(
        path: '/catalog',
        builder: (context, state) => const MyCatalog(),
        routes: [
          GoRoute(path: 'cart', builder: (context, state) => const MyCart()),
        ],
      ),
    ],
  );
}
