import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/search_box.dart';
import 'bookmark_screen.dart';
import 'overview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.userName}) : super(key: key);
  final String userName;
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late NewsAPIService client;
  String keyword = '';
  int pageIndex = 0;

  @override
  void initState() {
    client = NewsAPIService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${widget.userName} !!!'),
        automaticallyImplyLeading: false,
        actions: [
          if (pageIndex == 0)
            IconButton(
              onPressed: () async {
                keyword = await showSearch<String>(
                        context: context, delegate: CustomDelegate()) ??
                    '';
                setState(() {});
              },
              icon: const Icon(Icons.search),
              splashRadius: 20,
            )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.newspaper), label: 'Overview'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_added), label: 'Bookmarked')
        ],
        onTap: (int index) {
          setState(() {
            pageIndex = index;
          });
        },
      ),
      body: FutureBuilder(
        future: client.getArticle(keyword),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (pageIndex == 0) {
              return OverviewScreen(articles: snapshot.data!);
            } else {
              return const BookmarkedScreen();
            }
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
