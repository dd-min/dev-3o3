import 'package:dev_3o3/data/data.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../manager/search_proxy.dart';
import '../common/item_view.dart';

// - repo에서 불러온 즐겨찾기 데이터 정보를 출력하는 페이지

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text('즐겨찾기 필드', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
          ),
        ),
        Expanded(
          child: Consumer<SearchProxy>(
            builder: (context, value, child) {
          
              final favors = value.favorDatas;
          
              if (favors.isEmpty) {
                  return const Align(
                    alignment: Alignment.center,
                    child: Text('즐겨 찾기가 없습니다.')
                  );
              } 
              
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: favors.length,
                itemBuilder: (context, index) {
            
                  SearchData item = favors[index];
            
                  return GridItemWidget(
                    data: item,
                  );
                }
              );
            },
          ),
        ),
      ],
    );
  }
}