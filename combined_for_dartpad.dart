import 'dart:math';
import 'package:flutter/material.dart';


// --- dummy_data.dart ---


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


// --- main.dart ---


void main() {
  runApp(const SyncUpApp());
}

class SyncUpApp extends StatelessWidget {
  const SyncUpApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SyncUp - Accountability Partners',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}


// --- profile_screen.dart ---


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(24),
              color: AppTheme.surfaceColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.account_circle,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'John Doe',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'john@example.com',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.verified,
                                  size: 16,
                                  color: AppTheme.successColor,
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  'Verified',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.successColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Profile Stats
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard('5', 'Matches'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard('12', 'Chats'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard('89%', 'Avg Score'),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Profile Info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Profile Info',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoTile('Goal', 'Video Editing'),
                  _buildInfoTile('Level', 'Intermediate'),
                  _buildInfoTile('Availability', 'Evening'),
                  _buildInfoTile('Frequency', 'Daily'),
                  _buildInfoTile('Style', 'Structured & Disciplined'),
                  _buildInfoTile('Collaboration', 'Voice/Video calls'),
                ],
              ),
            ),

            const Divider(height: 1),

            // Settings
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSettingsTile(
                    'Edit Profile',
                    'Update your information',
                    Icons.edit,
                    () {},
                  ),
                  _buildSettingsTile(
                    'Privacy Settings',
                    'Control your visibility',
                    Icons.privacy_tip,
                    () {},
                  ),
                  _buildSettingsTile(
                    'Notifications',
                    'Manage alerts',
                    Icons.notifications,
                    () {},
                  ),
                  _buildSettingsTile(
                    'Help & Support',
                    'Get assistance',
                    Icons.help,
                    () {},
                  ),
                  _buildSettingsTile(
                    'Sign Out',
                    'Log out of your account',
                    Icons.logout,
                    () {
                      Get.offNamed('/login');
                    },
                    isDangerous: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDangerous = false,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: isDangerous ? AppTheme.errorColor : AppTheme.primaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isDangerous ? AppTheme.errorColor : AppTheme.textPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 12,
          color: AppTheme.textSecondary,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}


// --- match_model.dart ---

/// Match model for SyncUp app
class MatchModel {
  final String id;
  final String userId1;
  final String userId2;
  final double compatibilityScore;
  final DateTime matchedDate;
  final bool isActive;
  final String status; // pending, accepted, rejected

  MatchModel({
    required this.id,
    required this.userId1,
    required this.userId2,
    required this.compatibilityScore,
    required this.matchedDate,
    required this.isActive,
    required this.status,
  });

  /// Convert MatchModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId1': userId1,
      'userId2': userId2,
      'compatibilityScore': compatibilityScore,
      'matchedDate': matchedDate.toIso8601String(),
      'isActive': isActive,
      'status': status,
    };
  }

  /// Create MatchModel from JSON
  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'] ?? '',
      userId1: json['userId1'] ?? '',
      userId2: json['userId2'] ?? '',
      compatibilityScore: (json['compatibilityScore'] ?? 0).toDouble(),
      matchedDate: DateTime.parse(json['matchedDate'] ?? DateTime.now().toIso8601String()),
      isActive: json['isActive'] ?? false,
      status: json['status'] ?? 'pending',
    );
  }

  /// Create a copy of MatchModel with optional new values
  MatchModel copyWith({
    String? id,
    String? userId1,
    String? userId2,
    double? compatibilityScore,
    DateTime? matchedDate,
    bool? isActive,
    String? status,
  }) {
    return MatchModel(
      id: id ?? this.id,
      userId1: userId1 ?? this.userId1,
      userId2: userId2 ?? this.userId2,
      compatibilityScore: compatibilityScore ?? this.compatibilityScore,
      matchedDate: matchedDate ?? this.matchedDate,
      isActive: isActive ?? this.isActive,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'MatchModel(id: $id, userId1: $userId1, userId2: $userId2, compatibilityScore: $compatibilityScore, status: $status)';
  }
}


// --- user_model.dart ---

/// User model for SyncUp app
class UserModel {
  final String id;
  final String name;
  final String email;
  final int age;
  final String bio;
  final String profileImageUrl;
  final List<String> goals;
  final String commitment; // Low, Medium, High
  final String interests; // comma-separated string

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.bio,
    required this.profileImageUrl,
    required this.goals,
    required this.commitment,
    required this.interests,
  });

  /// Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'age': age,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'goals': goals,
      'commitment': commitment,
      'interests': interests,
    };
  }

  /// Create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      age: json['age'] ?? 0,
      bio: json['bio'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
      goals: List<String>.from(json['goals'] ?? []),
      commitment: json['commitment'] ?? 'Medium',
      interests: json['interests'] ?? '',
    );
  }

  /// Create a copy of UserModel with optional new values
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    int? age,
    String? bio,
    String? profileImageUrl,
    List<String>? goals,
    String? commitment,
    String? interests,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      age: age ?? this.age,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      goals: goals ?? this.goals,
      commitment: commitment ?? this.commitment,
      interests: interests ?? this.interests,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, age: $age, commitment: $commitment)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email;

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}


// --- chat_screen.dart ---


class ChatScreen extends StatefulWidget {
  final String partnerName;
  final Map<String, String> userProfile;

  const ChatScreen({
    Key? key,
    required this.partnerName,
    required this.userProfile,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> messages = [
    {'sender': 'partner', 'text': 'Hey! Let\'s start our journey together 🚀'},
    {
      'sender': 'partner',
      'text': 'I\'m excited to work on this goal with you!'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.partnerName),
        centerTitle: true,
        backgroundColor: Colors.blue.shade400,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade50, Colors.purple.shade50],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isPartner = message['sender'] == 'partner';

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Align(
                      alignment: isPartner
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: isPartner
                              ? Colors.blue.shade400
                              : Colors.purple.shade400,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          message['text']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      if (_messageController.text.isNotEmpty) {
                        setState(() {
                          messages.add({
                            'sender': 'user',
                            'text': _messageController.text,
                          });
                          _messageController.clear();
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade400,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(12),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}


// --- login_screen.dart ---


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isSignUp = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade400, Colors.purple.shade400],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.people,
                    size: 50,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 24),

                // Title
                const Text(
                  'SyncUp',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Find Your Accountability Partner',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 40),

                // Email Field
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Password Field
                TextField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Sign In / Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        if (isSignUp) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const OnboardingScreen(),
                            ),
                          );
                        } else {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const SwipeScreen(),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all fields'),
                          ),
                        );
                      }
                    },
                    child: Text(
                      isSignUp ? 'Sign Up' : 'Sign In',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Toggle Sign Up / Sign In
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isSignUp
                          ? 'Already have an account? '
                          : 'Don\'t have an account? ',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSignUp = !isSignUp;
                        });
                      },
                      child: Text(
                        isSignUp ? 'Sign In' : 'Sign Up',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}


// --- matches_screen.dart ---


class MatchesScreen extends StatelessWidget {
  final List<Map<String, String>> matches;

  const MatchesScreen({Key? key, required this.matches}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        title: Text('My Matches (${matches.length})'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade50, Colors.purple.shade50],
          ),
        ),
        child: matches.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 80,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'No matches yet',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Swipe right to find your accountability partner',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  final match = matches[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              partnerName: match['name']!,
                              userProfile: match,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blue.shade300,
                                Colors.purple.shade300,
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.3),
                                  image: match.containsKey('image')
                                      ? DecorationImage(
                                          image: NetworkImage(match['image']!),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: match.containsKey('image')
                                    ? null
                                    : const Icon(
                                        Icons.person,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      match['name']!,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      match['goal']!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        match['compatibility']!,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}


// --- onboarding_screen.dart ---


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentQuestion = 0;
  Map<String, String> userProfile = {};

  final List<Map<String, dynamic>> questions = [
    {
      'title': 'What\'s your name?',
      'type': 'text',
      'key': 'name',
      'icon': Icons.person,
    },
    {
      'title': 'What goal are you working on?',
      'type': 'select',
      'key': 'goal',
      'icon': Icons.target,
      'options': [
        'Video Editing',
        'Content Writing',
        'Story Telling',
        'Running',
        'Exercising',
        'Academic Study',
        'Coding',
        'Other',
      ],
    },
    {
      'title': 'What\'s your current level?',
      'type': 'select',
      'key': 'level',
      'icon': Icons.trending_up,
      'options': ['Beginner', 'Intermediate', 'Advanced'],
    },
    {
      'title': 'Preferred time to work?',
      'type': 'select',
      'key': 'availability',
      'icon': Icons.schedule,
      'options': ['Morning', 'Afternoon', 'Evening', 'Night'],
    },
    {
      'title': 'How often will you work on this?',
      'type': 'select',
      'key': 'frequency',
      'icon': Icons.repeat,
      'options': ['Daily', '3-4 times/week', 'Weekends'],
    },
    {
      'title': 'What\'s your working style?',
      'type': 'select',
      'key': 'style',
      'icon': Icons.style,
      'options': ['Chill & Flexible', 'Structured & Disciplined', 'Competitive'],
    },
    {
      'title': 'How do you want to collaborate?',
      'type': 'select',
      'key': 'collaboration',
      'icon': Icons.handshake,
      'options': ['Chat only', 'Voice/Video sessions', 'Regular check-ins'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        title: Text('Question ${currentQuestion + 1}/${questions.length}'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade50, Colors.purple.shade50],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: (currentQuestion + 1) / questions.length,
                  minHeight: 8,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.blue.shade400,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Question Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade400,
                ),
                child: Icon(
                  question['icon'] as IconData,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),

              // Question Title
              Text(
                question['title'] as String,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),

              // Answer Options
              if (question['type'] == 'text')
                TextField(
                  onChanged: (value) {
                    userProfile[question['key']] = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your answer',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: (question['options'] as List).length,
                    itemBuilder: (context, index) {
                      final option = question['options'][index];
                      final isSelected =
                          userProfile[question['key']] == option;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              userProfile[question['key']] = option;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.blue.shade400
                                  : Colors.white,
                              border: Border.all(
                                color: isSelected
                                    ? Colors.blue.shade400
                                    : Colors.grey.shade300,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              option,
                              style: TextStyle(
                                fontSize: 16,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

              const SizedBox(height: 24),

              // Navigation Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentQuestion > 0)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade400,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          currentQuestion--;
                        });
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade400,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () {
                      if (userProfile[question['key']] == null ||
                          userProfile[question['key']]!.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please answer this question'),
                          ),
                        );
                        return;
                      }

                      if (currentQuestion < questions.length - 1) {
                        setState(() {
                          currentQuestion++;
                        });
                      } else {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => SwipeScreen(
                              userProfile: userProfile,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      currentQuestion == questions.length - 1
                          ? 'Finish'
                          : 'Next',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// --- profile_screen.dart ---


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade50, Colors.purple.shade50],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.purple.shade400],
                ),
              ),
              child: const Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Your Profile',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Goal',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        'Video Editing',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Level',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        'Intermediate',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Availability',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        'Morning',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// --- swipe_screen.dart ---


class SwipeScreen extends StatefulWidget {
  final Map<String, String> userProfile;

  const SwipeScreen({Key? key, this.userProfile = const {}}) : super(key: key);

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> with SingleTickerProviderStateMixin {
  int currentCardIndex = 0;
  List<Map<String, String>> matches = [];

  late List<Map<String, String>> potentialPartners;

  // Mock data with high-quality placeholder images
  final List<Map<String, String>> _defaultPartners = [
    {
      'name': 'Sarah, 24',
      'goal': 'Video Editing',
      'level': 'Intermediate',
      'availability': 'Morning',
      'frequency': 'Daily',
      'style': 'Structured & Disciplined',
      'compatibility': '95%',
      'image': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      'bio': 'Looking for someone to help me stay consistent with video editing.',
    },
    {
      'name': 'John, 27',
      'goal': 'Running',
      'level': 'Beginner',
      'availability': 'Evening',
      'frequency': '3-4 times/week',
      'style': 'Chill & Flexible',
      'compatibility': '78%',
      'image': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      'bio': 'Need a running buddy to push me further on trails.',
    },
    {
      'name': 'Emma, 22',
      'goal': 'Content Writing',
      'level': 'Advanced',
      'availability': 'Afternoon',
      'frequency': 'Daily',
      'style': 'Competitive',
      'compatibility': '88%',
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      'bio': 'Writing my first novel, let\'s hit our word counts together.',
    },
    {
      'name': 'Alex, 26',
      'goal': 'Video Editing',
      'level': 'Beginner',
      'availability': 'Morning',
      'frequency': 'Daily',
      'style': 'Structured',
      'compatibility': '92%',
      'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      'bio': 'Learning Premiere Pro, looking for a study partner.',
    },
    {
      'name': 'Lisa, 25',
      'goal': 'Exercising',
      'level': 'Intermediate',
      'availability': 'Evening',
      'frequency': '3-4 times/week',
      'style': 'Competitive',
      'compatibility': '85%',
      'image': 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      'bio': 'Gym rat looking for a spotter and accountability partner.',
    },
    {
      'name': 'David, 29',
      'goal': 'App Development',
      'level': 'Advanced',
      'availability': 'Late Night',
      'frequency': 'Weekends',
      'style': 'Focused',
      'compatibility': '90%',
      'image': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      'bio': 'Building a startup, let\'s ship products together.',
    },
  ];

  late AnimationController _animationController;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _rotationAnimation;

  Offset _panOffset = Offset.zero;
  bool _isDragging = false;
  double _screenHeight = 0;
  double _screenWidth = 0;
  
  // To allow undoing the last swipe
  final List<int> _swipedHistory = [];

  int _calculateCompatibility(Map<String, String> partner) {
    if (widget.userProfile.isEmpty) {
      // If no profile, use the default mock value
      return int.tryParse(partner['compatibility']?.replaceAll('%', '') ?? '80') ?? 80;
    }

    int score = 40; // Base score
    
    // Weight matches
    if (widget.userProfile['goal'] == partner['goal']) score += 25;
    if (widget.userProfile['level'] == partner['level']) score += 10;
    if (widget.userProfile['availability'] == partner['availability']) score += 15;
    if (widget.userProfile['frequency'] == partner['frequency']) score += 10;
    
    // For style, try to match partials or exacts
    String userStyle = widget.userProfile['style'] ?? '';
    String partnerStyle = partner['style'] ?? '';
    if (userStyle == partnerStyle) {
      score += 10;
    } else if (userStyle.isNotEmpty && partnerStyle.contains(userStyle.split(' ').first)) {
      score += 5;
    }

    return score.clamp(0, 100);
  }

  @override
  void initState() {
    super.initState();
    
    // Calculate compatibility and sort partners
    potentialPartners = _defaultPartners.map((p) {
      final partner = Map<String, String>.from(p);
      partner['compatibility'] = '${_calculateCompatibility(partner)}%';
      return partner;
    }).toList();
    
    // Sort by compatibility (descending)
    potentialPartners.sort((a, b) {
      int scoreA = int.tryParse(a['compatibility']!.replaceAll('%', '')) ?? 0;
      int scoreB = int.tryParse(b['compatibility']!.replaceAll('%', '')) ?? 0;
      return scoreB.compareTo(scoreA); // Highest first
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Animation finished (card swiped off)
        if (_positionAnimation.value.dx > 0) {
          // Liked
          matches.add(potentialPartners[currentCardIndex]);
        }
        
        setState(() {
          _swipedHistory.add(currentCardIndex);
          currentCardIndex++;
          _panOffset = Offset.zero;
          _isDragging = false;
        });
        _animationController.reset();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _panOffset += details.delta;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
    });

    final threshold = _screenWidth * 0.3; // 30% of screen width
    
    if (_panOffset.dx.abs() > threshold) {
      // Swiped enough to trigger action
      _animateOffScreen(_panOffset.dx > 0);
    } else {
      // Return to center
      _returnToCenter();
    }
  }

  void _animateOffScreen(bool isRight) {
    final targetX = isRight ? _screenWidth * 1.5 : -_screenWidth * 1.5;
    final targetY = _panOffset.dy; // Keep current vertical trajectory
    
    _positionAnimation = Tween<Offset>(
      begin: _panOffset,
      end: Offset(targetX, targetY),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: _getRotation(),
      end: _getRotation() + (isRight ? 0.2 : -0.2), // Slight extra rotation
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward(from: 0);
  }

  void _returnToCenter() {
    _positionAnimation = Tween<Offset>(
      begin: _panOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack, // Nice springy effect
    ));

    _rotationAnimation = Tween<double>(
      begin: _getRotation(),
      end: 0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    _animationController.forward(from: 0).then((_) {
      setState(() {
        _panOffset = Offset.zero;
      });
      _animationController.reset();
    });
  }

  double _getRotation() {
    // Max rotation is roughly 20 degrees (0.35 radians) at screen edge
    return (_panOffset.dx / _screenWidth) * 0.35;
  }

  void _undoSwipe() {
    if (_swipedHistory.isNotEmpty) {
      setState(() {
        int lastIndex = _swipedHistory.removeLast();
        currentCardIndex = lastIndex;
        // Also remove from matches if it was a right swipe
        matches.removeWhere((m) => m['name'] == potentialPartners[lastIndex]['name']);
      });
    }
  }

  void _forceSwipe(bool isRight) {
    if (currentCardIndex >= potentialPartners.length) return;
    
    setState(() {
      _panOffset = Offset(isRight ? 10 : -10, 0); // Give initial small offset to compute direction
    });
    _animateOffScreen(isRight);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'SyncUp',
          style: TextStyle(
            color: Colors.blue.shade700,
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.blue.shade700),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.favorite, color: Colors.blue.shade700),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MatchesScreen(matches: matches),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            children: [
              Expanded(
                child: currentCardIndex < potentialPartners.length
                    ? Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          // Render next card (if any)
                          if (currentCardIndex + 1 < potentialPartners.length)
                            _buildCard(
                              index: currentCardIndex + 1,
                              scale: _calculateBackgroundScale(),
                              offset: Offset.zero,
                              rotation: 0,
                            ),
                            
                          // Render current card (top)
                          _buildCard(
                            index: currentCardIndex,
                            scale: 1.0,
                            offset: _animationController.isAnimating ? _positionAnimation.value : _panOffset,
                            rotation: _animationController.isAnimating ? _rotationAnimation.value : _getRotation(),
                            isTop: true,
                          ),
                        ],
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue.shade50,
                              ),
                              child: Icon(Icons.check_circle_outline, size: 80, color: Colors.blue.shade400),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'You\'re all caught up!',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'You have ${matches.length} potential partners.',
                              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                backgroundColor: Colors.blue.shade600,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MatchesScreen(matches: matches),
                                  ),
                                );
                              },
                              child: const Text('View Matches', style: TextStyle(fontSize: 16, color: Colors.white)),
                            ),
                            const SizedBox(height: 16),
                            TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  currentCardIndex = 0;
                                  matches.clear();
                                  _swipedHistory.clear();
                                });
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text('Reset Stack'),
                            )
                          ],
                        ),
                      ),
              ),
              
              // Bottom Action Buttons
              if (currentCardIndex < potentialPartners.length)
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 30, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        icon: Icons.replay,
                        color: Colors.orange,
                        onPressed: _swipedHistory.isNotEmpty ? _undoSwipe : null,
                        size: 50,
                      ),
                      _buildActionButton(
                        icon: Icons.close,
                        color: Colors.red,
                        onPressed: () => _forceSwipe(false),
                        size: 70,
                      ),
                      _buildActionButton(
                        icon: Icons.favorite,
                        color: Colors.green,
                        onPressed: () => _forceSwipe(true),
                        size: 70,
                      ),
                      _buildActionButton(
                        icon: Icons.star,
                        color: Colors.blue,
                        onPressed: () => _forceSwipe(true),
                        size: 50,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateBackgroundScale() {
    // Scale goes from 0.95 to 1.0 based on how far the top card is dragged
    double dragPercent = (_panOffset.dx.abs() / (_screenWidth * 0.5)).clamp(0.0, 1.0);
    return 0.95 + (dragPercent * 0.05);
  }

  Widget _buildCard({
    required int index,
    required double scale,
    required Offset offset,
    required double rotation,
    bool isTop = false,
  }) {
    final partner = potentialPartners[index];
    
    // Calculate stamp opacities
    double likeOpacity = 0.0;
    double nopeOpacity = 0.0;
    
    if (isTop) {
      if (offset.dx > 0) {
        likeOpacity = (offset.dx / 100).clamp(0.0, 1.0);
      } else {
        nopeOpacity = (-offset.dx / 100).clamp(0.0, 1.0);
      }
    }

    Widget cardContent = Transform.scale(
      scale: scale,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProfileDetailScreen(partner: partner),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 15,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background Image
                Image.network(
                  partner['image']!,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.person, size: 100, color: Colors.grey),
                  ),
                ),
                
                // Gradient Overlay
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 300,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.9),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Profile Info
                Positioned(
                  bottom: 24,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            partner['name']!.split(',')[0], // Extract name
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              partner['name']!.contains(',') ? partner['name']!.split(',')[1].trim() : '',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                shadows: const [Shadow(color: Colors.black45, blurRadius: 4)],
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.info_outline, color: Colors.white, size: 28),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade600.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.target, color: Colors.white, size: 16),
                                const SizedBox(width: 6),
                                Text(
                                  partner['goal']!,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.purple.shade500.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              partner['level']!,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        partner['bio'] ?? 'Looking for an accountability partner.',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.95), 
                          fontSize: 16,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoColumn(Icons.schedule, partner['availability']!),
                          _buildInfoColumn(Icons.repeat, partner['frequency']!),
                          _buildInfoColumn(Icons.favorite, '${partner['compatibility']} Match', color: Colors.pinkAccent),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Stamps (LIKE / NOPE)
                if (isTop) ...[
                  Positioned(
                    top: 50,
                    left: 30,
                    child: Opacity(
                      opacity: likeOpacity,
                      child: Transform.rotate(
                        angle: -0.2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.greenAccent.shade400, width: 4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'LIKE',
                            style: TextStyle(
                              color: Colors.greenAccent.shade400,
                              fontSize: 42,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 30,
                    child: Opacity(
                      opacity: nopeOpacity,
                      child: Transform.rotate(
                        angle: 0.2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.redAccent.shade400, width: 4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'NOPE',
                            style: TextStyle(
                              color: Colors.redAccent.shade400,
                              fontSize: 42,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );

    if (isTop) {
      return Positioned.fill(
        child: GestureDetector(
          onPanStart: _onPanStart,
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          child: Transform.translate(
            offset: offset,
            child: Transform.rotate(
              angle: rotation,
              child: cardContent,
            ),
          ),
        ),
      );
    } else {
      return Positioned.fill(child: cardContent);
    }
  }

  Widget _buildInfoColumn(IconData icon, String text, {Color? color}) {
    return Column(
      children: [
        Icon(icon, color: color ?? Colors.white70, size: 22),
        const SizedBox(height: 6),
        Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback? onPressed,
    required double size,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: Icon(
            icon,
            color: onPressed == null ? Colors.grey.shade300 : color,
            size: size * 0.5,
          ),
        ),
      ),
    );
  }
}

class ProfileDetailScreen extends StatelessWidget {
  final Map<String, String> partner;

  const ProfileDetailScreen({Key? key, required this.partner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: Image.network(
                    partner['image']!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.person, size: 100, color: Colors.grey),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 150,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.white.withOpacity(0.8),
                          Colors.white,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        partner['name']!.split(',')[0],
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          partner['name']!.contains(',') ? partner['name']!.split(',')[1].trim() : '',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.pink.shade200),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.favorite, color: Colors.pink, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          '${partner['compatibility']} Match',
                          style: TextStyle(
                            color: Colors.pink.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'About Me',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    partner['bio'] ?? 'Looking for an accountability partner to help me stay on track with my goals.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade800,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Partner Preferences',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._buildDetailsList(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDetailsList() {
    return [
      _buildDetail(Icons.target, 'Goal', partner['goal']!),
      _buildDetail(Icons.leaderboard, 'Level', partner['level']!),
      _buildDetail(Icons.schedule, 'Availability', partner['availability']!),
      _buildDetail(Icons.repeat, 'Frequency', partner['frequency']!),
      _buildDetail(Icons.psychology, 'Working Style', partner['style']!),
    ];
  }

  Widget _buildDetail(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.blue.shade700, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



// --- app_service.dart ---


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


// --- app_theme.dart ---


class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue.shade400,
      elevation: 0,
      centerTitle: true,
    ),
  );

  // Color palette
  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color primaryPurple = Color(0xFF9C27B0);
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color warningOrange = Color(0xFFFF9800);
  static const Color errorRed = Color(0xFFF44336);
}
