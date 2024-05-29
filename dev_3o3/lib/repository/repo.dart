import '../data/data.dart';

class Repository {
  List<SearchData> datas = [];
  List<SearchData> favorites = [];

  void addDatas(List<SearchData> inputs) {
    datas = inputs;
  }

  void removeData(SearchData data) {
    datas.remove(data);
  }

  void clearData() {
    datas = [];
  }

  void toggleFavorite(SearchData data) {
    if (favorites.contains(data) == true) {
      favorites.remove(data);
      return;
    }

    favorites.add(data);
    return;
  }

  void clearFavorite() {
    favorites = [];
  }

  void onLoaded() {
    // 처음 앱 구동 시 로컬 저장소 활용하여 데이터를 불러올 메서드.
  }
}