import 'dart:convert';
import 'package:practice/model/newsmodel.dart';
import 'package:http/http.dart';

class News {
  List<ArticleModel> data = [];

  Future<void> getNews() async {
    int count = 1;
    bool hasMoreData = true;

    while (hasMoreData && count <= 5) {
      var response = await get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?language=en&page=$count&apiKey=f76eeb554e4146238379bd402e4d901b'));
      var jsonData = jsonDecode(response.body);

      if (jsonData['status'] == 'ok') {
        if (jsonData['articles'].isEmpty) {
          hasMoreData = false;
        } else {
          for (var element in jsonData['articles']) {
            if (element['urlToImage'] != null &&
                element['description'] != null) {
              ArticleModel articleModel = ArticleModel(
                  title: element['title'],
                  description: element['description'],
                  url: element['url'],
                  urlToImage: element['urlToImage']);
              data.add(articleModel);
            }
          }
          count++;
        }
      } else {
        hasMoreData = false;
      }
    }
  }
}

class CategoryNews {
  List<ArticleModel> data = [];

  Future<void> getNews(String category) async {
    int count = 1;
    bool hasMoreData = true;

    while (hasMoreData && count <= 5) {
      String url =
          'https://newsapi.org/v2/top-headlines?language=en&category=$category&page=$count&apiKey=f76eeb554e4146238379bd402e4d901b';
      if (category.toLowerCase() == 'india') {
        url =
            'https://newsapi.org/v2/top-headlines?country=in&apiKey=f76eeb554e4146238379bd402e4d901b';
      }
      var response = await get(Uri.parse(url));
      var jsonData = jsonDecode(response.body);

      if (jsonData['status'] == 'ok') {
        if (jsonData['articles'].isEmpty) {
          hasMoreData = false;
        } else {
          for (var element in jsonData['articles']) {
            if (element['urlToImage'] != null &&
                element['description'] != null) {
              ArticleModel articleModel = ArticleModel(
                  title: element['title'],
                  description: element['description'],
                  url: element['url'],
                  urlToImage: element['urlToImage']);
              data.add(articleModel);
            }
          }
          count++;
        }
      } else {
        hasMoreData = false;
      }
    }
  }
}

class CategoryNews_q {
  List<ArticleModel> data = [];

  Future<void> getNews_q(String category) async {
    int count = 1;
    bool hasMoreData = true;

    while (hasMoreData && count <= 5) {
      String url =
          'https://newsapi.org/v2/everything?language=en&q=$category&page=$count&apiKey=f76eeb554e4146238379bd402e4d901b';
      var response = await get(Uri.parse(url));
      var jsonData = jsonDecode(response.body);

      if (jsonData['status'] == 'ok') {
        if (jsonData['articles'].isEmpty) {
          hasMoreData = false;
        } else {
          for (var element in jsonData['articles']) {
            if (element['urlToImage'] != null &&
                element['description'] != null) {
              ArticleModel articleModel = ArticleModel(
                  title: element['title'],
                  description: element['description'],
                  url: element['url'],
                  urlToImage: element['urlToImage']);
              data.add(articleModel);
            }
          }
          count++;
        }
      } else {
        hasMoreData = false;
      }
    }
  }
}
