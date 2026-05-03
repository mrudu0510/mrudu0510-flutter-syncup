import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import 'user_controller.dart';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;
  final Rx<UserProfile?> currentUser = Rx<UserProfile?>(null);

  static const String _loggedInKey = 'isLoggedIn';
  static const String _userUidKey = 'userUid';
  static const String _userNameKey = 'userName';
  static const String _userEmailKey = 'userEmail';

  @override
  void onInit() {
    super.onInit();
    checkAuthState();
  }

  Future<void> checkAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool(_loggedInKey) ?? false;
    if (loggedIn) {
      final uid = prefs.getString(_userUidKey) ?? '';
      final name = prefs.getString(_userNameKey) ?? '';
      final email = prefs.getString(_userEmailKey) ?? '';
      if (uid.isNotEmpty) {
        currentUser.value = UserProfile(uid: uid, name: name, email: email, goal: '');
        isLoggedIn.value = true;
        final userController = Get.find<UserController>();
        if (userController.currentUser.value == null) {
          userController.currentUser.value =
              UserProfile(uid: uid, name: name, email: email, goal: '');
        }
      }
    }
  }

  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 800));

    if (email.isEmpty || password.isEmpty) {
      isLoading.value = false;
      return false;
    }

    final mockUser = UserProfile(
      uid: 'user_${email.hashCode.abs()}',
      name: email.split('@').first.replaceAll('.', ' '),
      email: email,
      goal: '',
    );

    currentUser.value = mockUser;
    isLoggedIn.value = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, true);
    await prefs.setString(_userUidKey, mockUser.uid);
    await prefs.setString(_userNameKey, mockUser.name);
    await prefs.setString(_userEmailKey, mockUser.email);

    final userController = Get.find<UserController>();
    userController.currentUser.value = mockUser;

    isLoading.value = false;
    return true;
  }

  Future<bool> signup(String email, String password, String name) async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 800));

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      isLoading.value = false;
      return false;
    }

    final mockUser = UserProfile(
      uid: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: name.trim(),
      email: email.trim(),
      goal: '',
    );

    currentUser.value = mockUser;
    isLoggedIn.value = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, true);
    await prefs.setString(_userUidKey, mockUser.uid);
    await prefs.setString(_userNameKey, mockUser.name);
    await prefs.setString(_userEmailKey, mockUser.email);

    final userController = Get.find<UserController>();
    userController.currentUser.value = mockUser;
    userController.isOnboardingComplete.value = false;

    isLoading.value = false;
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    currentUser.value = null;
    isLoggedIn.value = false;

    final userController = Get.find<UserController>();
    userController.currentUser.value = null;
    userController.isOnboardingComplete.value = false;
  }
}
