import 'package:flutter/material.dart';
import 'package:newsapp/components/AppBar.dart';
import 'package:newsapp/service/BookmarkModel.dart';
import 'package:newsapp/service/Dbconfig.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
    deleteAllPersons() async {
    final db = await database;
    db.delete("Bookmark");
  }
  Future<List<Bookmark>> getAllPersons() async {
    final db = await database;
    var response = await db.query("Bookmark");
    print(response);
    List<Bookmark> list = response.map((c) => Bookmark.fromMap(c)).toList();
    print("list");
    print(list[0]);
    print(list[0].id);
    return list;
  }

  Future<void> fetchOnRefresh() async {
    await getAllPersons();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: RefreshIndicator(
            onRefresh: fetchOnRefresh,
            child: FutureBuilder(
              future: getAllPersons(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {
                  print(snapshot.data.length);
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        if (snapshot.data != null) {
                          var key=snapshot.data[index];
                          print("------------------------");
                       print(key.urlToImage);

                          print(key.category);
                          return Column(
                            children: [
                           
                           
                              Card(
                                margin: EdgeInsets.all(5),
                                elevation: 5.0,
                                child: ListTile(
                                  isThreeLine: true,
                                  
                                   leading: Image(image: NetworkImage(key.urlToImage),),
                                   title:Text(key.title),
                                    subtitle: Column(children:[Text(key.note), Text(key.category),]),
                                    trailing: Icon(Icons.remove_red_eye)
                                   ),
                              ),
                            ],
                          );
                        }
                        return Text("waiting");
                      });
                }
                return CircularProgressIndicator();
              },
            )));
  }
}
