import 'package:dev_3o3/data/data.dart';
import 'package:dev_3o3/manager/search_manager.dart';
import 'package:dev_3o3/view/details/details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class GridItemWidget extends StatefulWidget {
  final SearchData data;
  
  const GridItemWidget({
    super.key, 
    required this.data, 
  });

  @override
  State<GridItemWidget> createState() => _GridItemWidgetState();
}

class _GridItemWidgetState extends State<GridItemWidget> {

  bool isFavor = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    isFavor = widget.data.isFavor == true ? true : false;

    return GestureDetector(
      onTap: () => _onTapDetailPage(widget.data),
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black,),
              ),
              child: Image.network(
                widget.data.imageUrl, 
                fit: BoxFit.fitWidth, 
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
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Text(widget.data.displaySiteName)),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('즐겨찾기'),
                    SizedBox(
                      width: mediaQuery.size.width / 6,
                      child: IconButton(
                        icon: const Icon(Icons.star_outline_sharp),
                        color: isFavor ? Colors.red : Colors.grey,
                        onPressed: () async {
                          await SearchManager.instance().toggleFavor(widget.data);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
            
          ],
        ),
      ),
    );
  }

  void _onTapDetailPage(SearchData data) {
    Get.to(() => const DetailsView(), arguments: data);
  }
}