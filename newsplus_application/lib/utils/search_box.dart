import 'package:flutter/material.dart';

class CustomDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) =>
      [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      icon: const Icon(Icons.chevron_left),
      onPressed: () => close(context, ''));

  @override
  Widget buildResults(BuildContext context) {
    //close(context, query);
    return Align(
      alignment: Alignment.topCenter,
      child: TextButton.icon(
          icon: const Icon(Icons.search),
          label: const Text('Search'),
          onPressed: () => close(context, query)),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}
