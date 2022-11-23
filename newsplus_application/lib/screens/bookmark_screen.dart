import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../utils/read_write.dart';
import 'overview_screen.dart';

class BookmarkedScreen extends StatefulWidget {
  const BookmarkedScreen({Key? key}) : super(key: key);
  @override
  BookmarkedScreenState createState() => BookmarkedScreenState();
}

class BookmarkedScreenState extends State<BookmarkedScreen> {
  Future<List<Article>> importBookmarks() async {
    return await FileUtils.readFromFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: importBookmarks(),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return OverviewScreen(articles: snapshot.data!);
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
