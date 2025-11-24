import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';
import '../models/user_profile.dart';
import '../models/content.dart';

class DetailsPage extends StatelessWidget {
  final String contentId;

  const DetailsPage({super.key, required this.contentId});

  @override
  Widget build(BuildContext context) {
    final content = ContentData.getContentById(contentId);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;

    if (content == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: const Center(
          child: Text(
            'Content not found',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    final heroImage = content.imageUrl;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(),
            // Hero Image Section
            Container(
              width: double.infinity,
              height: isMobile ? 300 : (isTablet ? 400 : 500),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.black.withValues(alpha: 0.7),
                    Colors.black,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: Colors.grey[900],
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Image.asset(
                          heroImage,
                          alignment: Alignment.center,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[900],
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      content.type == 'movie'
                                          ? Icons.movie
                                          : Icons.tv,
                                      size: 100,
                                      color: Colors.grey[700],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      content.title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  // Gradient overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.5),
                            Colors.black,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content Details
            Padding(
              padding: EdgeInsets.all(isMobile ? 20 : 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              content.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isMobile ? 28 : (isTablet ? 34 : 42),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: isMobile ? 12 : 15),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 10 : 12,
                                    vertical: isMobile ? 5 : 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: isMobile ? 14 : 16,
                                      ),
                                      SizedBox(width: isMobile ? 4 : 6),
                                      Text(
                                        '${content.rating}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: isMobile ? 12 : 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '${content.year}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isMobile ? 14 : 16,
                                  ),
                                ),
                                if (content.duration != null)
                                  Text(
                                    content.duration!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isMobile ? 14 : 16,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: content.genres.map((genre) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    genre,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 20 : 30),
                  // Action Buttons
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.play_arrow, size: isMobile ? 18 : 24),
                        label: const Text('Play'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 25 : 40,
                            vertical: isMobile ? 12 : 15,
                          ),
                          textStyle: TextStyle(
                            fontSize: isMobile ? 16 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ValueListenableBuilder<UserProfile>(
                        valueListenable: UserProfileManager.activeProfile,
                        builder: (context, profile, _) {
                          final saved = UserProfileManager.isSaved(
                            profile.id,
                            content.id,
                          );
                          return OutlinedButton.icon(
                            onPressed: () {
                              UserProfileManager.toggleSaved(
                                profile.id,
                                content.id,
                              );
                              final nowSaved = UserProfileManager.isSaved(
                                profile.id,
                                content.id,
                              );
                              ScaffoldMessenger.of(
                                context,
                              ).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    nowSaved
                                        ? 'Added to My List'
                                        : 'Removed from My List',
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            icon: Icon(
                              saved ? Icons.check : Icons.add,
                              size: isMobile ? 18 : 24,
                            ),
                            label: Text(saved ? 'In My List' : 'My List'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: saved
                                  ? Colors.black
                                  : Colors.white,
                              backgroundColor: saved
                                  ? profile.accentColor
                                  : null,
                              side: BorderSide(
                                color: saved
                                    ? profile.accentColor
                                    : Colors.white,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 25 : 40,
                                vertical: isMobile ? 12 : 15,
                              ),
                              textStyle: TextStyle(
                                fontSize: isMobile ? 16 : 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 30 : 40),
                  // Description
                  Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 20 : 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: isMobile ? 12 : 15),
                  Text(
                    content.description,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: isMobile ? 14 : 16,
                      height: 1.6,
                    ),
                  ),
                  if (content.director != null) ...[
                    SizedBox(height: isMobile ? 25 : 30),
                    Text(
                      'Director',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 20 : 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: isMobile ? 8 : 10),
                    Text(
                      content.director!,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: isMobile ? 14 : 16,
                      ),
                    ),
                  ],
                  if (content.cast != null && content.cast!.isNotEmpty) ...[
                    SizedBox(height: isMobile ? 25 : 30),
                    Text(
                      'Cast',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 20 : 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: isMobile ? 8 : 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: content.cast!.map((actor) {
                        return Text(
                          actor,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 16,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
