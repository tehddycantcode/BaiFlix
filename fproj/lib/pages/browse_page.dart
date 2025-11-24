import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';
import '../widgets/movie_card.dart';
import '../models/content.dart';

class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(),
            const SizedBox(height: 40),
            // Page Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Browse',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Categories
            _CategorySection(
              title: 'Trending',
              contentList: ContentData.trending,
            ),
            _CategorySection(
              title: 'Popular',
              contentList: ContentData.popular,
            ),
            _CategorySection(
              title: 'Top Rated',
              contentList: ContentData.topRated,
            ),
            _CategorySection(
              title: 'Action & Adventure',
              contentList: ContentData.action,
            ),
            _CategorySection(
              title: 'Comedy',
              contentList: ContentData.comedy,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  final String title;
  final List<Content> contentList;

  const _CategorySection({
    required this.title,
    required this.contentList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 320,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: contentList.length,
            itemBuilder: (context, index) {
              return MovieCard(
                content: contentList[index],
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

