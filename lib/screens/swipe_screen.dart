import 'dart:math';
import 'package:flutter/material.dart';
import 'matches_screen.dart';
import 'profile_screen.dart';

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

