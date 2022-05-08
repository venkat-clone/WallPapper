import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wallpaper/webconnect.dart';
import 'package:wallpaper/ImageTemplate.dart';

import 'GridBulder.dart';
class ImageSearcher extends SearchDelegate<String>{
  bool show_ = true;
  show_cross(){
    if(show_)return [
      IconButton(
          onPressed: (){query = "";},
          icon: Icon(Icons.clear)
      )
    ];
    else return <Widget>[];
  }


  @override
  List<Widget>? buildActions(BuildContext context) {
    print("1");
    return show_cross();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    print("2");
    return IconButton(
      onPressed: (){
        Navigator.pop(context);
      },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    show_ = false;
    return mygrid(search: query);
    //   Builder(builder: (context){
    //
    //   return FutureBuilder(
    //       future: getSearch(query),
    //       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    //         print("sarch data");
    //         if (snapshot.data != null) {
    //           List<Image_tmp> lis = snapshot.data;
    //           // print(lis);
    //           return mygrid( lis: lis);
    //         }
    //
    //         return Center(
    //           child :Text("loading"),
    //         );
    //
    //       });
    // });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    show_ = true;
    return Builder(builder: (context){
      List<String> v = ["Nature","Sports","Bike","Anime","Animals","Logos","Designs","Drowings","Love","Sport","Technology","Space"];
      return Container(
          child :  Wrap(

            children:[
              for (String i in v )  GestureDetector(
                onTap: () {
                  query = i;
                  showResults(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(12),
                  ),
                  child: Card(
                    color: Colors.white60,
                    elevation: 2,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Text(i,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
      );
    });
  }
  
}