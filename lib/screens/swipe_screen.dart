import 'package:flutter/material.dart';
import 'matches_screen.dart';
import 'profile_screen.dart';

class SwipeScreen extends StatefulWidget {
  final Map<String, String> userProfile;

  const SwipeScreen({Key? key, this.userProfile = const {}}) : super(key: key);

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  int currentCardIndex = 0;
  List<Map<String, String>> matches = [];

  // Mock data for potential partners
  final List<Map<String, String>> potentialPartners = [
    {
      'name': 'Sarah',
      'goal': 'Video Editing',
      'level': 'Intermediate',
      'availability': 'Morning',
      'frequency': 'Daily',
      'style': 'Structured & Disciplined',
      'compatibility': '95%',
    },
    {
      'name': 'John',
      'goal': 'Running',
      'level': 'Beginner',
      'availability': 'Evening',
      'frequency': '3-4 times/week',
      'style': 'Chill & Flexible',
      'compatibility': '78%',
    },
    {
      'name': 'Emma',
      'goal': 'Content Writing',
      'level': 'Advanced',
      'availability': 'Afternoon',
      'frequency': 'Daily',
      'style': 'Competitive',
      'compatibility': '88%',
    },
    {
      'name': 'Alex',
      'goal': 'Video Editing',
      'level': 'Beginner',
      'availability': 'Morning',
      'frequency': 'Daily',
      'style': 'Structured & Disciplined',
      'compatibility': '92%',
    },
    {
      'name': 'Lisa',
      'goal': 'Exercising',
      'level': 'Intermediate',
      'availability': 'Evening',
      'frequency': '3-4 times/week',
      'style': 'Competitive',
      'compatibility': '85%',
    },
  ];

  void _swipeRight() {
    setState(() {
      matches.add(potentialPartners[currentCardIndex]);
      currentCardIndex++;
    });

    if (currentCardIndex >= potentialPartners.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No more profiles to swipe')),
      );
      currentCardIndex = potentialPartners.length - 1;
    }
  }

  void _swipeLeft() {
    setState(() {
      currentCardIndex++;
    });

    if (currentCardIndex >= potentialPartners.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No more profiles to swipe')),
      );
      currentCardIndex = potentialPartners.length - 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        title: const Text('Find Your Partner'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade50, Colors.purple.shade50],
          ),
        ),
        child: currentCardIndex < potentialPartners.length
            ? Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfileDetailScreen(
                              partner: potentialPartners[currentCardIndex],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.blue.shade300,
                                  Colors.purple.shade300,
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Profile Header
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          potentialPartners[currentCardIndex]
                                              ['name']!,
                                          style: const TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            potentialPartners[currentCardIndex]
                                                ['level']!,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue.shade400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(0.3),
                                      ),
                                      child: Text(
                                        potentialPartners[currentCardIndex]
                                            ['compatibility']!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Partner Details
                                Column(
                                  children: [
                                    _buildDetailRow(
                                      Icons.target,
                                      'Goal',
                                      potentialPartners[currentCardIndex]
                                          ['goal']!,
                                    ),
                                    const SizedBox(height: 16),
                                    _buildDetailRow(
                                      Icons.schedule,
                                      'Availability',
                                      potentialPartners[currentCardIndex]
                                          ['availability']!,
                                    ),
                                    const SizedBox(height: 16),
                                    _buildDetailRow(
                                      Icons.repeat,
                                      'Frequency',
                                      potentialPartners[currentCardIndex]
                                          ['frequency']!,
                                    ),
                                    const SizedBox(height: 16),
                                    _buildDetailRow(
                                      Icons.style,
                                      'Working Style',
                                      potentialPartners[currentCardIndex]
                                          ['style']!,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Action Buttons
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton.extended(
                          onPressed: _swipeLeft,
                          backgroundColor: Colors.grey.shade400,
                          icon: const Icon(Icons.close),
                          label: const Text('Skip'),
                        ),
                        FloatingActionButton.extended(
                          onPressed: _swipeRight,
                          backgroundColor: Colors.red.shade400,
                          icon: const Icon(Icons.favorite),
                          label: const Text('Like'),
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MatchesScreen(
                                  matches: matches,
                                ),
                              ),
                            );
                          },
                          backgroundColor: Colors.blue.shade400,
                          icon: const Icon(Icons.favorite_border),
                          label: Text(
                            'Matches (${matches.length})',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.done_all,
                      size: 80,
                      color: Colors.blue.shade400,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'No more profiles!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'You have ${matches.length} matches',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MatchesScreen(
                              matches: matches,
                            ),
                          ),
                        );
                      },
                      child: const Text('View All Matches'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ProfileDetailScreen extends StatelessWidget {
  final Map<String, String> partner;

  const ProfileDetailScreen({Key? key, required this.partner})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        title: Text(partner['name']!),
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Text(
              partner['name']!,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade400,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Compatibility: ${partner['compatibility']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Profile Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ..._buildDetailsList(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDetailsList() {
    return [
      _buildDetail('Goal', partner['goal']!),
      _buildDetail('Level', partner['level']!),
      _buildDetail('Availability', partner['availability']!),
      _buildDetail('Frequency', partner['frequency']!),
      _buildDetail('Working Style', partner['style']!),
    ];
  }

  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
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
    );
  }
}
