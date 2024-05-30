import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/data.dart';

class SearchService {

  final String _searchUrl = 'https://dapi.kakao.com/v2/search/image';

  final String _authKey = '42d7d928faa73076ccf490056d8cd79b';

  Future<List<SearchData>> getDatas({
    required String search
    }) async {

    final parseUrl = Uri.parse('$_searchUrl?target=title&query=$search');
    final response = await http.get(parseUrl, headers: {"Authorization" : 'KakaoAK $_authKey'});

    if (response.statusCode != 200) {
      return [];
    }

    final body = json.decode(response.body);

    final documents = body['documents'];

    List<SearchData> searchDatas = <SearchData>[];

    for (var item in documents) {
      SearchData data = SearchData.fromJson(item);
      searchDatas.add(data);
    }

    return searchDatas;

  }
}

