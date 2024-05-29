import 'package:flutter/material.dart';

import 'service/search.dart';
import 'repository/repo.dart';
import 'data/data.dart';

part 'view/main/func.dart';

void main() {
  runApp(const MyApp());
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

  String searchText = '';
  String resultText = '';

  final repo = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _searchWidget(),
            const Divider(),
            Expanded(
            child: _searchViewWidget(repo.datas),
            ),
          ],
        ),
      )
    );
  }

  Widget _searchWidget() {
    return Column(
      children: [
        const Align(
              alignment: Alignment.topLeft,
              child: Text('검색 필드'),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: '검색어를 입력해주세요',
                    ),
                    onChanged: (value) => onChanged(value),
                  ),
                ),

                ElevatedButton(
                  onPressed: search, 
                  child: const Text('Search'), 
                ),
              ],
            ),
      ],
    );
  }

  Widget _itemWidget(SearchData data) {
    final state = repo.favorites.contains(data) == true ? 'On' : 'Off';
    return Column(
          children: [
            Image.network(data.thumbnailUrl),
            Text('display: ${data.displayStieName}'),
            ElevatedButton(
              onPressed: () {
                _toggleFavorite(data);
              }, 
              child: Text('favorSate : $state'))
          ],
        );
  }


  Widget _searchViewWidget(List<SearchData> repo) {

    if (repo.isEmpty || searchText.isEmpty) {
      return const Align(
        alignment: Alignment.center,
        child: Text('검색어를 입력해주세요')
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: repo.length,
      itemBuilder: (context, index) {

        final item = repo[index];

        return _itemWidget(item);
      }
    );
  }
}
