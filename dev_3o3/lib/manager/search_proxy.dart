import 'package:dev_3o3/data/data.dart';
import 'package:dev_3o3/manager/search_manager.dart';
import 'package:flutter/material.dart';

class SearchProxy extends ChangeNotifier {
  final SearchManager manager;

  SearchProxy({
    required this.manager,
  });

  List<SearchData> get searchDatas => manager.searchRepo.searchDatas;

  List<SearchData> get favorDatas => manager.searchRepo.favorDatas;

  SearchData? get selectedDetails => manager.searchRepo.selectedDetail;

  void notify() {
    notifyListeners();
  }
}