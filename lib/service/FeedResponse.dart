 
import 'package:newsapp/service/ModelNews.dart';
import 'package:http/http.dart' as http;
 
 
 Future <NewsModel> fetchdata(String topic) async {
  //  https://newsapi.org/v2/top-headlines?category=sports&apiKey=e2378d13af214683b7ffc7ff3618ec26&country=in
  Map<String,String> query={
     "category":topic,
     "apiKey":"",
     "country":"in"

  };
  final response = await http.get(
    Uri.https('newsapi.org','/v2/top-headlines',query));
  if (response.statusCode == 200) {
    print(response.body);
    // If the server did return a 200 OK response,
    // then parse the JSON.


print(response.body);
   
    return newsModelFromJson(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
