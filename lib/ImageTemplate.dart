class Image_tmp {
  final int id;
  final String pageurl;
  final String Type;
  final Tags ;
  final String preUrl ;
  final int prewidth;
  final int prevhight ;
  final String WebFromUrl;
  final int WebWidth;
  final int WebHeight;
  final String LargeUrl;
  final String FullHDUrl;
  final String Url;
  final Uri uri;
  final int width;
  final int height;
  final int size;
  final int views;
  final int downloads;
  final int likes;
  final int comments;
  final int UserId;
  final String User;
  final String UserUrl;

  Image_tmp({
  required this.id,
  required this.pageurl,
  required this.Type,
  required this.Tags,
  required this.preUrl,
  required this.prewidth,
  required this.prevhight,
  required this.WebFromUrl,
  required this.WebWidth,
  required this.WebHeight,
  required this.LargeUrl,
  required this.FullHDUrl,
  required this.Url,
  required this.uri,
  required this.width,
  required this.height,
  required this.size,
  required this.views,
  required this.downloads,
  required this.likes,
  required this.comments,
  required this.UserId,
  required this.User,
  required this.UserUrl,
});


  factory Image_tmp.formJson(Map<String,dynamic> json){

    return Image_tmp(
        id : json["id"] ,
        pageurl : json["pageURL"] ,
        Type : json["type"] ,
        Tags : json["tags"] ,
        preUrl : json["previewURL"] ,
        prewidth : json["previewWidth"] ,
        prevhight : json["previewHeight"] ,
        WebFromUrl : json["webformatURL"] ,
        WebWidth : json["webformatWidth"] ,
        WebHeight : json["webformatHeight"] ,
        LargeUrl : json["largeImageURL"] ,
        FullHDUrl : json["largeImageURL"] ,
        Url : json["largeImageURL"] ,
        uri: Uri.parse(json["largeImageURL"]),
        width : json["imageWidth"] ,
        height : json["imageHeight"] ,
        size : json["imageSize"] ,
        views : json["views"] ,
        downloads : json["downloads"] ,
        likes : json["likes"] ,
        comments : json["comments"] ,
        UserId : json["user_id"] ,
        User : json["user"] ,
        UserUrl : json["userImageURL"] ,
    );
  }

}