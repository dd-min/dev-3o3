import 'package:dev_3o3/manager/search_manager.dart';
import 'package:dev_3o3/manager/search_proxy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/data.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  String _searchText = '';

  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    textController.addListener(_listener);

    SearchManager.instance().init();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _searchWidget(),
        const Divider(),
        Expanded(
          child: _searchViewWidget(),
        ),
      ],
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
                controller: textController,
                decoration: const InputDecoration(
                  hintText: '검색어를 입력해주세요',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async => await SearchManager.instance().search(_searchText), 
              child: const Text('Search'), 
            ),
          ],
        ),
      ],
    );
  }

  Widget _itemWidget(SearchData data) {
    // final state = repo.favorites.contains(data) == true ? 'On' : 'Off';
    return Column(
          children: [
            Image.network(data.thumbnailUrl),
            Text('display: ${data.displaySiteName}'),
          //   ElevatedButton(
          //     onPressed: () {
          //       _toggleFavorite(data);
          //     }, 
          //     // child: Text('favorSate : $state'))
          ],
        );
  }

  Widget _searchViewWidget() {

    final proxy = context.watch<SearchProxy>();

    final repo = proxy.searchDatas;

    if (repo.isEmpty || _searchText.isEmpty) {
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

  void _listener() {
    setState(() {
      _searchText = textController.text;
    });
  }

}