import 'package:dev_3o3/manager/search_manager.dart';
import 'package:dev_3o3/view/favorites/favorites.dart';
import 'package:dev_3o3/view/search/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'view/main/func.dart';

void main() {
  // runApp(const MyApp());
  runApp(
    MultiProvider(
      providers: [
      ...SearchManager.instance().generateProvider(),
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
      title: '삼쩜삼 검색 페이지',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '삼쩜삼 검색 페이지'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: const SafeArea(
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    SearchView(),
                    FavoritesView(),
                  ]
                ),
              ),
              TabBar(
                indicatorColor: Colors.black,
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                tabs: [
                  Tab(text: '검색',),
                  Tab(text: '즐겨찾기',),
              ])
            ],
          ),
        )
      ),
    );
  }
}
