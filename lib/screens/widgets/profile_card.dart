import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/user_model.dart';
import '../../utils/constants.dart';

class ProfileCard extends StatelessWidget {
  final UserProfile user;
  final List<LinearGradient> _gradients = const [
    AppConstants.cardGradient1,
    AppConstants.cardGradient2,
    AppConstants.cardGradient3,
    AppConstants.cardGradient4,
  ];

  const ProfileCard({Key? key, required this.user}) : super(key: key);

  LinearGradient _getGradient() {
    return _gradients[user.uid.hashCode.abs() % _gradients.length];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: _getGradient(),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAvatar(),
            const SizedBox(height: 20),
            _buildNameAndLevel(),
            const SizedBox(height: 16),
            _buildGoal(),
            const SizedBox(height: 16),
            _buildChips(),
            const Spacer(),
            _buildBottomRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Row(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.25),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
          ),
          child: Center(
            child: Text(
              user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (user.level.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    user.level,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNameAndLevel() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🎯 Goal',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user.goal.isNotEmpty ? user.goal : 'No goal set yet',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildGoal() {
    return Row(
      children: [
        if (user.frequency.isNotEmpty)
          _chip(Icons.repeat, user.frequency),
        if (user.frequency.isNotEmpty && user.preferredTime.isNotEmpty)
          const SizedBox(width: 8),
        if (user.preferredTime.isNotEmpty)
          _chip(Icons.access_time, user.preferredTime),
      ],
    );
  }

  Widget _buildChips() {
    final chips = <Widget>[];
    if (user.workingStyle.isNotEmpty) {
      chips.add(_chip(Icons.psychology_outlined, user.workingStyle));
    }
    if (user.lookingFor.isNotEmpty) {
      chips.add(_chip(Icons.people_outline, user.lookingFor));
    }
    if (chips.isEmpty) return const SizedBox.shrink();
    return Wrap(spacing: 8, runSpacing: 8, children: chips);
  }

  Widget _chip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomRow() {
    if (user.collaborationType.isEmpty && user.deadline.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (user.collaborationType.isNotEmpty) ...[
            const Icon(Icons.chat_bubble_outline,
                color: Colors.white70, size: 14),
            const SizedBox(width: 4),
            Text(
              user.collaborationType,
              style:
                  const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
          const Spacer(),
          if (user.deadline.isNotEmpty) ...[
            const Icon(Icons.flag_outlined, color: Colors.white70, size: 14),
            const SizedBox(width: 4),
            Text(
              user.deadline,
              style:
                  const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}
