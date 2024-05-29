import 'package:flutter/material.dart';

// - repo에서 선택된 검색데이터의 이미지를 출력하는 페이지

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _topTitleBar(),
          _imageView(),
        ],
      ),
    );
  }

  Widget _topTitleBar() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: _onBack, 
          child: const Text('back')
        ),
        const Text('이미지 상세 페이지'),
        const ElevatedButton(
          onPressed: null, 
          child: Text('back', style: TextStyle(color: Colors.white),),
        ),
      ],
    );
  }

  Widget _imageView() {
    // 로딩 추가필요 (네트워크 통신 지연 시간 고려)
    return Container(
      // child: Image.network(src),
    );
  }

  void _onBack() {
    // Proivder Back
  }
}