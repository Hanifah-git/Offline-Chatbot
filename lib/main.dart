import 'package:flutter/material.dart';
import 'knowledge_entry.dart';
import 'knowledge_service.dart';

void main() => runApp(const ChatApp());

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ChatScreen(), 
    );
  }
}


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();

  List<Map<String, dynamic>> _messages = [];
  List<KnowledgeEntry> _knowledgeBase = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData(); 
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _loadData() async {
    final service = KnowledgeService();
    final data = await service.loadKnowledgeBase();

    setState(() {
      _knowledgeBase = data;
      _isLoading = false; 
    });

    print("SUCCESS: Loaded ${_knowledgeBase.length} knowledge entries.");
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    setState(() {
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
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages.reversed.toList()[index];

                return MessageBubble(
                  text: message['text']!,
                  isUser: message['isUser']!,
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: const Border(top: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller:
                        _textController, 
                    decoration: const InputDecoration(
                      hintText: 'Ask about food, clinic, or education...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _sendMessage,
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
  final String text;
  final bool isUser;

  const MessageBubble({super.key, required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    
    return Align(

      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,

      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),

        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),

        decoration: BoxDecoration(
          color: isUser ? Colors.blue[300] : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: isUser ? Radius.circular(15) : Radius.circular(0),
            bottomRight: isUser ? Radius.circular(0) : Radius.circular(15),
          ),
        ),

        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black, 
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
