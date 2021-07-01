class Bookmark {
  int id;
  String title;
  String note;
  String url;
  String category;
  String urlToImage;


  Bookmark({this.id, this.title,this.note,this.url,this.category,this.urlToImage});

  factory Bookmark.fromMap(Map<String, dynamic> json) => new Bookmark(
        id: json["id"],
        title: json["title"],
        note: json["note"],
        url: json["url"],
        category: json["category"],
        urlToImage: json["urlToImage"],


  
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "note": note,
        "url": url,
        "category": category,
        "urlToImage":urlToImage

      };
}