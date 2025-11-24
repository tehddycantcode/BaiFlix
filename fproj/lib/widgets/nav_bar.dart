import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/user_profile.dart';
import '../models/content.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouter.of(
      context,
    ).routeInformationProvider.value.uri.path;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      height: isMobile ? 60 : 70,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 15 : 20),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.8),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          // Logo
          GestureDetector(
            onTap: () => context.go('/'),
            child: Text(
              'BAIFLIX',
              style: TextStyle(
                color: Colors.red,
                fontSize: isMobile ? 20 : 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          SizedBox(width: isMobile ? 15 : 40),
          // Navigation Links
          if (!isMobile)
            Expanded(
              child: Row(
                children: [
                  _NavItem(label: 'Home', path: '/', currentPath: currentPath),
                  const SizedBox(width: 30),
                  _NavItem(
                    label: 'Browse',
                    path: '/browse',
                    currentPath: currentPath,
                  ),
                ],
              ),
            )
          else
            const Spacer(),
          if (!isMobile) ...[
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () async {
                final router = GoRouter.of(context);
                final Content? result = await showSearch<Content?>(
                  context: context,
                  delegate: ContentSearchDelegate(),
                );
                if (result != null) {
                  router.push('/details/${result.id}');
                }
              },
            ),
            const SizedBox(width: 10),
          ],
          ValueListenableBuilder<UserProfile>(
            valueListenable: UserProfileManager.activeProfile,
            builder: (context, profile, _) {
              return _ProfileMenu(profile: profile, isMobile: isMobile);
            },
          ),
        ],
      ),
    );
  }
}

class ContentSearchDelegate extends SearchDelegate<Content?> {
  ContentSearchDelegate() : super(searchFieldLabel: 'Search movies & shows');

  List<Content> _allContent() {
    return [
      ...ContentData.trending,
      ...ContentData.popular,
      ...ContentData.topRated,
      ...ContentData.action,
      ...ContentData.comedy,
    ];
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear, color: Colors.white),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = _allContent()
        .where((c) => c.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return Center(
        child: Text(
          'No results found',
          style: TextStyle(color: Colors.grey[400]),
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          leading: SizedBox(
            width: 48,
            height: 68,
            child: Image.asset(item.imageUrl, fit: BoxFit.cover),
          ),
          title: Text(item.title),
          subtitle: Text('${item.year} • ${item.genres.join(', ')}'),
          onTap: () => close(context, item),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? _allContent().take(6).toList()
        : _allContent()
              .where((c) => c.title.toLowerCase().contains(query.toLowerCase()))
              .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final item = suggestions[index];
        return ListTile(
          leading: SizedBox(
            width: 48,
            height: 68,
            child: Image.asset(item.imageUrl, fit: BoxFit.cover),
          ),
          title: Text(item.title),
          onTap: () => query = item.title,
        );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final String path;
  final String currentPath;

  const _NavItem({
    required this.label,
    required this.path,
    required this.currentPath,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = currentPath == path;
    return GestureDetector(
      onTap: () => context.go(path),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.grey,
          fontSize: 16,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

class _ProfileMenu extends StatelessWidget {
  final UserProfile profile;
  final bool isMobile;

  const _ProfileMenu({required this.profile, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final double avatarSize = isMobile ? 34 : 40;
    return PopupMenuButton<Object>(
      tooltip: 'Switch profile',
      onSelected: (value) {
        if (value is UserProfile) {
          UserProfileManager.setActive(value);
        } else if (value == 'manage') {
          _showManageProfilesDialog(context);
        }
      },
      offset: const Offset(0, 40),
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder: (context) {
        final List<PopupMenuEntry<Object>> items = [];
        items.addAll(
          UserProfileManager.profiles.map((user) {
            final isActive = user.id == profile.id;
            return PopupMenuItem<Object>(
              value: user,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: user.accentColor,
                    child: Text(
                      user.name.characters.first,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          user.tagline,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isActive)
                    const Icon(Icons.check, color: Colors.white, size: 18),
                ],
              ),
            );
          }),
        );
        items.add(const PopupMenuDivider());
        items.add(
          PopupMenuItem<Object>(
            value: 'manage',
            child: Row(
              children: [
                const Icon(Icons.manage_accounts, color: Colors.white),
                const SizedBox(width: 10),
                Text('Manage profiles', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        );
        return items;
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 8 : 12,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(avatarSize / 4),
          border: Border.all(color: profile.accentColor.withValues(alpha: 0.6)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: avatarSize / 2,
              backgroundColor: profile.accentColor,
              child: Text(
                profile.name.characters.first,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            if (!isMobile) ...[
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    profile.tagline,
                    style: TextStyle(color: Colors.grey[400], fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(width: 6),
              const Icon(Icons.keyboard_arrow_down, color: Colors.white),
            ],
          ],
        ),
      ),
    );
  }

  void _showManageProfilesDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Manage Profiles',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Profile management features are coming soon.',
                style: TextStyle(color: Colors.grey[400]),
              ),
              const SizedBox(height: 12),
              Text(
                'You can switch profiles from this menu.',
                style: TextStyle(color: Colors.grey[500], fontSize: 13),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
