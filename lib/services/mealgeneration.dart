import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
// Assuming app_theme.dart is in the services directory or accessible via this path
import 'package:befit/services/app_theme.dart';


const String GEMINI_API_KEY = ''; // <--- PLACE YOUR API KEY HERE

class MealChatPage extends StatefulWidget {
  const MealChatPage({super.key});

  @override
  State<MealChatPage> createState() => _MealChatPageState();
}

class _MealChatPageState extends State<MealChatPage> {
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

  Future<void> getMealSuggestion(ChatMessage message) async {
    setState(() {
      _messages.insert(0, message);
      _isTyping = true;
    });

    try {

      final String mealPrompt = "Generate a meal ricepe with full elaboration and also write a points how to make it: \"${message
          .text}\". ";


      final content = Content.text(mealPrompt);
      final response = await _session.sendMessage(content);
      final reply = response.text ??
          "⚠️ Gemini didn't return a meal suggestion.";

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
            text: '⚠️ Error generating meal idea: ${e.toString()}',
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Beƒιт AI Meal Generator',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
              const SizedBox(height: 60), // Add space below app bar
              Expanded(
                child: DashChat(
                  currentUser: _currentUser,
                  onSend: getMealSuggestion,
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
                      hintText: "What meal are you in the mood for?",
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
                    inputTextStyle: TextStyle(color: Colors.white),
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