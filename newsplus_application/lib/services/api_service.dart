import 'dart:convert';
import 'package:http/http.dart';

class NewsAPIService {
  Future<List<Article>> getArticle([String keyword = '']) async {
    if (keyword.isEmpty) {
      keyword = 'Technology';
    }

    String newsURL =
        'https://newsapi.org/v2/everything?q=$keyword&apiKey=5ef1d97fadc1488d9ad4aa1ec04ccb4d';
    Response res = await get(Uri.parse(newsURL));

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      List<dynamic> body = json['articles'];
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } else {
      return <Article>[];
    }
  }
}

class Article {
  Source source;
  String? author;
  String title;
  String? description;
  String url;
  String urlToImage;
  String? publishedAt;
  String? content;
  bool isBookmarked;

  Article(
      {required this.source,
      this.author,
      required this.title,
      this.description,
      required this.url,
      required this.urlToImage,
      this.publishedAt,
      this.content,
      this.isBookmarked = false});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      author: json['author'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      url: json['url'] as String,
      urlToImage: json['urlToImage'] as String? ??
          'https://i.ibb.co/NZF0b18/news-splash.png',
      publishedAt: json['publishedAt'] as String?,
      content: json['content'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'source': source.toJson(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
      'isBookmarked': isBookmarked,
    };
  }
}

class Source {
  String? id;
  String name;

  Source({this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
