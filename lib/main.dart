import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpaper/ImageTemplate.dart';
import 'package:wallpaper/Search_Image.dart';
import 'package:wallpaper/webconnect.dart';

import 'GridBulder.dart';
import 'Wallpaperpage.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class Wallpaper_Json {
  final int total;
  final int totalHits;
  final hits;
  Wallpaper_Json({
    required this.total,
    required this.totalHits,
    required this.hits,
  });
  factory Wallpaper_Json.fromJson(Map<String, dynamic> json) {
    return Wallpaper_Json(
        total: json['total'], totalHits: json['totalHits'], hits: json['hits']);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // final RefreshController _refreshController = RefreshController

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Expanded(
    child: Center(
      child: Text("click me"),
    ),
  );



  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: Text("Wallpaper"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: ImageSearcher());
              },
            ),
          ],
        ),
        body: mygrid(),
    );
  }
}
