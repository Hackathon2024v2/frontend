import 'dart:convert';
import 'package:flutter_application_2/widgets/chat_query_button.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_2/main.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Map<String, String>> messages = [
    {"sender": "bot", "message": "Hello! How can I assist you today?"},
  ];

  List<Map<String, dynamic>> chatQueries = [
    {
      'icon': Icons.help,
      'label': "Give me a workout idea",
      'message':
          "Give me a personalized workout idea that I can try immediately.",
    },
    {
      'icon': Icons.celebration,
      'label': "I need encouragement",
      'message':
          "Give me encouragement to motivate me to do physical activity.",
    },
  ];

  final TextEditingController _messageController = TextEditingController();

  void _sendMessage({message = ""}) async {
    String newMessage = message ?? _messageController.text.trim();
    if (newMessage.isNotEmpty) {
      setState(() {
        messages.add({"sender": "user", "message": newMessage});
      });
      _messageController.clear();
      try {
        // API URL
        var url = Uri.parse('https://gpt-query-api.onrender.com/help');

        // API Request
        var response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'text/plain',
          },
          body: jsonEncode(
              {"subject": "Nutrition and training", "question": newMessage}),
        );

        if (response.statusCode == 200) {
          // Directly use the response body as the message since it's plain text
          String botMessage = response.body;

          setState(() {
            // Add bot's response to the chat
            messages.add({"sender": "bot", "message": botMessage});
          });
        } else {
          setState(() {
            messages.add(
                {"sender": "bot", "message": "Sorry, something went wrong."});
          });
        }
      } catch (e) {
        setState(() {
          messages.add({"sender": "bot", "message": "Error: $e"});
        });
      }
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background color
      appBar: AppBar(
        title: const Text(
          'WELLNESS GUIDE',
          style: TextStyle(
            color: Colors.white, // Red color
            fontStyle: FontStyle.italic, // Italic style
            fontSize: 24, // Optional: Adjust size
          ),
        ),
        centerTitle: true,
        backgroundColor: color,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUser = message['sender'] == 'user';
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 14),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[200] : Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        bottomLeft:
                            isUser ? const Radius.circular(12) : Radius.zero,
                        bottomRight:
                            isUser ? Radius.zero : const Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      message['message']!,
                      style: TextStyle(
                        color: isUser ? Colors.black : Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300]!,
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: chatQueries.map((query) {
                      return ChatQueryButton(
                        icon: query['icon'],
                        label: query['label'],
                        value: query['message'],
                        onPressed: () =>
                            _sendMessage(message: query['message']),
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: "Type a message",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Send button
                    GestureDetector(
                      onTap: _sendMessage,
                      child: const CircleAvatar(
                        radius: 24,
                        backgroundColor: color,
                        child: Icon(
                          LineAwesomeIcons.paper_plane_solid,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
