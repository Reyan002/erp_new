
import 'dart:convert';
import 'package:abbasigroup/services/webservice.dart';
import 'package:abbasigroup/utils/constants.dart';

class NewsArticle {
  
  final String title; 
  final String author;
  final String descrption;
  final String urlToImage; 
  final String name;

  NewsArticle({this.title, this.descrption, this.urlToImage,this.author,this.name});

  factory NewsArticle.fromJson(Map<String,dynamic> json) {
    return NewsArticle(
      title: json['title'], 
      name: json['name'],
      author: json['author'],
      descrption: json['description'],
      urlToImage: json['urlToImage'] ?? Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL
    );
  
}

  static Resource<List<NewsArticle>> get all {
    
    return Resource(
      url: Constants.HEADLINE_NEWS_URL,
      parse: (response) {
        final result = json.decode(response.body); 
        Iterable list = result['articles'];
        return list.map((model) => NewsArticle.fromJson(model)).toList();
      }
    );

  }

}