import 'package:dev_3o3/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// - repo에서 선택된 검색데이터의 이미지를 출력하는 페이지

class DetailsView extends StatelessWidget {

  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {

    SearchData detailData = Get.arguments;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _topTitleBar(),
            Expanded(child: _imageView(detailData.imageUrl)),
          ],
        ),
      ),
    );
  }

  Widget _topTitleBar() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: _onBack,
          child: const SizedBox(
            width: 48,
            height: 48,
            child: Icon(Icons.arrow_back, size: 48,),
          ),
        ),
        const Text('이미지 상세 페이지', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
        const SizedBox(
          width: 48,
          height: 48,
        )
      ],
    );
  }

  Widget _imageView(String imageUrl) {
    // 로딩 추가필요 (네트워크 통신 지연 시간 고려)
    return Image.network(
      imageUrl, 
      fit: BoxFit.fill, 
      loadingBuilder: (context, child, loadingProgress) {
                  
        if (loadingProgress == null) {
          return child;
        }
              
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        );
      },
    );
  }

  void _onBack() {
    Get.back();
  }
}