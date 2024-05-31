import 'package:dev_3o3/data/data.dart';
import 'package:dev_3o3/manager/search_manager.dart';
import 'package:dev_3o3/manager/search_proxy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/item_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  String _searchText = '';

  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    textController.addListener(_listener);
  }


  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
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
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text('검색 필드', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: '검색어를 입력해주세요',
                  ),
                  onSubmitted: (value) async {

                    await SearchManager.instance().search(_searchText);

                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await SearchManager.instance().search(_searchText);

                  FocusScope.of(context).unfocus();
                  setState(() {});
                }, 
                child: const Text('Search'), 
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _searchViewWidget() {
    return Consumer<SearchProxy>(
      builder: (context, value, child) {

        final searchs = value.searchDatas;

         if (searchs.isEmpty || _searchText.isEmpty) {
            return const Align(
              alignment: Alignment.center,
              child: Text('검색어를 입력해주세요')
            );
        } 
        
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: searchs.length,
          itemBuilder: (context, index) {
      
            SearchData item = searchs[index];
      
            return GridItemWidget(
              data: item,
              );
          }
        );
      },
    );
  }

  void _listener() {
    setState(() {
      _searchText = textController.text;
    });
  }

}