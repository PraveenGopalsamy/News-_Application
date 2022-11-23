import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/api_service.dart';
import '../utils/read_write.dart';

class BriefNewsReader extends StatefulWidget {
  const BriefNewsReader({Key? key, required this.article}) : super(key: key);
  final Article article;
  @override
  BriefNewsReaderState createState() => BriefNewsReaderState();
}

class BriefNewsReaderState extends State<BriefNewsReader> {
  late Article article;
  late List<Article> bookmarks;

  @override
  void initState() {
    article = widget.article;
    super.initState();
  }

  @override
  void dispose() {
    bookmarks.clear();
    super.dispose();
  }

  Future<bool> getBookmarks() async {
    bookmarks = await FileUtils.readFromFile();
    if (!article.isBookmarked) {
      for (Article element in bookmarks) {
        if (element.url == article.url) {
          article.isBookmarked = true;
          setState(() {});
        }
      }
    }
    return true;
  }

  Future<void> updateBookmarks(List<Article> data) async {
    await FileUtils.saveToFile(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                article.isBookmarked = !article.isBookmarked;
                if (article.isBookmarked) {
                  bookmarks.add(article);
                } else {
                  bookmarks.removeWhere(
                      (Article element) => element.url == article.url);
                }
                updateBookmarks(bookmarks);
                setState(() {});
              },
              icon: Icon(article.isBookmarked
                  ? Icons.bookmark_added
                  : Icons.bookmark_add_outlined),
              splashRadius: 20,
            ),
            IconButton(
              onPressed: () async {
                await launchUrl(Uri.parse(article.url),
                    mode: LaunchMode.externalApplication);
              },
              icon: const Icon(Icons.language),
              splashRadius: 20,
            ),
          ],
        ),
        body: FutureBuilder(
            future: getBookmarks(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      const SizedBox(height: 8.0),
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                            article.urlToImage,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Image.asset('assets/news_splash.png');
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(article.description ?? ''),
                      Center(
                        child: TextButton(
                            onPressed: (() async {
                              await launchUrl(Uri.parse(article.url),
                                  mode: LaunchMode.externalApplication);
                            }),
                            child: const Text('Read More...')),
                      )
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
