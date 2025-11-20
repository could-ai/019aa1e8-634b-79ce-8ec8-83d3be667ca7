import 'package:flutter/material.dart';
import 'ai_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;
  final AiService _aiService = AiService();

  @override
  void initState() {
    super.initState();
    // Initial greeting from SK Hacker
    _addMessage("SK Hacker System v1.0 initialized. Waiting for command...", false);
  }

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final String userMessage = _controller.text;
    _controller.clear();

    // Add user message
    _addMessage(userMessage, true);

    setState(() {
      _isTyping = true;
    });

    // Simulate network delay and get response
    await Future.delayed(const Duration(milliseconds: 1500));
    final String response = _aiService.getResponse(userMessage);

    if (mounted) {
      setState(() {
        _isTyping = false;
      });
      _addMessage(response, false);
    }
  }

  void _addMessage(String text, bool isUser) {
    setState(() {
      _messages.add({
        'text': text,
        'isUser': isUser,
        'time': DateTime.now(),
      });
    });
    
    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.terminal, color: Color(0xFF00FF00)),
            const SizedBox(width: 10),
            Text(
              'SK HACKER',
              style: TextStyle(
                color: const Color(0xFF00FF00),
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.green.withOpacity(0.5),
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0xFF00FF00).withOpacity(0.5),
            height: 1.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['isUser'] as bool;
                return _buildMessageBubble(msg['text'], isUser);
              },
            ),
          ),
          if (_isTyping)
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 8),
              child: Row(
                children: [
                  const Text(
                    "> PROCESSING...",
                    style: TextStyle(
                      color: Color(0xFF00FF00),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 10,
                    height: 10,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: const Color(0xFF00FF00),
                    ),
                  ),
                ],
              ),
            ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        decoration: BoxDecoration(
          color: isUser ? const Color(0xFF222222) : const Color(0xFF001100),
          border: Border.all(
            color: isUser ? Colors.grey : const Color(0xFF00FF00),
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isUser ? const Radius.circular(12) : const Radius.circular(0),
            bottomRight: isUser ? const Radius.circular(0) : const Radius.circular(12),
          ),
          boxShadow: isUser ? [] : [
             BoxShadow(
              color: const Color(0xFF00FF00).withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 1,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isUser)
              const Text(
                "SK_AGENT_ROOT:~#",
                style: TextStyle(
                  color: Color(0xFF008F11),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            Text(
              text,
              style: TextStyle(
                color: isUser ? Colors.white : const Color(0xFF00FF00),
                fontSize: 16,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(
          top: BorderSide(color: const Color(0xFF00FF00).withOpacity(0.3)),
        ),
      ),
      child: Row(
        children: [
          const Text(
            "> ",
            style: TextStyle(
              color: Color(0xFF00FF00),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              cursorColor: const Color(0xFF00FF00),
              decoration: const InputDecoration(
                hintText: "Enter command...",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Color(0xFF00FF00)),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
