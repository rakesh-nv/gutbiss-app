class UserProfile {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? profilePicture;
  final List<String> favoriteRestaurants;
  final bool notificationsEnabled;
  final String preferredLanguage;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.profilePicture,
    this.favoriteRestaurants = const [],
    this.notificationsEnabled = true,
    this.preferredLanguage = 'English',
  });
} 