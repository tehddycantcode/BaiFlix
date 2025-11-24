import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/content.dart';

class MovieCard extends StatelessWidget {
  final Content content;
  final bool isLarge;

  const MovieCard({
    super.key,
    required this.content,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;
    
    double cardWidth;
    double cardHeight;
    double maxCardHeight; // Maximum height for the entire card including text
    
    if (isMobile) {
      cardWidth = isLarge ? 180.0 : 140.0;
      cardHeight = isLarge ? 242.0 : 200.0; // Reduced further to eliminate 1px overflow
      maxCardHeight = isLarge ? 290.0 : 220.0;
    } else if (isTablet) {
      cardWidth = isLarge ? 250.0 : 180.0;
      cardHeight = isLarge ? 350.0 : 270.0;
      maxCardHeight = isLarge ? 395.0 : 290.0;
    } else {
      cardWidth = isLarge ? 300.0 : 200.0;
      cardHeight = isLarge ? 420.0 : 300.0;
      maxCardHeight = isLarge ? 470.0 : 320.0;
    }

    return GestureDetector(
      onTap: () => context.push('/details/${content.id}'),
      child: SizedBox(
        height: maxCardHeight,
        child: Container(
          width: cardWidth,
          margin: const EdgeInsets.only(right: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: cardWidth,
                height: cardHeight,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        content.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _PosterFallback(content: content);
                        },
                      ),
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withValues(alpha: 0.0),
                              Colors.black.withValues(alpha: 0.4),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    // Rating badge
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              content.rating.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isLarge) ...[
              SizedBox(height: isMobile ? 5 : 8),
              Text(
                content.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: isMobile ? 2 : 3),
              Text(
                '${content.year} • ${content.genres.join(", ")}',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: isMobile ? 11 : 12,
                  height: 1.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
        ),
      ),
    );
  }
}

class _PosterFallback extends StatelessWidget {
  final Content content;

  const _PosterFallback({required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              content.type == 'movie' ? Icons.movie : Icons.tv,
              size: 50,
              color: Colors.grey[600],
            ),
            const SizedBox(height: 10),
            Text(
              content.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

