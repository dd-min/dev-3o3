import 'package:dev_3o3/data/data.dart';
import 'package:dev_3o3/manager/search_proxy.dart';
import 'package:dev_3o3/repository/repo.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class SearchManager {

  // Singleton
  static SearchManager? _instance;


  factory SearchManager.instance() {
    _instance ??= SearchManager._();

    return _instance!;
  }

  /// Instance
  
  late final SearchProxy _proxy;
  late final SearchRepository _searchRepo;

  SearchRepository get searchRepo => _searchRepo;

  SearchManager._() {
    _proxy = SearchProxy(manager: this);
  }

  Future<void> init() async {
    _searchRepo = SearchRepository(manager: this);
    await initLoadFavor();
  }

  List<SingleChildWidget> generateProvider() {
    List<SingleChildWidget> providerList = [];

    providerList.add(
      ChangeNotifierProvider(create: (_) => _proxy),
    );

    return providerList;
  }

  /////////////// Fucntion /////////////////////
  ///
  /// initLoad , search , toggleFavor , selectedDetail
  /// 
  /// 
  
  Future<void> initLoadFavor() async {
    await _searchRepo.loadFavor();

    _proxy.notify();
  }

  Future<void> search(String input) async {
    await _searchRepo.search(input);

    _proxy.notify();
  }

  Future<void> toggleFavor(SearchData data) async {
    await _searchRepo.toggleFavor(data);

    _proxy.notify();
  }

  void selectDetail(SearchData data) {
    _searchRepo.selectDetail(data);

    _proxy.notify();
  }

  void unSelectDetail() {
    _searchRepo.unSelectDetail();

    _proxy.notify();
  }
}