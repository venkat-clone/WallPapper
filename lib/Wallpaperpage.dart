import 'package:external_path/external_path.dart';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:permission_asker/permission_asker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'ImageTemplate.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Wallpaperpage extends StatefulWidget {
  const Wallpaperpage({Key? key, required Image_tmp this.img})
      : super(key: key);
  final img;

  @override
  _wallpaperpageState createState() => _wallpaperpageState(this.img);
}

class _wallpaperpageState extends State<Wallpaperpage> {
  var progr;
  Image_tmp img;
  _wallpaperpageState(this.img);

  show_my(String message) {
    print(message);
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[200],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {



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





    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Icon(
          Icons.arrow_back,
          size: 32,
          color: Colors.white,
        ),
      ),
      body: Container(
          // color: Colors.black,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(img.Url),
              fit: BoxFit.fitHeight,
              repeat: ImageRepeat.repeat,
            ),

            // backgroundBlendMode: BlendMode.color,
          ),
          padding: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Center(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 6),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    borderOnForeground: false,
                    elevation: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: AspectRatio(
                          aspectRatio: MediaQuery.of(context).size.width /
                              MediaQuery.of(context).size.height,
                          child: Hero(
                            tag:"hello",
                            child: build_image(img.Url),
                          )),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 0),
                child: Card(
                  color: Colors.white10,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PermissionAskerBuilder(
                          grantedBuilder: (BuildContext context) {
                            return IconButton(
                                padding: EdgeInsets.all(0),
                                splashRadius: 266,
                                splashColor: Colors.white10,
                                iconSize: 32,
                                onPressed: () async {
                                  var file = DateTime.now()
                                          .toString()
                                          .replaceAll("-", "")
                                          .replaceAll(":", "") +
                                      ".jpg";
                                  Dio dio = Dio();
                                  var v = await ExternalPath
                                      .getExternalStoragePublicDirectory(
                                          ExternalPath.DIRECTORY_DOWNLOADS);
                                  try {
                                    await dio.download(
                                      img.Url,
                                      "$v/$file",
                                    );
                                    print("Downloaded");
                                    show_my("Wallpaper Downloaded");
                                  } catch (Error) {
                                    print(Error);
                                    show_my("Error Occured");
                                  }
                                },
                                icon: Icon(
                                  Icons.download,
                                  color: Colors.white70,
                                ));
                          },
                          permissions: [Permission.storage],
                          notGrantedBuilder:
                              (BuildContext context, permissionNotGrantedData) {
                            return Center();
                          },
                        ),
                        IconButton(
                          padding: EdgeInsets.all(0),
                          splashRadius: 266,
                          splashColor: Colors.white10,
                          iconSize: 32,
                          icon: Icon(Icons.wallpaper, color: Colors.white70,),
                          onPressed: () async {
                            var file_ = await DefaultCacheManager().getSingleFile(img.Url, key: "key");
                            int location = WallpaperManager.HOME_SCREEN;
                            try {
                              var result = await WallpaperManager.setWallpaperFromFile(
                                  file_.path, location);
                              await file_.delete();
                              show_my("Wallpaper Updated");
                            } on Exception catch (e) {
                              print(e);
                              show_my("Wallpaper notupdated");
                            }
                          },
                        ),
                        IconButton(
                            padding: EdgeInsets.all(0),
                            splashRadius: 266,
                            splashColor: Colors.grey,
                            iconSize: 32,
                            onPressed: () async {
                              await FlutterShare.share(
                                title: 'Wallpaper Url',
                                text: img.Url,
                                linkUrl: img.Url,
                              );
                            }
                            , icon: Icon(Icons.share,color: Colors.white70,)

                        ),

                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
