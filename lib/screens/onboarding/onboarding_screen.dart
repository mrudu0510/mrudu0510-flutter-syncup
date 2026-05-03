import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/user_controller.dart';
import '../../utils/constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final int _totalSteps = 8;

  final _goalController = TextEditingController();
  String _level = '';
  String _lookingFor = '';
  String _frequency = '';
  String _preferredTime = '';
  String _workingStyle = '';
  String _deadline = '';
  String _collaborationType = '';

  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeIn);
    _animController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _goalController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentStep == 0 && _goalController.text.trim().isEmpty) {
      Get.snackbar('Required', 'Please enter your goal',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (_currentStep == 1 && _level.isEmpty) {
      Get.snackbar('Required', 'Please select your level',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (_currentStep < _totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep++);
    } else {
      _finish();
    }
  }

  void _back() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep--);
    }
  }

  Future<void> _finish() async {
    final userController = Get.find<UserController>();
    await userController.saveOnboardingData({
      'goal': _goalController.text.trim(),
      'level': _level,
      'lookingFor': _lookingFor,
      'frequency': _frequency,
      'preferredTime': _preferredTime,
      'workingStyle': _workingStyle,
      'deadline': _deadline,
      'collaborationType': _collaborationType,
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🎉', style: TextStyle(fontSize: 52)),
              const SizedBox(height: 16),
              const Text(
                'Profile Created!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You\'re all set to find your perfect accountability partner',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Get.offAllNamed('/home');
                  },
                  child: const Text('Start Swiping! 🔀'),
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8F8FF), Color(0xFFEEEBFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildGoalStep(),
                    _buildChoiceStep(
                      question: 'What\'s your current level?',
                      icon: '📊',
                      options: AppConstants.levels,
                      selected: _level,
                      onSelect: (v) => setState(() => _level = v),
                    ),
                    _buildChoiceStep(
                      question: 'Who are you looking to partner with?',
                      icon: '🤝',
                      options: AppConstants.lookingForOptions,
                      selected: _lookingFor,
                      onSelect: (v) => setState(() => _lookingFor = v),
                    ),
                    _buildChoiceStep(
                      question: 'How often do you want to check in?',
                      icon: '📅',
                      options: AppConstants.frequencies,
                      selected: _frequency,
                      onSelect: (v) => setState(() => _frequency = v),
                    ),
                    _buildChoiceStep(
                      question: 'When do you prefer to work?',
                      icon: '⏰',
                      options: AppConstants.preferredTimes,
                      selected: _preferredTime,
                      onSelect: (v) => setState(() => _preferredTime = v),
                    ),
                    _buildChoiceStep(
                      question: 'What\'s your working style?',
                      icon: '💡',
                      options: AppConstants.workingStyles,
                      selected: _workingStyle,
                      onSelect: (v) => setState(() => _workingStyle = v),
                    ),
                    _buildChoiceStep(
                      question: 'What\'s your goal deadline?',
                      icon: '🎯',
                      options: AppConstants.deadlines,
                      selected: _deadline,
                      onSelect: (v) => setState(() => _deadline = v),
                    ),
                    _buildChoiceStep(
                      question: 'How do you want to collaborate?',
                      icon: '💬',
                      options: AppConstants.collaborationTypes,
                      selected: _collaborationType,
                      onSelect: (v) => setState(() => _collaborationType = v),
                    ),
                  ],
                ),
              ),
              _buildNavButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'BLEND',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppConstants.primaryColor,
                  letterSpacing: 4,
                ),
              ),
              const Spacer(),
              Text(
                '${_currentStep + 1} / $_totalSteps',
                style: const TextStyle(
                  color: AppConstants.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (_currentStep + 1) / _totalSteps,
              minHeight: 6,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppConstants.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalStep() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text('🎯', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          const Text(
            'What\'s your main goal?',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppConstants.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Be specific! Great partners start with clear goals.',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 32),
          TextField(
            controller: _goalController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText:
                  'e.g. "Learn Flutter and build a complete app in 3 months"',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                    color: AppConstants.primaryColor, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'Learn a new language',
              'Build a startup',
              'Get fit',
              'Read 12 books',
              'Master coding',
            ].map((hint) {
              return GestureDetector(
                onTap: () => setState(() => _goalController.text = hint),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppConstants.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: AppConstants.primaryColor.withOpacity(0.3)),
                  ),
                  child: Text(
                    hint,
                    style: const TextStyle(
                      color: AppConstants.primaryColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceStep({
    required String question,
    required String icon,
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelect,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(icon, style: const TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          Text(
            question,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppConstants.textPrimary,
            ),
          ),
          const SizedBox(height: 32),
          ...options.map((option) {
            final isSelected = selected == option;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => onSelect(option),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppConstants.primaryColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected
                          ? AppConstants.primaryColor
                          : Colors.grey.shade200,
                      width: 2,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color:
                                  AppConstants.primaryColor.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            )
                          ]
                        : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            )
                          ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          option,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : AppConstants.textPrimary,
                          ),
                        ),
                      ),
                      if (isSelected)
                        const Icon(Icons.check_circle,
                            color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildNavButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              flex: 1,
              child: OutlinedButton(
                onPressed: _back,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppConstants.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(color: AppConstants.primaryColor),
                ),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _next,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _currentStep == _totalSteps - 1 ? 'Finish 🎉' : 'Next →',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
