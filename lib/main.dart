import 'package:flutter/material.dart';

void main() => runApp(const ChatApp());

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ChatScreen(), // Use your Stateful Widget here
    );
  }
}

// 1. The StatefulWidget (Immutable)
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

// 2. The State Class (Mutable)
class _ChatScreenState extends State<ChatScreen> {
  // 1. Controller for input - Used to read and clear the TextField
  final _textController = TextEditingController(); 

  // 2. The dynamic State (list of messages) - Holds the chat history
  List<Map<String, dynamic>> _messages = []; 

  // MUST be called to prevent memory leaks
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  // 3. The function that updates the state and handles sending
  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    // Use setState() to tell Flutter to rebuild the UI
    setState(() {
      // Add the user's message to the history
      _messages.add({'text': text, 'isUser': true});
    });

    _textController.clear(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Community Support'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          // 1. CHAT LIST AREA (Expanded to fill space)
          Expanded(
            // Removed the unnecessary Container wrapper
            child: ListView.builder(
              reverse: true, // Shows newest messages at the bottom
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                // Get the message starting from the end of the list (newest first)
                // We use .reversed.toList() to display the list bottom-up.
                final message = _messages.reversed.toList()[index];

                // Use the MessageBubble widget to display the content
                return MessageBubble(
                  text: message['text']!,
                  isUser: message['isUser']!,
                );
              },
            ),
          ),

          // 2. INPUT BAR (Fixed at the bottom)
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: const Border(top: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: <Widget>[
                // 1. TEXT INPUT FIELD (LINKED to _textController)
                Expanded(
                  child: TextField(
                    controller: _textController, // <--- 🔑 FIX: Input Controller Link
                    decoration: const InputDecoration(
                      hintText: 'Ask about food, clinic, or education...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 8.0),

                // 2. SEND BUTTON (LINKED to _sendMessage function)
                ElevatedButton(
                  onPressed: _sendMessage, // <--- 🔑 FIX: Function Link
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('SEND'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  // Properties required for the bubble's content and styling
  final String text;
  final bool isUser;

  const MessageBubble({
    super.key,
    required this.text,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Alignment: Align the bubble to the right for the user, left for the bot.
    return Align(
      // If isUser is true, use Alignment.centerRight. Otherwise, use Alignment.centerLeft.
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      
      child: Container(
        // Set maximum width so text can wrap for long messages
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75, 
        ),
        
        // Margin for spacing between bubbles, padding for internal space around text
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        
        // 2. Decoration and Color: Style the bubble
        decoration: BoxDecoration(
          // If isUser is true, use a blue color; otherwise, use a light grey (bot).
          color: isUser ? Colors.blue[300] : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            // Curve the bottom left corner if it's a user message, or bottom right if it's a bot message
            bottomLeft: isUser ? Radius.circular(15) : Radius.circular(0),
            bottomRight: isUser ? Radius.circular(0) : Radius.circular(15),
          ),
        ),
        
        // 3. Content: Display the text
        child: Text(
          text, 
          style: const TextStyle(
            color: Colors.black, // Use a consistent text color
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}