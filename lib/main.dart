import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/data/api/api_service.dart';
import 'package:tourism_app/provider/detail/tourism_detail_provider.dart';
import 'package:tourism_app/provider/home/tourism_list_provider.dart';
import 'package:tourism_app/provider/main/index_nav_provider.dart';
import 'package:tourism_app/screen/main/main_screen.dart';
import 'package:tourism_app/static/navigation_route.dart';
import 'package:tourism_app/screen/detail_screen.dart';
import 'package:tourism_app/style/theme/tourism_theme.dart';
import 'package:tourism_app/provider/bookmark/local_database_provider.dart';
import 'package:tourism_app/data/local/local_database_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),

        Provider(create: (context) => ApiServices()),
        ChangeNotifierProvider(
          create: (context) => TourismListProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              TourismDetailProvider(context.read<ApiServices>()),
        ),
        Provider(create: (context) => LocalDatabaseService()),
        ChangeNotifierProvider(
          create: (context) =>
              LocalDatabaseProvider(context.read<LocalDatabaseService>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: TourismTheme.lightTheme,
      darkTheme: TourismTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
          tourismId: ModalRoute.of(context)?.settings.arguments as int,
        ),
      },
    );
  }
}

class SliverApp extends StatelessWidget {
  const SliverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.blue,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                "https://picsum.photos/1600/900",
                fit: BoxFit.cover,
              ),
              expandedTitleScale: 1.5,
              title: const Text(
                'SliverAppBar aja',
                style: TextStyle(color: Colors.white),
              ),
              //titlePadding: const EdgeInsets.all(16),
            ),
          ),
          SliverToBoxAdapter(
            child: ListTile(title: Text("Header of SliverToBoxAdapter")),
          ),
          SliverList.builder(
            itemCount: 1000,
            itemBuilder: (context, index) {
              return ListTile(title: Text("Index $index"));
            },
          ),
        ],
      ),
    );
  }
}
