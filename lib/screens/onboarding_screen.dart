import 'package:flutter/material.dart';
import 'swipe_screen.dart';

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
