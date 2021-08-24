import 'dart:convert';
import 'package:app_template/src/models/news_api_model.dart';
import 'package:app_template/src/utils/utils.dart';
import 'package:app_template/src/widgets/new_tile_loader.dart';
import 'file:///C:/Users/aijut/AndroidStudioProjects/V-Phoenix/lib/src/screens/news_detail_page.dart';
import 'package:app_template/src/widgets/news_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Article> news = [];
  bool isLoading = false;
  String url = "https://saurav.tech/NewsAPI/top-headlines/category/health/in.json";
  Future<void> getNews() async {
    setState(() {
      isLoading = true;
    });
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach((element) {
        Article newsList = Article(
          urlToImage: element['urlToImage'],
          description: element['description'],
          title: element['title'],
          content: element['content'],
        );
        setState(() {
          news.add(newsList);
          isLoading = false;
        });
      });
    }
  }
    @override
    void initState() {
      super.initState();
      getNews();
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          height: screenHeight(context, dividedBy: 1),
          width: screenWidth(context, dividedBy: 1),
          color: Colors.white,
          padding: EdgeInsets.symmetric(
              vertical: screenHeight(context, dividedBy: 100),
              horizontal: screenHeight(context, dividedBy: 100)),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight(context, dividedBy: 20),
              ),
              Container(
                height: screenHeight(context, dividedBy: 15),
                width: screenWidth(context, dividedBy: 1),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.1),
                            width: 3
                        )
                    )
                ),
                child: Text(
                  "News", style: TextStyle(
                    fontSize: screenWidth(context, dividedBy: 10),
                    fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: screenHeight(context,dividedBy: 50),),
              Expanded(
                child: SingleChildScrollView(
                  child: isLoading==false? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: news.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          NewsTile(
                            image: news[index].urlToImage,
                              title: news[index].title,
                              description: news[index].description,
                            onPress: (){
                              push(context,NewsPage(
                                title: news[index].title,
                                description: news[index].description,
                                image: news[index].urlToImage,
                                content: news[index].content,
                              ));
                            },
                          ),
                          index != (news.length-1)?Divider(color: Colors.grey.withOpacity(0.5),):Container(),
                        ],
                      );
                    },
                  ):ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 8,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          NewsTileLoader(
                          ),
                          index<7?Divider(color: Colors.grey.withOpacity(0.5),):Container(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }