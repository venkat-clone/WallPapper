import 'Search_Image.dart';
import 'ImageTemplate.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
@override
Future<List<Image_tmp>> get_() async {
  print("sending Requests...");
  Uri url1 = Uri.parse('https://pixabay.com/api/?key=24629785-e75fc0c88a1ec1501b86baf80&image_type=photo');
  final res = await http.get(url1);
  print("got json");


  var x= jsonDecode(res.body);
  List<Image_tmp> jsonList = [];

  for(var y in x["hits"]){
    Image_tmp hel = Image_tmp.formJson(y);
    jsonList.add(hel);
  }
  print("returned");

  // return v;
  return jsonList;

}

Future<List<Image_tmp>> getSearch(String q) async {
  q = q.replaceAll(" ", "+");
  print("sending Requests...");
  Uri url1 = Uri.parse('https://pixabay.com/api/?key=24629785-e75fc0c88a1ec1501b86baf80&image_type=photo&orientation=vertical&safesearch=true&q=$q');
  //
  final res = await http.get(url1);
  print("got json");

  var x= jsonDecode(res.body);
  List<Image_tmp> jsonList = [];

  for(var y in x["hits"]){
    Image_tmp hel = Image_tmp.formJson(y);
    jsonList.add(hel);

  }
  print("returned");

  return jsonList;

}