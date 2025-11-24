import 'package:flutter/material.dart';
import '../models/content.dart';
import 'movie_card.dart';

class ContentRow extends StatelessWidget {
  final String title;
  final List<Content> contentList;
  final bool isLarge;

  const ContentRow({
    super.key,
    required this.title,
    required this.contentList,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;
    
    double rowHeight;
    if (isMobile) {
      rowHeight = isLarge ? 290 : 220;
    } else if (isTablet) {
      rowHeight = isLarge ? 395 : 290;
    } else {
      rowHeight = isLarge ? 470 : 320;
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 15 : 20,
            vertical: 10,
          ),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 18 : 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: rowHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 15 : 20,
            ),
            itemCount: contentList.length,
            itemBuilder: (context, index) {
              return MovieCard(
                content: contentList[index],
                isLarge: isLarge,
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

