import 'package:dev_3o3/manager/search_manager.dart';
import 'package:dev_3o3/view/favorites/favorites.dart';
import 'package:dev_3o3/view/search/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

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
    return GetMaterialApp(
      title: '삼쩜삼 검색 페이지',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  TabController? tabController;

  @override
  void initState() {
    super.initState();

    SearchManager.instance().init();

    tabController = TabController(length: 2, vsync: this);
    tabController?.addListener(tabListener);
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabController!.index,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: '즐겨찾기'),
        ],
        onTap: (index) {
          tabController?.animateTo(index);
        },
      ),
      body: SafeArea(
        child: TabBarView(
          controller: tabController,
          children: const [
            SearchView(),
            FavoritesView(),
          ]
        ),
      )
    );
  }

  void tabListener() {
    setState(() {
      
    });
  }
}
