import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  final Rx<UserProfile?> currentUser = Rx<UserProfile?>(null);
  final RxBool isOnboardingComplete = false.obs;

  static const String _onboardingKey = 'onboardingComplete';

  @override
  void onInit() {
    super.onInit();
    _checkOnboarding();
  }

  Future<void> _checkOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    isOnboardingComplete.value = prefs.getBool(_onboardingKey) ?? false;
  }

  Future<void> saveOnboardingData(Map<String, dynamic> data) async {
    if (currentUser.value == null) return;

    final updated = currentUser.value!.copyWith(
      goal: data['goal'] ?? currentUser.value!.goal,
      level: data['level'] ?? currentUser.value!.level,
      lookingFor: data['lookingFor'] ?? currentUser.value!.lookingFor,
      frequency: data['frequency'] ?? currentUser.value!.frequency,
      preferredTime: data['preferredTime'] ?? currentUser.value!.preferredTime,
      workingStyle: data['workingStyle'] ?? currentUser.value!.workingStyle,
      deadline: data['deadline'] ?? currentUser.value!.deadline,
      collaborationType:
          data['collaborationType'] ?? currentUser.value!.collaborationType,
    );

    currentUser.value = updated;
    isOnboardingComplete.value = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  void updateProfile(UserProfile profile) {
    currentUser.value = profile;
  }
}
