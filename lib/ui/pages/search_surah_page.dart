import 'package:alquran/ui/widgets/app_search_bar.dart';
import 'package:flutter/material.dart';

class SearchSurahPage extends StatelessWidget {
  const SearchSurahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppSearchBar(),
        titleSpacing: 0,
        backgroundColor: Colors.white,
      ),
    );
  }
}
