import 'dart:math';
import 'package:get/get.dart';
import '../models/user_model.dart';
import 'user_controller.dart';

class SwipeController extends GetxController {
  final RxList<UserProfile> profiles = <UserProfile>[].obs;
  final RxInt currentIndex = 0.obs;
  final RxList<UserProfile> likedProfiles = <UserProfile>[].obs;
  final RxList<UserProfile> matchedProfiles = <UserProfile>[].obs;
  final RxBool isAnimating = false.obs;
  final RxDouble dragOffset = 0.0.obs;

  final _random = Random();

  static final List<UserProfile> _mockProfiles = [
    UserProfile(
      uid: 'mock_1',
      name: 'Priya Sharma',
      email: 'priya@example.com',
      goal: 'Learn Flutter development',
      level: 'Intermediate',
      lookingFor: 'Same level',
      frequency: 'Daily',
      preferredTime: 'Morning',
      workingStyle: 'Structured & disciplined',
      deadline: '3 months',
      collaborationType: 'Regular check-ins',
    ),
    UserProfile(
      uid: 'mock_2',
      name: 'Arjun Mehta',
      email: 'arjun@example.com',
      goal: 'Build a fitness habit & run 5K',
      level: 'Beginner',
      lookingFor: 'More experienced',
      frequency: '3-4 times/week',
      preferredTime: 'Afternoon',
      workingStyle: 'Chill & flexible',
      deadline: '1 month',
      collaborationType: 'Chat only',
    ),
    UserProfile(
      uid: 'mock_3',
      name: 'Kavya Reddy',
      email: 'kavya@example.com',
      goal: 'Master machine learning basics',
      level: 'Advanced',
      lookingFor: 'Learn together',
      frequency: 'Daily',
      preferredTime: 'Night',
      workingStyle: 'Competitive',
      deadline: '3 months',
      collaborationType: 'Voice/video',
    ),
    UserProfile(
      uid: 'mock_4',
      name: 'Rohan Verma',
      email: 'rohan@example.com',
      goal: 'Write a novel in 90 days',
      level: 'Intermediate',
      lookingFor: 'Same level',
      frequency: 'Weekends',
      preferredTime: 'Morning',
      workingStyle: 'Chill & flexible',
      deadline: '3 months',
      collaborationType: 'Chat only',
    ),
    UserProfile(
      uid: 'mock_5',
      name: 'Sneha Patel',
      email: 'sneha@example.com',
      goal: 'Launch my first Shopify store',
      level: 'Beginner',
      lookingFor: 'More experienced',
      frequency: '3-4 times/week',
      preferredTime: 'Afternoon',
      workingStyle: 'Structured & disciplined',
      deadline: '1 month',
      collaborationType: 'Regular check-ins',
    ),
    UserProfile(
      uid: 'mock_6',
      name: 'Dev Nair',
      email: 'dev@example.com',
      goal: 'Learn to play guitar',
      level: 'Beginner',
      lookingFor: 'Learn together',
      frequency: 'Daily',
      preferredTime: 'Night',
      workingStyle: 'Chill & flexible',
      deadline: 'No deadline',
      collaborationType: 'Voice/video',
    ),
    UserProfile(
      uid: 'mock_7',
      name: 'Aisha Khan',
      email: 'aisha@example.com',
      goal: 'Get AWS Cloud Practitioner certified',
      level: 'Intermediate',
      lookingFor: 'Same level',
      frequency: '3-4 times/week',
      preferredTime: 'Morning',
      workingStyle: 'Competitive',
      deadline: '3 months',
      collaborationType: 'Regular check-ins',
    ),
    UserProfile(
      uid: 'mock_8',
      name: 'Vikram Singh',
      email: 'vikram@example.com',
      goal: 'Build a SaaS product from scratch',
      level: 'Advanced',
      lookingFor: 'Same level',
      frequency: 'Daily',
      preferredTime: 'Afternoon',
      workingStyle: 'Structured & disciplined',
      deadline: '3 months',
      collaborationType: 'Voice/video',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    loadProfiles();
  }

  void loadProfiles() {
    final userController = Get.find<UserController>();
    final currentUid = userController.currentUser.value?.uid ?? '';
    profiles.value = _mockProfiles
        .where((p) => p.uid != currentUid)
        .toList();
    currentIndex.value = 0;
  }

  void likeProfile(UserProfile profile) {
    likedProfiles.add(profile);
    _advanceCard();
    if (checkMatch(profile)) {
      matchedProfiles.add(profile);
      Get.dialog(
        _MatchDialog(matchedUser: profile),
        barrierDismissible: false,
      );
    }
  }

  void skipProfile(UserProfile profile) {
    _advanceCard();
  }

  void undoLast() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      if (likedProfiles.isNotEmpty) {
        likedProfiles.removeLast();
      }
    }
  }

  void _advanceCard() {
    if (currentIndex.value < profiles.length) {
      currentIndex.value++;
    }
  }

  bool checkMatch(UserProfile profile) {
    final userController = Get.find<UserController>();
    final myProfile = userController.currentUser.value;
    if (myProfile != null && myProfile.goal.isNotEmpty && profile.goal.isNotEmpty) {
      final myGoalWords = myProfile.goal.toLowerCase().split(' ');
      final theirGoalWords = profile.goal.toLowerCase().split(' ');
      final overlap = myGoalWords.where((w) => theirGoalWords.contains(w) && w.length > 3);
      if (overlap.isNotEmpty) return true;
    }
    return _random.nextDouble() < 0.5;
  }

  bool get hasProfiles => currentIndex.value < profiles.length;
}

class _MatchDialog extends StatelessWidget {
  final UserProfile matchedUser;
  const _MatchDialog({Key? key, required this.matchedUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

// ignore: unused_element
class _Unused extends StatelessWidget {
  const _Unused({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
