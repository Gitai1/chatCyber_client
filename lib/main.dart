import 'package:cyber_chat/Message.dart';
import 'package:cyber_chat/Sockets.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



void main() async{
  connect_and_listen();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Gitai\'s chat app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final inputText = TextEditingController();

  List<Message> messages = [];

  void addMessage(data){
    setState(() {
      String start = data;
      String who;
      if(start == '3')
        who = 'sender';
      else
        who = 'receiver';
      String msg = data;
      print(msg);
      messages.add(Message(content: msg, sender: who));
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    inputText.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)), backgroundColor: Colors.white,
      body: Column(
        //fit: StackFit.loose,
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  itemCount: messages.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 5,bottom: 5),
                  //physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return Container(
                      padding: EdgeInsets.only(left: 16,right: 16,top: 5,bottom: 5),
                      child: Align(
                        alignment: (messages[index].sender == 'receiver'? Alignment.topLeft:Alignment.topRight),
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 270),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (messages[index].sender == 'receiver'? Colors.grey.shade200:Colors.blue[200])
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(messages[index].content, style: TextStyle(fontSize: 15),),
                        ),
                      ),
                    );
                  },

                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.all(9),
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(width: 10, color: Colors.white),
                borderRadius: const BorderRadius.all(Radius.circular(40)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Enter your message",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none
                      ),
                      controller: inputText,
                    ),
                  ),

                  Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.lightBlue,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send),
                      color: Colors.white,
                      onPressed: () {
                        send(inputText.text);
                        inputText.text = '';
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
