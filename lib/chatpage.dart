import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fix_it/chat/chat_service.dart';
import 'package:fix_it/components/textfield.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String uid1;

  const ChatPage({
    Key? key,
    required this.uid1,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.uid1, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(widget.uid1, _firebaseAuth.currentUser!.uid),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No messages'));
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          reverse: true,
          itemBuilder: (context, index) {
            final document = snapshot.data!.docs[index];
            return _buildMessageItem(document);
          },
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    if (document.exists) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final isCurrentUser = data['senderId'] == _firebaseAuth.currentUser!.uid;
      return Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.blue.shade200 : Colors.grey.shade300,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
              bottomLeft: isCurrentUser ? Radius.circular(20.0) : Radius.circular(0.0),
              bottomRight: isCurrentUser ? Radius.circular(0.0) : Radius.circular(20.0),
            ),
          ),
          child: Text(
            data['message'] ?? '',
            style: TextStyle(
              color: isCurrentUser ? Colors.white : Colors.black,
            ),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: 'Type a message',
              obscureText: false,
            ),
          ),
          SizedBox(width: 8.0),
          IconButton(
            onPressed: sendMessage,
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
