import 'package:cyber_chat/Message.dart';
import 'package:cyber_chat/Sockets.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart' show DragStartBehavior;

String name = '';
int id =0;
final inputText = TextEditingController();

void main() async{
  // wait 5 seconds
  //await Future.delayed(Duration(seconds: 3))כ;
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

  ScrollController scrollController = ScrollController();

  void scrollToTheBottom(){
    scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(microseconds: 100), curve: Curves.easeOut);
  }


  List<Message> messages = [];

  void addMessage(data){
    setState(() {
      Map<String, dynamic> msg_json = data;
      print(msg_json);
      messages.add(Message.fromJson(msg_json));
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    inputText.dispose();
    super.dispose();
  }

  createAlertDialogIP(BuildContext context){

    TextEditingController ipField = TextEditingController();

    return showDialog(barrierDismissible: false, context: context, builder: (context){
      return AlertDialog(
        title: Text("Enter the ip address:"),
        content: TextField(
          controller: ipField,
        ),
        actions: <Widget> [
          MaterialButton(
            elevation: 5.0,
            child: Text('submit'),
            onPressed: (){
              //if(first.text.toString().length == 0)
              Navigator.of(context).pop(ipField.text.toString());
            },
          )
        ],
      );
    });
  }

  createAlertDialogID(BuildContext context){

    TextEditingController first = TextEditingController();

    return showDialog(barrierDismissible: false, context: context, builder: (context){
      return AlertDialog(
        title: Text("Enter your name:"),
        content: TextField(
          controller: first,
        ),
        actions: <Widget> [
          MaterialButton(
            elevation: 5.0,
            child: Text('submit'),
            onPressed: (){
              //if(first.text.toString().length == 0)
              Navigator.of(context).pop(first.text.toString());
            },
          )
        ],
      );
    });
  }


  int counter =0;

  @override
  Widget build(BuildContext context) {
    if(counter == 0){
      //Future.delayed(Duration.zero, () => createAlertDialogIP(context)).then((onValue){
        //ip = onValue;
        //print(onValue);
      //});
      Future.delayed(Duration.zero, () => createAlertDialogID(context)).then((onValue){
        name = onValue;
      });
      connect_and_listen(addMessage);
      counter++;
    }
    //Future.delayed(Duration.zero, () => createAlertDialog(context));
    //listening(addMessage);
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
                  controller: scrollController,
                  //dragStartBehavior: DragStartBehavior.down,
                  //physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return Container(
                      padding: EdgeInsets.only(left: 16,right: 16,top: 5,bottom: 5),
                      child: Align(
                        alignment: (messages[index].sender == name? Alignment.topRight:Alignment.topLeft),
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 270),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (messages[index].sender == name? Colors.blue[200]:Colors.grey.shade200)
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
                        scrollToTheBottom();
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
