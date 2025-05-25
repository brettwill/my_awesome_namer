//import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:namer_app/models/app_state.dart';
import 'package:namer_app/screens/generator.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/common/theme.dart';
import 'package:namer_app/models/cart.dart';
import 'package:namer_app/models/catalog.dart';
import 'package:namer_app/screens/cart.dart';
import 'package:namer_app/screens/catalog.dart';
import 'package:namer_app/screens/login.dart';

void main() {
  runApp(MyApp());
}

GoRouter router() {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const MyLogin(),
      ),
      GoRoute(
        path: '/home/:userId',
        builder: (context, state) {
          final userId = state.pathParameters['userId']!;
          return MyHomePage(userId: userId);
        },
        routes: [
          GoRoute(
            path: 'catalog',
            builder: (context, state) => const MyCatalog(),
          ),
        ],
      ),
      GoRoute(
        path: '/catalog',
        builder: (context, state) => const MyCatalog(),
        routes: [
          GoRoute(
            path: 'cart',
            builder: (context, state) => const MyCart(),
          ),
        ],
      ),
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (context) => CatalogModel()),
        ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        ),
        //home: MyHomePage(),
      ),),
    
// CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Provider Demo',
        theme: appTheme,
        routerConfig: router(),        
      ),
    );
  }
}



class MyHomePage extends StatefulWidget {
  final String userId;
  const MyHomePage({super.key, required this.userId});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      case 2:
        page = DogNutritionPage();
        break;
      case 3:
        page = DogSchoolPage();
        break;
      default:
        throw UnimplementedError('No widget for $selectedIndex');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Namer App - Welcome, ${widget.userId}'),
        actions: [
  // "More" menu
  PopupMenuButton<int>(
    onSelected: (value) {
      setState(() {
        selectedIndex = value;
      });
    },
    itemBuilder: (context) => [
    PopupMenuItem(value: 2, child: Text('Dog School')),
    PopupMenuItem(value: 3, child: Text('Nutrition')),
  ],
  child: TextButton.icon(
    onPressed: null,
    icon: Icon(Icons.arrow_drop_down, color: Colors.white),
    label: Text('More', style: TextStyle(color: Colors.blue)),
  ),
  
),


  // "Info" menu
  PopupMenuButton<int>(
    onSelected: (value) {
      setState(() {
        selectedIndex = value;
      });
    },
    itemBuilder: (context) => [
      PopupMenuItem(
        value: 0,
        child: Text('Home'),
      ),
      PopupMenuItem(
        value: 1,
        child: Text('Favorites'),
      ),
    ],
    child: TextButton.icon(
      onPressed: null,
      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
      label: Text('Info', style: TextStyle(color: Colors.blue)),
    ),
  ),

  PopupMenuButton<int>(
    itemBuilder: (context) => [],
  
  child: TextButton.icon(
    onPressed: () => context.go('/login'),
    icon: Icon(Icons.arrow_drop_down, color: Colors.white),
    label: Text('Log out', style: TextStyle(color: Colors.blue)),
  ),
  
),

],


      ),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: page,
      ),
    );
  }
}



class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have '
              '${appState.favorites.length} favorites:'),
        ),
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}

class DogNutritionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
 //   var appState = context.watch<MyAppState>();

   // if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No dog food yet.'),
      );
    //}

   
  }
}

class DogSchoolPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
 //   var appState = context.watch<MyAppState>();

   // if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No Schooling today.'),
      );
    //}

   
  }
}
