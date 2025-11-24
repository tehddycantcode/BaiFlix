import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/content.dart';
import '../models/user_profile.dart';
import '../widgets/content_row.dart';
import '../widgets/nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(),
            // Hero Section
            _HeroSection(),
            const SizedBox(height: 20),
            // Content Rows
            ContentRow(
              title: 'Trending Now',
              contentList: ContentData.trending,
              isLarge: true,
            ),
            ContentRow(
              title: 'Popular on BaiFlix',
              contentList: ContentData.popular,
            ),
            ContentRow(title: 'Top Rated', contentList: ContentData.topRated),
            ContentRow(
              title: 'Action & Adventure',
              contentList: ContentData.action,
            ),
            ContentRow(title: 'Comedy', contentList: ContentData.comedy),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  void _handlePlay(BuildContext context, Content content) {
    final profile = UserProfileManager.activeProfile.value;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${profile.name} is now watching ${content.title}'),
        duration: const Duration(seconds: 2),
      ),
    );
    context.push('/details/${content.id}');
  }

  void _handleDetails(BuildContext context, Content content) {
    context.push('/details/${content.id}');
  }

  @override
  Widget build(BuildContext context) {
    final featuredContent = ContentData.trending[0];
    final heroImage = featuredContent.heroImageUrl ?? featuredContent.imageUrl;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;
    final imageFit = heroImage.contains('dark_knight1.jpg')
        ? BoxFit.contain
        : (screenWidth >= 1200 ? BoxFit.fitWidth : BoxFit.cover);
    final imageAlignment = Alignment.center;

    return Container(
      width: double.infinity,
      height: isMobile ? 400 : (isTablet ? 500 : 600),
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
            child: Image.asset(
              heroImage,
              fit: imageFit,
              width: double.infinity,
              height: double.infinity,
              alignment: imageAlignment,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[900],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.movie, size: 100, color: Colors.grey[700]),
                        const SizedBox(height: 20),
                        Text(
                          'Featured Content',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
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
                    Colors.black.withValues(alpha: 0.3),
                    Colors.black,
                  ],
                ),
              ),
            ),
          ),
          // Content
          Positioned(
            bottom: isMobile ? 40 : 100,
            left: isMobile ? 20 : 50,
            right: isMobile ? 20 : 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  featuredContent.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 28 : (isTablet ? 36 : 48),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: isMobile ? 15 : 20),
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
                            '${featuredContent.rating}',
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
                      '${featuredContent.year}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 14 : 16,
                      ),
                    ),
                    if (!isMobile)
                      Text(
                        featuredContent.genres.join(' • '),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: isMobile ? 15 : 20),
                SizedBox(
                  width: isMobile ? double.infinity : 400,
                  child: Text(
                    featuredContent.description,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: isMobile ? 14 : 16,
                      height: 1.5,
                    ),
                    maxLines: isMobile ? 2 : 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (featuredContent.background != null) ...[
                  SizedBox(height: isMobile ? 12 : 16),
                  Container(
                    width: isMobile ? double.infinity : 500,
                    padding: EdgeInsets.all(isMobile ? 12 : 16),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Background',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isMobile ? 14 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          featuredContent.background!,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: isMobile ? 13 : 15,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: isMobile ? 20 : 30),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _HeroActionButton(
                      label: 'Play',
                      icon: Icons.play_arrow_rounded,
                      isPrimary: true,
                      isMobile: isMobile,
                      onTap: () => _handlePlay(context, featuredContent),
                    ),
                    _HeroActionButton(
                      label: 'Details',
                      icon: Icons.info_outline_rounded,
                      isPrimary: false,
                      isMobile: isMobile,
                      onTap: () => _handleDetails(context, featuredContent),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final bool isMobile;
  final VoidCallback onTap;

  const _HeroActionButton({
    required this.label,
    required this.icon,
    required this.isPrimary,
    required this.isMobile,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = isPrimary
        ? ElevatedButton.styleFrom(
            elevation: 6,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 22 : 36,
              vertical: isMobile ? 12 : 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          )
        : OutlinedButton.styleFrom(
            side: BorderSide(
              color: Colors.white.withValues(alpha: 0.7),
              width: 1.5,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 22 : 36,
              vertical: isMobile ? 12 : 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          );

    final Widget labelWidget = Text(
      label,
      style: TextStyle(
        fontSize: isMobile ? 16 : 18,
        fontWeight: FontWeight.bold,
      ),
    );

    final Icon iconWidget = Icon(icon, size: isMobile ? 18 : 22);

    final Widget child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [iconWidget, const SizedBox(width: 8), labelWidget],
    );

    return isPrimary
        ? ElevatedButton(onPressed: onTap, style: style, child: child)
        : OutlinedButton(onPressed: onTap, style: style, child: child);
  }
}
