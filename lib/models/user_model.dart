class UserProfile {
  final String uid;
  final String name;
  final String email;
  final String goal;
  final String currentLevel;
  final String lookingFor;
  final String frequency;
  final String preferredTime;
  final String workingStyle;
  final String deadline;
  final String collaborationType;
  final String avatarInitials;

  const UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.goal,
    required this.currentLevel,
    required this.lookingFor,
    required this.frequency,
    required this.preferredTime,
    required this.workingStyle,
    required this.deadline,
    required this.collaborationType,
    this.avatarInitials = '',
  });

  UserProfile copyWith({
    String? uid,
    String? name,
    String? email,
    String? goal,
    String? currentLevel,
    String? lookingFor,
    String? frequency,
    String? preferredTime,
    String? workingStyle,
    String? deadline,
    String? collaborationType,
    String? avatarInitials,
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      goal: goal ?? this.goal,
      currentLevel: currentLevel ?? this.currentLevel,
      lookingFor: lookingFor ?? this.lookingFor,
      frequency: frequency ?? this.frequency,
      preferredTime: preferredTime ?? this.preferredTime,
      workingStyle: workingStyle ?? this.workingStyle,
      deadline: deadline ?? this.deadline,
      collaborationType: collaborationType ?? this.collaborationType,
      avatarInitials: avatarInitials ?? this.avatarInitials,
    );
  }
}

class ChatMessage {
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isUser;

  const ChatMessage({
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isUser,
  });
}

/// Simple in-memory app state shared across screens.
class AppState {
  static AppState? _instance;
  static AppState get instance => _instance ??= AppState._();
  AppState._();

  UserProfile? currentUser;
  final List<UserProfile> matches = [];
  final Map<String, List<ChatMessage>> conversations = {};

  // Mock profiles shown on swipe screen
  final List<UserProfile> mockProfiles = [
    const UserProfile(
      uid: 'u1',
      name: 'Alex Johnson',
      email: 'alex@example.com',
      goal: 'Learn video editing',
      currentLevel: 'Beginner',
      lookingFor: 'Learn together',
      frequency: 'Daily',
      preferredTime: 'Morning',
      workingStyle: 'Structured & disciplined',
      deadline: '3 months',
      collaborationType: 'Regular check-ins',
      avatarInitials: 'AJ',
    ),
    const UserProfile(
      uid: 'u2',
      name: 'Priya Sharma',
      email: 'priya@example.com',
      goal: 'Run 5km daily',
      currentLevel: 'Intermediate',
      lookingFor: 'Someone at same level',
      frequency: '3–4 times/week',
      preferredTime: 'Morning',
      workingStyle: 'Competitive',
      deadline: '1 month',
      collaborationType: 'Regular check-ins',
      avatarInitials: 'PS',
    ),
    const UserProfile(
      uid: 'u3',
      name: 'Marcus Lee',
      email: 'marcus@example.com',
      goal: 'Write better content',
      currentLevel: 'Beginner',
      lookingFor: 'Someone more experienced',
      frequency: 'Daily',
      preferredTime: 'Night',
      workingStyle: 'Chill & flexible',
      deadline: 'No deadline',
      collaborationType: 'Chat only',
      avatarInitials: 'ML',
    ),
    const UserProfile(
      uid: 'u4',
      name: 'Sofia Ortega',
      email: 'sofia@example.com',
      goal: 'Improve public speaking',
      currentLevel: 'Intermediate',
      lookingFor: 'Learn together',
      frequency: 'Weekends',
      preferredTime: 'Afternoon',
      workingStyle: 'Structured & disciplined',
      deadline: '3 months',
      collaborationType: 'Voice/video sessions',
      avatarInitials: 'SO',
    ),
    const UserProfile(
      uid: 'u5',
      name: 'David Kim',
      email: 'david@example.com',
      goal: 'Build a side project',
      currentLevel: 'Advanced',
      lookingFor: 'Someone at same level',
      frequency: 'Daily',
      preferredTime: 'Night',
      workingStyle: 'Competitive',
      deadline: '1 month',
      collaborationType: 'Regular check-ins',
      avatarInitials: 'DK',
    ),
  ];

  void reset() {
    currentUser = null;
    matches.clear();
    conversations.clear();
  }
}
