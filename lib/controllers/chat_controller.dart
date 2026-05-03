import 'package:get/get.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';
import 'user_controller.dart';

class ChatController extends GetxController {
  final RxMap<String, RxList<MessageModel>> _conversations =
      <String, RxList<MessageModel>>{}.obs;

  static final Map<String, List<Map<String, dynamic>>> _mockSeedMessages = {
    'mock_1': [
      {'text': 'Hey! Great to match with you 👋', 'fromOther': true, 'minutesAgo': 10},
      {'text': 'I saw you\'re also learning Flutter. We should study together!', 'fromOther': true, 'minutesAgo': 9},
      {'text': 'Absolutely! I\'ve been stuck on state management 😅', 'fromOther': false, 'minutesAgo': 8},
      {'text': 'Same! GetX or BLoC?', 'fromOther': true, 'minutesAgo': 7},
    ],
    'mock_2': [
      {'text': 'Hi there! Ready to crush our fitness goals? 💪', 'fromOther': true, 'minutesAgo': 30},
      {'text': 'Let\'s hold each other accountable!', 'fromOther': false, 'minutesAgo': 28},
    ],
    'mock_3': [
      {'text': 'ML grind squad 🤖', 'fromOther': true, 'minutesAgo': 60},
      {'text': 'Haha yes! Which course are you following?', 'fromOther': false, 'minutesAgo': 55},
      {'text': 'Fast.ai — it\'s amazing. You?', 'fromOther': true, 'minutesAgo': 54},
    ],
  };

  RxList<MessageModel> getMessages(String userId) {
    if (!_conversations.containsKey(userId)) {
      _conversations[userId] = <MessageModel>[].obs;
      _seedMessages(userId);
    }
    return _conversations[userId]!;
  }

  void _seedMessages(String userId) {
    final seed = _mockSeedMessages[userId];
    if (seed == null) return;

    final userController = Get.find<UserController>();
    final myUid = userController.currentUser.value?.uid ?? 'me';
    final now = DateTime.now();

    final seeded = seed.map((m) {
      return MessageModel(
        id: 'seed_${m['text'].hashCode}',
        senderId: (m['fromOther'] as bool) ? userId : myUid,
        receiverId: (m['fromOther'] as bool) ? myUid : userId,
        message: m['text'] as String,
        timestamp: now.subtract(Duration(minutes: m['minutesAgo'] as int)),
      );
    }).toList();

    _conversations[userId]!.addAll(seeded);
  }

  void loadMessages(String userId) {
    getMessages(userId);
  }

  void sendMessage(String text, String receiverId) {
    if (text.trim().isEmpty) return;

    final userController = Get.find<UserController>();
    final myUid = userController.currentUser.value?.uid ?? 'me';

    final message = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: myUid,
      receiverId: receiverId,
      message: text.trim(),
      timestamp: DateTime.now(),
    );

    final msgs = getMessages(receiverId);
    msgs.add(message);

    // Simulate a reply after 1.5s for demo feel
    Future.delayed(const Duration(milliseconds: 1500), () {
      final replies = [
        'That sounds great! 🙌',
        'I agree, let\'s keep each other on track!',
        'Nice progress! How\'s it going?',
        'Awesome! Same here 💪',
        'Let\'s set a check-in for tomorrow?',
      ];
      final reply = MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderId: receiverId,
        receiverId: myUid,
        message: replies[DateTime.now().second % replies.length],
        timestamp: DateTime.now(),
      );
      getMessages(receiverId).add(reply);
    });
  }

  String getLastMessage(String userId) {
    final msgs = _conversations[userId];
    if (msgs == null || msgs.isEmpty) return 'Say hello! 👋';
    return msgs.last.message;
  }
}
