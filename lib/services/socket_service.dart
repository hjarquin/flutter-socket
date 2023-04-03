import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket = IO.io('http://192.168.1.99:3001/', {
    'transports': ['websocket'],
    'autoConnect': true
  });

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    // Dart client
    //_socket =
    print('Socket Service Init');
    _socket.onConnect((_) {
       _serverStatus = ServerStatus.Online;
      print('connect');
      notifyListeners();
    });


    socket.onDisconnect((_) {
      _serverStatus = ServerStatus.Offline;
       print('disconnect');
      notifyListeners();
    });
  }
}
