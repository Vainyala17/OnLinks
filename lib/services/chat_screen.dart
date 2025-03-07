import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send message to Firestore
  void sendMessage() async {
    final user = _auth.currentUser;
    if (user == null) {
      print("User not authenticated!");
      return; // Stop if the user is not logged in
    }

    if (_messageController.text.trim().isEmpty) return;

    try {
      await _firestore.collection('messages').add({
        'text': _messageController.text.trim(),
        'sender': user.email,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _messageController.clear();
    } catch (e) {
      print("Error sending message: $e");
    }
  }
  void sendMessage(String message, String formName) {
    FirebaseFirestore.instance.collection('chats').add({
      'message': message,
      'formName': formName,
      'userId': FirebaseAuth.instance.currentUser?.uid, // Store user ID
      'timestamp': FieldValue.serverTimestamp(), // Store time of message
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUserEmail = _auth.currentUser?.email;

    return Scaffold(
      appBar: AppBar(title: Text("Community Chat")),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Error loading messages"));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No messages yet."));
                }
                final messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    bool isMe = message['sender'] == currentUserEmail;

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Row(
                        mainAxisAlignment:
                        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                        children: [
                          if (!isMe) // Show sender name only for others
                            CircleAvatar(
                              backgroundColor: Colors.blueGrey,
                              child: Text(
                                message['sender'][0].toUpperCase(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          SizedBox(width: 8), // Space between avatar and message
                          Column(
                            crossAxisAlignment:
                            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                            children: [
                              if (!isMe)
                                Padding(
                                  padding: EdgeInsets.only(left: 8, bottom: 2),
                                  child: Text(
                                    message['sender'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              Container(
                                padding: EdgeInsets.all(12),
                                margin: EdgeInsets.symmetric(vertical: 2),
                                constraints: BoxConstraints(maxWidth: 250),
                                decoration: BoxDecoration(
                                  color: isMe ? Colors.green : Colors.grey[300],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: isMe ? Radius.circular(15) : Radius.zero,
                                    bottomRight: isMe ? Radius.zero : Radius.circular(15),
                                  ),
                                ),
                                child: Text(
                                  message['text'],
                                  style: TextStyle(color: isMe ? Colors.white : Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // Message Input
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    sendMessage();
                    FocusScope.of(context).unfocus(); // Hide keyboard
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
