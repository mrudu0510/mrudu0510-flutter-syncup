import 'package:mrudu0510_flutter_syncup/models/user_model.dart';
import 'package:mrudu0510_flutter_syncup/models/match_model.dart';

/// Dummy data for testing and development
class DummyData {
  /// Sample users for the app
  static final List<UserModel> sampleUsers = [
    UserModel(
      id: 'user_001',
      name: 'Alice Johnson',
      email: 'alice@example.com',
      age: 28,
      bio: 'Fitness enthusiast and self-improvement coach',
      profileImageUrl: 'https://via.placeholder.com/300?text=Alice',
      goals: ['Get fit', 'Learn coding', 'Read more books'],
      commitment: 'High',
      interests: 'fitness, technology, reading, travel',
    ),
    UserModel(
      id: 'user_002',
      name: 'Bob Smith',
      email: 'bob@example.com',
      age: 30,
      bio: 'Software developer and entrepreneur',
      profileImageUrl: 'https://via.placeholder.com/300?text=Bob',
      goals: ['Learn coding', 'Build a startup', 'Stay healthy'],
      commitment: 'High',
      interests: 'technology, business, fitness, music',
    ),
    UserModel(
      id: 'user_003',
      name: 'Carol White',
      email: 'carol@example.com',
      age: 26,
      bio: 'Marketing professional with a passion for wellness',
      profileImageUrl: 'https://via.placeholder.com/300?text=Carol',
      goals: ['Get fit', 'Learn new skills', 'Build network'],
      commitment: 'Medium',
      interests: 'marketing, fitness, networking, food',
    ),
    UserModel(
      id: 'user_004',
      name: 'David Brown',
      email: 'david@example.com',
      age: 32,
      bio: 'Designer and creative thinker',
      profileImageUrl: 'https://via.placeholder.com/300?text=David',
      goals: ['Improve design skills', 'Travel the world', 'Stay fit'],
      commitment: 'Medium',
      interests: 'design, art, travel, photography',
    ),
    UserModel(
      id: 'user_005',
      name: 'Emma Davis',
      email: 'emma@example.com',
      age: 25,
      bio: 'Student pursuing digital marketing',
      profileImageUrl: 'https://via.placeholder.com/300?text=Emma',
      goals: ['Get fit', 'Career growth', 'Learn programming'],
      commitment: 'High',
      interests: 'marketing, fitness, learning, social media',
    ),
  ];

  /// Sample matches between users
  static final List<MatchModel> sampleMatches = [
    MatchModel(
      id: 'match_001',
      userId1: 'user_001',
      userId2: 'user_002',
      compatibilityScore: 85.5,
      matchedDate: DateTime.now().subtract(const Duration(days: 5)),
      isActive: true,
      status: 'matched',
    ),
    MatchModel(
      id: 'match_002',
      userId1: 'user_001',
      userId2: 'user_005',
      compatibilityScore: 78.3,
      matchedDate: DateTime.now().subtract(const Duration(days: 3)),
      isActive: true,
      status: 'pending',
    ),
    MatchModel(
      id: 'match_003',
      userId1: 'user_002',
      userId2: 'user_003',
      compatibilityScore: 72.1,
      matchedDate: DateTime.now().subtract(const Duration(days: 1)),
      isActive: true,
      status: 'accepted',
    ),
  ];

  /// Get sample user by ID
  static UserModel? getUserById(String id) {
    try {
      return sampleUsers.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get sample match by ID
  static MatchModel? getMatchById(String id) {
    try {
      return sampleMatches.firstWhere((match) => match.id == id);
    } catch (e) {
      return null;
    }
  }
}
