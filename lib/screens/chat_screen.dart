import 'package:flutter/material.dart';
import '../models/user_model.dart';

class ChatScreen extends StatefulWidget {
  final UserProfile user;

  const ChatScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> messages = [
    {
      'text': 'Hey! Great to match with you 👋',
      'isUser': false,
      'time': '10:30 AM',
    },
    {
      'text': 'Let\'s start working together!',
      'isUser': false,
      'time': '10:31 AM',
    },
    {
      'text': 'Sounds good! When should we start?',
      'isUser': true,
      'time': '10:32 AM',
    },
  ];

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.add({
          'text': _messageController.text,
          'isUser': true,
          'time': 'now',
        });
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.user.name),
            Text(
              widget.user.goal,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Align(
                    alignment: message['isUser']
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: message['isUser']
                            ? const Color(0xFF6C63FF)
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message['text'],
                            style: TextStyle(
                              color: message['isUser']
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            message['time'],
                            style: TextStyle(
                              color: message['isUser']
                                  ? Colors.white70
                                  : Colors.grey,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey[300]!);
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.grey[300]!);
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FloatingActionButton(
                  mini: true,
                  onPressed: _sendMessage,
                  backgroundColor: const Color(0xFF6C63FF),
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}