import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver.dart';
import 'package:flutter/src/rendering/sliver_grid.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpaper/webconnect.dart';

import 'ImageTemplate.dart';
import 'Wallpaperpage.dart';

class mygrid extends StatefulWidget {
  const mygrid({Key? key,String this.search=""}) : super(key: key);
  final String search;
  @override
  _mygridState createState() => _mygridState(search);
}

class _mygridState extends State<mygrid> {

  List<Image_tmp> lis =[];
  String search_ ;

  _mygridState(this.search_);


  final RefreshController _refreshController =
  RefreshController(initialRefresh: true);


  add_data({bool reload = false}) async {
    if (reload) lis = [];
    List<Image_tmp> new_lis = await getSearch(search_);
    setState(() {});
    for (Image_tmp x_i in new_lis) lis.add(x_i);
    print("data_added");
  }



  build_image(String url){
    return Image(

      errorBuilder: (BuildContext con,Object h,StackTrace? k){
        return Center(
          child: Shimmer.fromColors(
            baseColor: Colors.red.shade200,
            highlightColor: Colors.grey.shade100,
            child: Container(
              color: Colors.white,
            ),
          ),
        );
      },

      loadingBuilder: (BuildContext con, Widget child,
          ImageChunkEvent? loadingProgress) {
        if(loadingProgress == null) return child;
        return Center(
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade100,
            child: Container(
              color: Colors.white,
            ),
          ),
        );
      },
      fit: BoxFit.fitHeight,
      image: NetworkImage(url),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullUp: true,
      enablePullDown: true,
      onRefresh: () async {
        add_data(reload: true);
        _refreshController.refreshCompleted();
        print("loading completed");
        setState(() {});
      },
      onLoading: () async {
        add_data();
        _refreshController.loadComplete();
        setState(() {});
      },
      controller: _refreshController,
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 5),
        itemCount: lis.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.5625,
        ),
        itemBuilder: (context, position) {
          if (null == lis[position]) {
            return Container(
              height: 300,
              child: Icon(
                Icons.ten_k_outlined,
              ),
            );
          }
          return GestureDetector(
            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Wallpaperpage(img:lis[position]))),
            child: Container(
              padding: EdgeInsets.all(0.5),
              child: Card(
                shadowColor: Colors.black,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Container(
                    child: Hero(
                      tag:"hello",
                      child: build_image(lis[position].Url),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
