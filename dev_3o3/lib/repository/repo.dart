import 'package:dev_3o3/manager/search_manager.dart';
import 'package:dev_3o3/service/search_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../data/data.dart';

class SearchRepository {

  final SearchManager manager;

  SearchRepository({
    required this.manager,
  });

  List<SearchData> _searchDatas = <SearchData>[];

  List<SearchData> get searchDatas => _searchDatas;

  List<SearchData> _favorDatas = <SearchData>[];

  List<SearchData> get favorDatas => _favorDatas;

  SearchData? _selectedDetail;

  SearchData? get selectedDetail => _selectedDetail;


  /////////////// Fucntion /////////////////////
  ///
  /// initLoad , search , toggleFavor , selectedDetail
  /// 
  /// 
  
  // - initLoad
  // - sharedPreferences get
  Future<void> loadFavor({
    bool isUpdate = false,
  }) async {

    if (isUpdate == true) {
      _favorDatas.clear();
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? favors = prefs.getString('favors');

    if (favors == null) {
      return;
    }

    final body = json.decode(favors);

    List<SearchData> loadedDatas = <SearchData>[];

    for (var item in body) {
      SearchData data = SearchData.fromJson(item);
      loadedDatas.add(data);
    }

    _favorDatas = loadedDatas;
  }

  // - search
  Future<void> search(String input) async {

    try {

      if (_searchDatas.isNotEmpty) {
        _searchDatas.clear();
      }

      final searchService = SearchService();

      // search processing
      final searchs  = await searchService.getDatas(search: input);

      // isFavor check
      for (SearchData search in searchs) {
        for (SearchData favor in _favorDatas) {
          if (search.imageUrl == favor.imageUrl) {
            final newData = search;
            newData.isFavor = true;

          }
        }
      }

      _searchDatas = searchs;
    } catch (e) {
      print(e);
    }
  }

  Future<void> toggleFavor(SearchData data) async {

    // remove
    for (SearchData favor in _favorDatas) {
      if (favor.imageUrl == data.imageUrl) {

        _favorDatas.remove(favor);

        if (_searchDatas.isNotEmpty) {
          for (SearchData search in _searchDatas) {
            if (search.imageUrl == data.imageUrl) {
              search.isFavor = false;
              await overwriteFavorPrefs();
              return;
            }
          }
        }

        await overwriteFavorPrefs();
        return;
      }
    }

    // add
    for (SearchData search in _searchDatas) {
      if (search.imageUrl == data.imageUrl) {

        search.isFavor = !search.isFavor;

        final newData = data;
        newData.isFavor = true;
        _favorDatas.add(newData);
        await overwriteFavorPrefs();
      }
    }
  }

  void selectDetail(SearchData data) {
    _selectedDetail = data;
  }

  void unSelectDetail() {
    _selectedDetail = null;
  }

  // sharedPrefrences overwrite
  Future<void> overwriteFavorPrefs() async{
    final prefs = await SharedPreferences.getInstance();
    final encode = json.encode(_favorDatas);

    await prefs.setString('favors', encode);

    await loadFavor(isUpdate: true);
  }
}