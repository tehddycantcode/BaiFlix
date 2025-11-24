import 'package:flutter/material.dart';

class UserProfile {
  final String id;
  final String name;
  final Color accentColor;
  final String tagline;

  const UserProfile({
    required this.id,
    required this.name,
    required this.accentColor,
    required this.tagline,
  });
}

class UserProfileManager {
  static final List<UserProfile> profiles = [
    const UserProfile(
      id: 'profile-1',
      name: 'Edward',
      accentColor: Colors.redAccent,
      tagline: 'Blockbuster Fan',
    ),
    const UserProfile(
      id: 'profile-2',
      name: 'Koshi',
      accentColor: Colors.blueAccent,
      tagline: 'Sci-fi Explorer',
    ),
    const UserProfile(
      id: 'profile-3',
      name: 'Ian',
      accentColor: Colors.purpleAccent,
      tagline: 'Thriller Hunter',
    ),
  ];

  static final ValueNotifier<UserProfile> activeProfile =
      ValueNotifier<UserProfile>(profiles.first);

  static void setActive(UserProfile profile) {
    if (profile.id == activeProfile.value.id) return;
    activeProfile.value = profile;
  }


  static final Map<String, Set<String>> _savedLists = {
    for (var p in profiles) p.id: <String>{},
  };

  static bool isSaved(String profileId, String contentId) {
    final set = _savedLists[profileId];
    return set != null && set.contains(contentId);
  }

  static void toggleSaved(String profileId, String contentId) {
    final set = _savedLists[profileId];
    if (set == null) return;
    if (set.contains(contentId)) {
      set.remove(contentId);
    } else {
      set.add(contentId);
    }
    
    if (activeProfile.value.id == profileId) {
      
      activeProfile.value = activeProfile.value;
    }
  }

  static List<String> getSavedFor(String profileId) {
    return _savedLists[profileId]?.toList() ?? [];
  }
}
