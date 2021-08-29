import 'dart:io';
import 'dart:convert';


String ip = '192.168.1.189';
int port = 8888;
late Socket socket;

void connect() async{
  socket = await Socket.connect(ip, port);
  print('connected');
}

void send(msg){
  socket.add(utf8.encode(msg));
}
