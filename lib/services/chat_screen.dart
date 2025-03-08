import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send message to Firestore
  Future<void> sendMessage() async {
    final user = _auth.currentUser;
    if (user == null) return;

    String messageText = _messageController.text.trim();
    if (messageText.isEmpty) return;

    try {
      await _firestore.collection('chats').add({
        'message': messageText,
        'userId': user.uid,
        'sender': user.email,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _messageController.clear();
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  // Function to format the date as "Today", "Yesterday", or a full date
  String formatDateHeader(DateTime date) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(Duration(days: 1));

    if (date.isAfter(today)) {
      return "Today";
    } else if (date.isAfter(yesterday)) {
      return "Yesterday";
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserEmail = _auth.currentUser?.email;

    return Scaffold(
      appBar: AppBar(title: Text("OnLinks Chat")),
      body: Column(
        children: [
          // Chat Messages
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('chats')
                  .orderBy('timestamp', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No messages yet."));
                }

                final messages = snapshot.data!.docs;
                String? lastDisplayedDate;

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    bool isMe = message['sender'] == currentUserEmail;

                    // Convert timestamp to readable format
                    Timestamp? timestamp = message['timestamp'];
                    DateTime date = timestamp?.toDate() ?? DateTime.now();
                    String time = DateFormat('hh:mm a').format(date);
                    String formattedDate = formatDateHeader(date);

                    // Show date header only when the date changes
                    bool showDateHeader = lastDisplayedDate != formattedDate;
                    lastDisplayedDate = formattedDate;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (showDateHeader)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Center(
                              child: Text(
                                formattedDate,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        Align(
                          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment:
                            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                            children: [
                              if (!isMe)
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    message['sender'],
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
                                  ),
                                ),
                              Container(
                                padding: EdgeInsets.all(12),
                                margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                                constraints: BoxConstraints(maxWidth: 250),
                                decoration: BoxDecoration(
                                  color: isMe ? Colors.blue[300] : Colors.grey[300],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: isMe ? Radius.circular(15) : Radius.zero,
                                    bottomRight: isMe ? Radius.zero : Radius.circular(15),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      message['message'],
                                      style: TextStyle(color: isMe ? Colors.white : Colors.black),
                                    ),
                                    SizedBox(height: 5),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        time,
                                        style: TextStyle(fontSize: 10, color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                    FocusScope.of(context).unfocus();
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
