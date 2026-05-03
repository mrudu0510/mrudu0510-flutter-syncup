import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'chat_screen.dart';
import 'swipe_screen.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  @override
  Widget build(BuildContext context) {
    final matches = AppState.instance.matches;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Matches',
          style: TextStyle(
            color: Color(0xFF6C63FF),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.swipe, color: Color(0xFF6C63FF)),
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const SwipeScreen()),
            ),
          ),
        ],
      ),
      body: matches.isEmpty
          ? _buildEmptyState(context)
          : _buildMatchesList(matches),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('💫', style: TextStyle(fontSize: 56)),
            const SizedBox(height: 16),
            const Text(
              'No matches yet',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Start swiping to find your accountability partner',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const SwipeScreen()),
              ),
              icon: const Icon(Icons.swipe),
              label: const Text('Start Swiping'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchesList(List<UserProfile> matches) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];
        return _MatchCard(
          user: match,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => ChatScreen(user: match)),
            );
          },
        );
      },
    );
  }
}

class _MatchCard extends StatelessWidget {
  final UserProfile user;
  final VoidCallback onTap;

  const _MatchCard({required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color(0xFF6C63FF),
                  child: Text(
                    user.avatarInitials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '🎯 ${user.goal}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      _chip(user.currentLevel),
                      const SizedBox(width: 4),
                      _chip(user.preferredTime),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chat_bubble_outline, color: Color(0xFF6C63FF)),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EEFF),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: Color(0xFF6C63FF),
        ),
      ),
    );
  }
}
