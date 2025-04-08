import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/widgets/news_list_view.dart';

class NewsListViewBuilder extends StatefulWidget {
  const NewsListViewBuilder({super.key, required this.category});

  final String category;

  @override
  State<NewsListViewBuilder> createState() => _NewsListViewBuilderState();
}

class _NewsListViewBuilderState extends State<NewsListViewBuilder> {
  var future;
  @override
  void initState() {
    super.initState();
    future = NewsService(Dio()).getTopHeadLines(category:widget.category);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticleModel>>(
      future: future,
       builder: (ctx,snapshot){
if(snapshot.hasData){
  return NewsListView(articles: snapshot.data!);
}else if (snapshot.hasError){
  return const SliverToBoxAdapter(
    child: Center(child: Text('Error Occured')));
       }else{
  return const SliverToBoxAdapter(
    child: Center(child: CircularProgressIndicator()));
       }
       }
       
       );
  }
}