import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newsapp/components/AppBar.dart';
import 'package:newsapp/service/BookmarkModel.dart';
import 'package:newsapp/service/Dbconfig.dart';
import 'package:newsapp/service/shareService.dart';
import 'package:newsapp/service/webview.dart';

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

  deletePersonWithId(int id) async {
    final db = await database;

    return db.delete("Bookmark", where: "id = ?", whereArgs: [id]);
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
                          var key = snapshot.data[index];
                          print("------------------------");
                          print(key.urlToImage);

                          print(key.category);
                          return Column(
                            children: [
                              Card(
                                margin: EdgeInsets.all(5),
                                elevation: 5.0,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      child: Image(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(key.urlToImage),
                                      ),
                                    )),
                                    Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            children: [
                                              Text(key.title),
                                              Text(key.category),
                                            ],
                                          ),
                                        )),
                                    GestureDetector(
                                        onTap: () {
                                          bottomsheet(context, key);
                                        },
                                        child: Icon(Icons.more_vert))
                                  ],
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

  Future bottomsheet(BuildContext context, key) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  launchInBrowser(key.url);
                },
                leading: Icon(Icons.visibility),
                title: Text("Read more"),
                subtitle: Text("View the original news source"),
              ),
              ListTile(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            title: Row(
                              children: [Icon(Icons.edit), Text("your note")],
                            ),
                            content: Text(key.note));
                      });
                },
                leading: Icon(Icons.note_add),
                title: Text("Read note"),
                subtitle: Text("Read the note you had taken during bookmark"),
              ),
              ListTile(
                onTap: () {
                  deletePersonWithId(key.id);
                  setState(() {
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: "🚮 Deleted bookmark");
                  });
                },
                leading: Icon(Icons.delete),
                title: Text("Delete bookmark"),
                subtitle: Text("Once deleted cannot be retrived"),
              ),
              ListTile(
                onTap: () {
                  onShare(context, key.title, key.url);
                },
                leading: Icon(Icons.share),
                title: Text("Share bookmark"),
                subtitle: Text("share tour bookmark with others"),
              ),
            ],
          );
        });
  }
}
