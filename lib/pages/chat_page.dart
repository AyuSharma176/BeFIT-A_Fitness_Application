import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../services/app_theme.dart';

const String GEMINI_API_KEY = '';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beƒιт AI Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppTheme.backgroundColor,
        primaryColor: AppTheme.appBarBg,
        appBarTheme: AppBarTheme(
          backgroundColor: AppTheme.appBarBg,
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatUser _currentUser = ChatUser(id: '1', firstName: 'You');
  final ChatUser _geminiUser = ChatUser(id: '2', firstName: 'Beƒιт AI');

  final List<ChatMessage> _messages = [];
  late GenerativeModel _model;
  late ChatSession _session;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: GEMINI_API_KEY);
    _session = _model.startChat();
  }

  Future<void> getGeminiResponse(ChatMessage message) async {
    setState(() {
      _messages.insert(0, message);
      _isTyping = true;
    });

    try {
      final content = Content.text(message.text);
      final response = await _session.sendMessage(content);
      final reply = response.text ?? "⚠️ Gemini didn't return a response.";

      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            user: _geminiUser,
            createdAt: DateTime.now(),
            text: reply,
          ),
        );
      });
    } catch (e) {
      print('Gemini Error: $e');
      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            user: _geminiUser,
            createdAt: DateTime.now(),
            text: '⚠️ Error: ${e.toString()}',
          ),
        );
      });
    } finally {
      setState(() {
        _isTyping = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beƒιт AI'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.appBarBg,
              AppTheme.backgroundColor,
              AppTheme.appBarBg,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: DashChat(
                  currentUser: _currentUser,
                  onSend: getGeminiResponse,
                  messages: _messages,
                  messageOptions: MessageOptions(
                    currentUserContainerColor: Colors.deepPurpleAccent,
                    containerColor: Colors.black.withAlpha(160),
                    textColor: Colors.white,
                    borderRadius: 12.0,
                    showTime: true,
                  ),
                  inputOptions: InputOptions(
                    inputDecoration: InputDecoration(
                      hintText: "Type your message...",
                      hintStyle: TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                    inputTextStyle: const TextStyle(color: Colors.white),
                    sendButtonBuilder: (send) {
                      return IconButton(
                        icon: const Icon(Icons.send, color: Colors.deepPurple),
                        onPressed: _isTyping ? null : send,
                      );
                    },
                    alwaysShowSend: true,
                    sendOnEnter: true,
                    autocorrect: true,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  typingUsers: _isTyping ? [_geminiUser] : [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
