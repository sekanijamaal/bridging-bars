import 'package:flutter/material.dart';
import 'package:starter/theme_notifier.dart';
import 'package:starter/services/api_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  List<dynamic> _messages = [];
  bool _isLoading = false;

  // Replace these with real IDs
  final int _conversationId = 1; // Example conversation ID
  final int _studentId = 3;      // Example student ID

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    setState(() => _isLoading = true);
    try {
      final messages = await ApiService.getMessages(_conversationId);
      setState(() {
        _messages = messages;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load messages.')),
      );
    }
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    try {
      await ApiService.sendMessage(_conversationId, _studentId, text);
      _messageController.clear();
      _loadMessages();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send message.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Calming webbing background
        Positioned.fill(
          child: Opacity(
            opacity: 0.05,
            child: Image.asset(
              'assets/webbing_pattern.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Row(
              children: const [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/mentor_avatar.png'),
                  radius: 16,
                ),
                SizedBox(width: 8),
                Text("Counselor"),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.brightness_6),
                onPressed: () {
                  ThemeNotifier().toggleTheme();
                },
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _loadMessages,
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: _isLoading
                    ? const Center(
                  child: CircularProgressIndicator(color: Colors.tealAccent),
                )
                    : ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[_messages.length - 1 - index];
                    final isMe = message['sender_id'] == _studentId;
                    return Row(
                      mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        if (!isMe)
                          const CircleAvatar(
                            backgroundImage:
                            AssetImage('assets/mentor_avatar.png'),
                            radius: 16,
                          ),
                        const SizedBox(width: 4),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(12),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          decoration: BoxDecoration(
                            color: isMe
                                ? Colors.tealAccent.withOpacity(0.2)
                                : Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            message['text'],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        if (isMe)
                          const SizedBox(width: 4),
                        if (isMe)
                          const CircleAvatar(
                            backgroundImage:
                            AssetImage('assets/student_avatar.png'),
                            radius: 16,
                          ),
                      ],
                    );
                  },
                ),
              ),
              const Divider(height: 1, color: Colors.grey),
              Container(
                color: Colors.grey.shade900,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: "Type your message...",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.tealAccent),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
