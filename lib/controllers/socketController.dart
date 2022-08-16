import 'dart:io';

import 'package:get/get.dart';
import 'package:medic/controllers/bandsController.dart';
import 'package:medic/models/band.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  online,
  offline,
  connecting,
  error,
}

class Socket extends GetxController {
  late IO.Socket _socket;
  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;
  Function get on => _socket.on;
  List<Banda> bandas = [];
  late bool _loading = false;
  bool get loading => _loading;

  var cargando = false.obs;

  final bandmai = <Banda>[].obs;
/*   final BandsController bController = Get.put(BandsController()); */
  @override
  void onInit() {
    cargando.value = false;
    iniciarSockete();
  }

  @override
  void onDispose() {}

  iniciarSockete() {
    /* update(); */
    _socket = IO.io(
        'http://20.195.226.148:8081/',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect() // optional
            .build());
    socket.onConnect((data) => {
          socket.on(
              'active-bands',
              (data) => {
                    bandmai.value = Banda.listFromJson(data),
                    cargando.value = true,
                    /*      update() */
                  }),
        });
    socket.onDisconnect((data) => print('Desconectado'));
    socket.onConnectError((data) => print(data));
  }
}
