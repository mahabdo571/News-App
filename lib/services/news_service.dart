import 'package:dio/dio.dart';
import 'package:news_app/models/article_model.dart';

class NewsService {
  final Dio dio;

  NewsService(this.dio);

  Future<List<ArticleModel>> getTopHeadLines({required String category}) async {
    try {
      var response = await dio.get(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=9372ea89398043a18741330fd8540066&category=$category',
      );

      Map<String, dynamic> data = response.data;
      List<dynamic> articles = data['articles'];
      List<ArticleModel> articleList = [];
      for (var article in articles) {
        articleList.add(ArticleModel.fromJson(article));
      }
      return articleList;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
