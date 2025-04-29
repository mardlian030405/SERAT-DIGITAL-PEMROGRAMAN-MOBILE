import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_bot_provider.dart';

class ChatBotPage extends StatelessWidget {
  const ChatBotPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chatBotProvider = Provider.of<ChatBotProvider>(context);
    final primaryColor = Colors.indigo; // Single primary color for the design
    final primaryLight = Color.fromRGBO(77, 95, 179, 1); // Indigo 600 equivalent
    final primaryDark = Color.fromRGBO(48, 63, 129, 1); // Indigo 800 equivalent

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_awesome, color: Colors.amber[300]),
            const SizedBox(width: 8),
            const Text(
              'Serat Assistant',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                reverse: false,
                itemCount: chatBotProvider.messages.length,
                itemBuilder: (context, index) {
                  final message = chatBotProvider.messages[index];
                  final isUser = message['sender'] == 'user';
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment:
                      isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (!isUser)
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: Color.fromRGBO(77, 95, 179, 0.2),
                            child: Icon(
                              Icons.auto_awesome,
                              size: 16,
                              color: primaryColor,
                            ),
                          ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: isUser ? primaryColor : Colors.grey[200],
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(18),
                                topRight: const Radius.circular(18),
                                bottomLeft: Radius.circular(isUser ? 18 : 4),
                                bottomRight: Radius.circular(isUser ? 4 : 18),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(25),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Text(
                              message['text']!,
                              style: TextStyle(
                                color: isUser ? Colors.white : Colors.grey[800],
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        if (isUser) const SizedBox(width: 8),
                        if (isUser)
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: Color.fromRGBO(77, 95, 179, 0.1),
                            child: Icon(
                              Icons.person,
                              size: 16,
                              color: primaryColor,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(25),
                  blurRadius: 12,
                  offset: const Offset(0, -2),
                ),
              ],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: chatBotProvider.controller,
                      decoration: InputDecoration(
                        hintText: 'Ask about e-books...',
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.mic_none,
                          color: primaryLight.withAlpha(150),
                        ),
                      ),
                      onSubmitted: (value) => chatBotProvider.sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: primaryDark.withAlpha(76),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: chatBotProvider.sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}