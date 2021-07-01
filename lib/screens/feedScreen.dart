import 'package:flutter/material.dart';
import 'package:newsapp/components/AppBar.dart';
import 'package:newsapp/service/BookmarkModel.dart';
import 'package:newsapp/service/Dbconfig.dart';
import 'package:newsapp/service/FeedResponse.dart';
import 'package:sqflite/sqflite.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  String topic = "";

  addBookmarkToDatabase(Bookmark bookmark) async {
    final db = await database;
    var raw = await db.insert(
      "Bookmark",
      bookmark.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  TextEditingController _noteInBookmark = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          SizedBox(
            height: 75.0,
            child: Container(
              margin: EdgeInsets.all(10.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  topicChoose("Headlines", () {
                    setState(() {
                      topic = "";
                    });
                  }),
                  topicChoose("Business", () {
                    setState(() {
                      topic = "business";
                    });
                  }),
                  topicChoose("Entertainment", () {
                    setState(() {
                      topic = "entertainment";
                    });
                  }),
                  topicChoose("general", () {
                    setState(() {
                      topic = "general";
                    });
                  }),
                  topicChoose("Health", () {
                    setState(() {
                      topic = "health";
                    });
                  }),
                  topicChoose("Science", () {
                    setState(() {
                      topic = "science";
                    });
                  }),
                  topicChoose("Sports", () {
                    setState(() {
                      topic = "sports";
                    });
                  }),
                  topicChoose("Technology", () {
                    setState(() {
                      topic = "technology";
                    });
                  }),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/ch");
                      },
                      child: Text("chscreen"))
                ],
              ),
            ),
          ),
          FutureBuilder(
            future: fetchdata(topic),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data.status);
                var articles = snapshot.data.articles;
                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        var key = articles[index];
                        TextEditingController _titleInBookmark =
                            TextEditingController(text:key.title );

                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Card(
                            elevation: 5.0,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  (key.urlToImage != null)
                                      ? Image(
                                          image: NetworkImage(key.urlToImage))
                                      : CircularProgressIndicator(),
                                  SizedBox(height: 5.0),
                                  (key.title == null)
                                      ? Text("")
                                      : Text(
                                          key.title,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                  SizedBox(height: 5.0),
                                  (key.description == null)
                                      ? Text("")
                                      : Text(
                                          key.description,
                                          style: TextStyle(fontSize: 15.0),
                                        ),
                                  SizedBox(height: 5.0),
                                  SizedBox(
                                    height: 50.0,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        (key.source.name == null)
                                            ? Text("")
                                            : Chip(
                                                padding: EdgeInsets.all(10.0),
                                                avatar: CircleAvatar(
                                                  child: Icon(
                                                      Icons.source_outlined),
                                                ),
                                                label: Text(key.source.name)),
                                        GestureDetector(
                                          onTap: () {
                                            print("hi");
                                          },
                                          child: Chip(
                                            label: Text("View more"),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        IconButton(
                                            icon: Icon(Icons.share),
                                            onPressed: () {}),
                                        IconButton(
                                            icon: Icon(Icons.favorite),
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          "Add to favourite"),
                                                      content: SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                    
                                                          children: [
                                                            TextFormField(
                                                              decoration: decorationNewsInput(
                                                                "News Title","News Title"
                                                              ),
                                                              controller:
                                                                  _titleInBookmark,

                                                            ),
                                                            SizedBox(height: 10.0,),
                                                            TextFormField(
                                                              controller:
                                                                  _noteInBookmark,
                                                                  decoration:decorationNewsInput(
                                                                "Add note","Add note"
                                                              ),
                                                            ),
                                                            
                                                            (topic == "")
                                                                ? Chip(label: Text("Headline"))
                                                                : Chip(label: Text(topic),),
                                                          ],
                                                        ),
                                                      ),
                                                      actions: [
                                                        OutlinedButton(
                                                          onPressed: () {
                                                            addBookmarkToDatabase(
                                                              Bookmark(
                                                                  title:
                                                                      _titleInBookmark
                                                                          .text,
                                                                  note:
                                                                      _noteInBookmark
                                                                          .text,
                                                                  category: (topic ==
                                                                          "")
                                                                      ? "Headline"
                                                                      : topic,
                                                                  url: key.url,
                                                                  urlToImage: key.urlToImage
                                                                  ),
                                                            );
                                                            print("added");
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text("Add"),
                                                        )
                                                      ],
                                                    );
                                                  });
                                            }),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              } else
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: CircularProgressIndicator()),
                  ],
                );
            },
          ),
        ],
      ),
    );
  }

  InputDecoration decorationNewsInput(String hint,String label) {
    return InputDecoration(
                                                            hintText: hint,
                                                            labelText: label,
                                                            
                                                            border: OutlineInputBorder(

                                                            )
                                                          );
  }

  Container topicChoose(String title, Function state) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: OutlinedButton(
          onPressed: state,
          child: Text(title, style: TextStyle(fontSize: 20.0))),
    );
  }
}
