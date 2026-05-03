import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'profile_view_screen.dart';
import 'matches_screen.dart';
import 'chat_screen.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen>
    with SingleTickerProviderStateMixin {
  late List<UserProfile> _profiles;
  int _currentIndex = 0;
  Offset _dragOffset = Offset.zero;
  bool _isDragging = false;
  late AnimationController _undoController;
  int _likeCount = 0;
  // Tracks the last swipe action type and whether it produced a match, for undo support
  _LastAction? _lastAction;

  @override
  void initState() {
    super.initState();
    _profiles = List.from(AppState.instance.mockProfiles);
    _undoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _undoController.dispose();
    super.dispose();
  }

  bool get _hasCards => _currentIndex < _profiles.length;

  void _onDragStart(DragStartDetails details) {
    setState(() => _isDragging = true);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() => _dragOffset += details.delta);
  }

  void _onDragEnd(DragEndDetails details) {
    const threshold = 100.0;
    if (_dragOffset.dx > threshold) {
      _like();
    } else if (_dragOffset.dx < -threshold) {
      _skip();
    } else {
      setState(() {
        _dragOffset = Offset.zero;
        _isDragging = false;
      });
    }
  }

  void _like() {
    final profile = _profiles[_currentIndex];
    final matched = _checkMatch();

    setState(() {
      _dragOffset = Offset.zero;
      _isDragging = false;
      _likeCount++;
      _currentIndex++;
      _lastAction = _LastAction(isLike: true, createdMatch: matched);
    });

    if (matched) {
      AppState.instance.matches.add(profile);
      _showMatchPopup(profile);
    }
  }

  void _skip() {
    setState(() {
      _dragOffset = Offset.zero;
      _isDragging = false;
      _currentIndex++;
      _lastAction = _LastAction(isLike: false, createdMatch: false);
    });
  }

  void _undo() {
    if (_currentIndex == 0) return;
    setState(() {
      _currentIndex--;
      final action = _lastAction;
      // Only roll back match state if the last action was a like that matched
      if (action != null && action.isLike && action.createdMatch) {
        final undoneProfile = _profiles[_currentIndex];
        final removed = AppState.instance.matches
            .any((m) => m.uid == undoneProfile.uid);
        if (removed) {
          AppState.instance.matches
              .removeWhere((m) => m.uid == undoneProfile.uid);
          _likeCount--;
        }
      } else if (action != null && action.isLike) {
        _likeCount--;
      }
      _lastAction = null;
    });
  }

  bool _checkMatch() {
    // Demo matching: simulate a match on every even-numbered like
    return _likeCount % 2 == 0;
  }

  void _showMatchPopup(UserProfile matchedUser) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🎉', style: TextStyle(fontSize: 56)),
              const SizedBox(height: 12),
              const Text(
                "You matched!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C63FF),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You and ${matchedUser.name} both want to grow together.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(user: matchedUser),
                    ),
                  );
                },
                child: const Text('Chat Now'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text(
                  'Keep Swiping',
                  style: TextStyle(color: Color(0xFF6C63FF)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'SyncUp',
          style: TextStyle(
            color: Color(0xFF6C63FF),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.people_outline, color: Color(0xFF6C63FF)),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const MatchesScreen()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _hasCards
                ? _buildCardStack()
                : _buildEmptyState(),
          ),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildCardStack() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Next card (background)
        if (_currentIndex + 1 < _profiles.length)
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
              child: _buildCard(_profiles[_currentIndex + 1], isBackground: true),
            ),
          ),
        // Current card (foreground)
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            child: GestureDetector(
              onPanStart: _onDragStart,
              onPanUpdate: _onDragUpdate,
              onPanEnd: _onDragEnd,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        ProfileViewScreen(user: _profiles[_currentIndex]),
                  ),
                );
              },
              child: Transform.translate(
                offset: _dragOffset,
                child: Transform.rotate(
                  angle: _dragOffset.dx * 0.001,
                  child: Stack(
                    children: [
                      _buildCard(_profiles[_currentIndex]),
                      if (_isDragging) ...[
                        if (_dragOffset.dx > 20)
                          Positioned(
                            top: 40,
                            left: 24,
                            child: _buildStamp('LIKE', Colors.green),
                          ),
                        if (_dragOffset.dx < -20)
                          Positioned(
                            top: 40,
                            right: 24,
                            child: _buildStamp('SKIP', Colors.red),
                          ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStamp(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCard(UserProfile profile, {bool isBackground = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isBackground ? 0.05 : 0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF6C63FF),
                    const Color(0xFF6C63FF).withOpacity(0.7),
                  ],
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      child: Text(
                        profile.avatarInitials,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      profile.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _cardChip('🎯', profile.goal),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: _cardChip('📊', profile.currentLevel)),
                      const SizedBox(width: 8),
                      Expanded(child: _cardChip('⏱️', profile.frequency)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: _cardChip('🕒', profile.preferredTime)),
                      const SizedBox(width: 8),
                      Expanded(child: _cardChip('⚡', profile.workingStyle)),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    'Tap to see full profile',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardChip(String icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EEFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$icon $label',
        style: const TextStyle(fontSize: 12, color: Color(0xFF6C63FF)),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🎉', style: TextStyle(fontSize: 56)),
          const SizedBox(height: 16),
          const Text(
            "You've seen everyone!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Check your matches and start collaborating',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const MatchesScreen()),
            ),
            child: const Text('View Matches'),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Undo button
          _actionButton(
            icon: Icons.replay,
            color: Colors.amber,
            size: 52,
            onTap: _currentIndex > 0 ? _undo : null,
          ),
          // Skip button
          _actionButton(
            icon: Icons.close,
            color: Colors.red,
            size: 64,
            onTap: _hasCards ? _skip : null,
          ),
          // Like button
          _actionButton(
            icon: Icons.favorite,
            color: Colors.green,
            size: 64,
            onTap: _hasCards ? _like : null,
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required Color color,
    required double size,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.25),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: onTap != null ? color : Colors.grey[300],
          size: size * 0.45,
        ),
      ),
    );
  }
}

class _LastAction {
  final bool isLike;
  final bool createdMatch;
  const _LastAction({required this.isLike, required this.createdMatch});
}
