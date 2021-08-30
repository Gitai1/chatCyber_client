import 'dart:io';
import 'dart:convert';

import 'package:cyber_chat/main.dart';



String ip = '192.168.1.189';
int port = 8000;
late Socket socket;

void connect_and_listen() async{
  // connecting to the server
  socket = await Socket.connect(ip, port);
  print('connected');

  // listen to the received data event stream
  socket.listen((List<int> event) {
    addMessage(utf8.decode(event));


  });
  print('HE');
}

void send(msg){
  // sending the packet with the massage to the server
  socket.add(utf8.encode(msg));
}
