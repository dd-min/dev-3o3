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

  List<SearchData> _searchDatas = [];

  List<SearchData> get searchDatas => _searchDatas;

  List<SearchData> _favorDatas = [];

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
  Future<void> initLoadFavor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

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
        print('notData');
        _searchDatas = [];
      }

      final searchService = SearchService();

      // search processing
      final searchs  = await searchService.getDatas(search: input);

      // isFavor check
      for (var data in searchs) {
        if (_favorDatas.contains(data) == true) {
          data.isFavor = true;
        }
        else {
          data.isFavor = false;
        }
      }

      _searchDatas = searchs;
    } catch (e) {
      print(e);
    }
  }

  // - toggleFavor
  Future<void> toggleFavorite(SearchData data) async{
    if (_favorDatas.contains(data) == true) {
      _favorDatas.remove(data);

      await overwriteFavorPrefs();
      return;
    }

    _favorDatas.add(data);
    await overwriteFavorPrefs();
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
  }
}