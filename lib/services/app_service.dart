import 'package:mrudu0510_flutter_syncup/models/user_model.dart';
import 'package:mrudu0510_flutter_syncup/models/match_model.dart';

/// Core service class for SyncUp app business logic
class AppService {
  /// Validate email format
  static bool validateEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Validate password strength
  static bool validatePassword(String password) {
    return password.length >= 6;
  }

  /// Calculate compatibility score between two users
  static double calculateCompatibility(UserModel user1, UserModel user2) {
    double score = 0;

    // Goal matching (40% weight)
    int commonGoals = user1.goals
        .where((goal) => user2.goals.contains(goal))
        .length;
    double goalScore = (commonGoals / user1.goals.length) * 40;
    score += goalScore;

    // Commitment level matching (30% weight)
    if (user1.commitment == user2.commitment) {
      score += 30;
    } else {
      score += 15;
    }

    // Age compatibility (20% weight)
    int ageDifference = (user1.age - user2.age).abs();
    double ageScore = (1 - (ageDifference / 50).clamp(0, 1)) * 20;
    score += ageScore;

    // Interest matching (10% weight)
    List<String> interests1 = user1.interests.split(', ');
    List<String> interests2 = user2.interests.split(', ');
    int commonInterests = interests1
        .where((interest) => interests2.contains(interest))
        .length;
    double interestScore = (commonInterests / interests1.length) * 10;
    score += interestScore;

    return double.parse(score.toStringAsFixed(1));
  }

  /// Get recommended matches for a user
  static List<MatchModel> getRecommendedMatches(
    UserModel currentUser,
    List<UserModel> allUsers,
  ) {
    List<MatchModel> matches = [];

    for (int i = 0; i < allUsers.length; i++) {
      if (allUsers[i].id != currentUser.id) {
        double score = calculateCompatibility(currentUser, allUsers[i]);
        
        MatchModel match = MatchModel(
          id: 'match_${currentUser.id}_${allUsers[i].id}',
          userId1: currentUser.id,
          userId2: allUsers[i].id,
          compatibilityScore: score,
          matchedDate: DateTime.now(),
          isActive: score > 60,
          status: 'pending',
        );
        
        matches.add(match);
      }
    }

    // Sort by compatibility score (highest first)
    matches.sort((a, b) => b.compatibilityScore.compareTo(a.compatibilityScore));

    return matches;
  }

  /// Accept a match
  static MatchModel acceptMatch(MatchModel match) {
    return match.copyWith(status: 'accepted', isActive: true);
  }

  /// Reject a match
  static MatchModel rejectMatch(MatchModel match) {
    return match.copyWith(status: 'rejected', isActive: false);
  }

  /// Send a message (placeholder)
  static bool sendMessage(String fromUserId, String toUserId, String message) {
    if (message.isEmpty) return false;
    // TODO: Implement actual messaging logic with backend
    return true;
  }

  /// Get match details
  static String getMatchDetails(MatchModel match, UserModel user1, UserModel user2) {
    return '''
    Match between ${user1.name} and ${user2.name}
    Compatibility Score: ${match.compatibilityScore}%
    Status: ${match.status}
    Matched on: ${match.matchedDate}
    ''';
  }

  /// Update user profile
  static UserModel updateUserProfile(
    UserModel user, {
    String? name,
    String? bio,
    int? age,
    List<String>? goals,
    String? commitment,
    String? interests,
  }) {
    return user.copyWith(
      name: name,
      bio: bio,
      age: age,
      goals: goals,
      commitment: commitment,
      interests: interests,
    );
  }

  /// Validate onboarding responses (7 questions)
  static bool validateOnboardingData({
    required String name,
    required int age,
    required String bio,
    required List<String> goals,
    required String commitment,
    required String interests,
  }) {
    return name.isNotEmpty &&
        age > 0 &&
        bio.isNotEmpty &&
        goals.isNotEmpty &&
        commitment.isNotEmpty &&
        interests.isNotEmpty;
  }
}
