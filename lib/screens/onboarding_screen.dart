import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'swipe_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentStep = 0;
  final _goalController = TextEditingController();

  String _currentLevel = '';
  String _lookingFor = '';
  String _frequency = '';
  String _preferredTime = '';
  String _workingStyle = '';
  String _deadline = '';
  String _collaborationType = '';

  final List<Map<String, dynamic>> _questions = [
    {
      'icon': '🎯',
      'title': 'What goal are you working on?',
      'subtitle': 'e.g. "Learn video editing", "Run 5km daily"',
      'type': 'text',
    },
    {
      'icon': '📊',
      'title': "What's your current level?",
      'subtitle': 'Choose the option that best describes you',
      'type': 'choice',
      'options': ['Beginner', 'Intermediate', 'Advanced'],
    },
    {
      'icon': '🔄',
      'title': 'What are you looking for?',
      'subtitle': 'This helps match your expectations',
      'type': 'choice',
      'options': [
        'Someone at same level',
        'Someone more experienced',
        'Learn together',
      ],
    },
    {
      'icon': '⏱️',
      'title': 'How often will you work on this?',
      'subtitle': 'Consistency is key to great partnerships',
      'type': 'choice',
      'options': ['Daily', '3–4 times/week', 'Weekends'],
    },
    {
      'icon': '🕒',
      'title': 'Preferred time to work?',
      'subtitle': 'When are you most productive?',
      'type': 'choice',
      'options': ['Morning', 'Afternoon', 'Night'],
    },
    {
      'icon': '⚡',
      'title': "What's your working style?",
      'subtitle': 'This ensures long-term compatibility',
      'type': 'choice',
      'options': ['Chill & flexible', 'Structured & disciplined', 'Competitive'],
    },
    {
      'icon': '🎯',
      'title': "What's your goal deadline?",
      'subtitle': 'Adding a deadline increases accountability',
      'type': 'choice',
      'options': ['No deadline', '1 month', '3 months', '6 months'],
    },
    {
      'icon': '💬',
      'title': 'How do you want to collaborate?',
      'subtitle': 'Prevents friction later on',
      'type': 'choice',
      'options': ['Chat only', 'Voice/video sessions', 'Regular check-ins'],
    },
  ];

  String _getAnswer(int step) {
    switch (step) {
      case 0:
        return _goalController.text.trim();
      case 1:
        return _currentLevel;
      case 2:
        return _lookingFor;
      case 3:
        return _frequency;
      case 4:
        return _preferredTime;
      case 5:
        return _workingStyle;
      case 6:
        return _deadline;
      case 7:
        return _collaborationType;
      default:
        return '';
    }
  }

  void _setAnswer(int step, String value) {
    setState(() {
      switch (step) {
        case 1:
          _currentLevel = value;
          break;
        case 2:
          _lookingFor = value;
          break;
        case 3:
          _frequency = value;
          break;
        case 4:
          _preferredTime = value;
          break;
        case 5:
          _workingStyle = value;
          break;
        case 6:
          _deadline = value;
          break;
        case 7:
          _collaborationType = value;
          break;
      }
    });
  }

  bool _canProceed() {
    final answer = _getAnswer(_currentStep);
    return answer.isNotEmpty;
  }

  void _next() {
    if (!_canProceed()) return;
    if (_currentStep < _questions.length - 1) {
      setState(() => _currentStep++);
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() {
    final existing = AppState.instance.currentUser;
    if (existing == null) return;

    final name = existing.name;
    final updated = existing.copyWith(
      goal: _goalController.text.trim(),
      currentLevel: _currentLevel,
      lookingFor: _lookingFor,
      frequency: _frequency,
      preferredTime: _preferredTime,
      workingStyle: _workingStyle,
      deadline: _deadline,
      collaborationType: _collaborationType,
      avatarInitials: name.trim().split(' ').map((w) => w.isNotEmpty ? w[0] : '').take(2).join().toUpperCase(),
    );
    AppState.instance.currentUser = updated;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const SwipeScreen()),
    );
  }

  @override
  void dispose() {
    _goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentStep];
    final progress = (_currentStep + 1) / _questions.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: _currentStep > 0,
        leading: _currentStep > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF6C63FF)),
                onPressed: () => setState(() => _currentStep--),
              )
            : null,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress bar
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
                minHeight: 6,
                borderRadius: BorderRadius.circular(3),
              ),
              const SizedBox(height: 8),
              Text(
                'Step ${_currentStep + 1} of ${_questions.length}',
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
              const SizedBox(height: 32),
              Text(
                question['icon'] as String,
                style: const TextStyle(fontSize: 48),
              ),
              const SizedBox(height: 16),
              Text(
                question['title'] as String,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                question['subtitle'] as String,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 32),
              // Input area
              if (question['type'] == 'text')
                TextField(
                  controller: _goalController,
                  autofocus: true,
                  maxLines: 2,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Type your goal here...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 2),
                    ),
                  ),
                ),
              if (question['type'] == 'choice')
                Expanded(
                  child: ListView(
                    children: (question['options'] as List<String>).map((option) {
                      final selected = _getAnswer(_currentStep) == option;
                      return GestureDetector(
                        onTap: () {
                          _setAnswer(_currentStep, option);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: selected
                                ? const Color(0xFF6C63FF)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selected
                                  ? const Color(0xFF6C63FF)
                                  : Colors.grey[300]!,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: selected ? Colors.white : Colors.black87,
                                    fontWeight: selected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                              if (selected)
                                const Icon(Icons.check_circle,
                                    color: Colors.white, size: 20),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _canProceed() ? _next : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  disabledBackgroundColor: Colors.grey[300],
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _currentStep < _questions.length - 1 ? 'Next' : 'Create Profile',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}