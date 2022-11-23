import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'details_screen.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({Key? key, required this.articles}) : super(key: key);
  final List<Article> articles;
  @override
  OverviewScreenState createState() => OverviewScreenState();
}

class OverviewScreenState extends State<OverviewScreen> {
  Widget _getNewsCard(Article article, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BriefNewsReader(article: article)));
      },
      child: Card(
        shadowColor: Colors.black,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    article.urlToImage,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image.asset('assets/news_splash.png');
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    article.source.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                article.title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: widget.articles.length,
      itemBuilder: (context, index) =>
          _getNewsCard(widget.articles[index], context),
    ));
  }
}
