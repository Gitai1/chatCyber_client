

class Message{
  String content;
  String sender;

  Message({
    required this.content,
    required this.sender,
  });
}

List<Message> messagesDemo = [
  Message(content: 'Hey', sender: 'sender'),
  Message(content: 'Hey you', sender: 'receiver'),
  Message(content: 'How are u?', sender: 'sender'),
  Message(content: 'I\'m fine thanks', sender: 'receiver'),
  Message(content: 'How are u?', sender: 'receiver'),
  Message(content: 'great', sender: 'sender'),
  Message(content: 'excellent', sender: 'receiver'),
  Message(content: 'excellent ok, now we will run a test, and anther one', sender: 'sender'),
  //Message(content: 'excellent ok, now we will run a test, and anther one', sender: 'receiver'),
  //Message(content: 'excellent ok, now we will run a test, and anther one', sender: 'sender'),
  //Message(content: 'excellent ok, now we will run a test, and anther one', sender: 'receiver'),

];