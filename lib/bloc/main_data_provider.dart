import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ninjahonda/model/data.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../main.dart';

class MainDataProvider {
  NetworkData _networdkData;
  Data current;

  MainDataProvider() {
    current = Data();
    _networdkData = NetworkData();
    _networdkData.stream.listen((event) {
      current = event;
    });
  }
}

class NetworkData {
  StreamController<Data> _streamController;
  String uri;
  Stream<Data> get stream => _streamController.stream;

  NetworkData() {
    _streamController = StreamController<Data>();
    _streamController.sink.add(Data()); //basically blank initialization is zero data
    tryConnecting();
  }

  Future<void> getUri() async
  {
    while (true) {
      await Future.delayed(Duration(milliseconds: 10));
      uri = settingsController.webSocketAddress.value;
      
      if (isValidUri()) {
        log("uri:${uri}");
        break;
      }
    }
  }

  Future<void> tryConnecting() async {
    // if(!isValidUri())
    await getUri();
    WebSocketChannel
        .connect(
      Uri.parse(uri),
    ).stream.listen( (data) {
        _streamController.sink.add(processNetworkData(data));
      },
      onError: (err) {
        log("webSocketError:${err}");
      },
      onDone: () async {
        log("websocket done");
        log("Reconnecting in 1000 milliseconds");
        await Future.delayed(Duration(milliseconds: 1000));
        tryConnecting();

      },
    );
  }

  bool isValidUri() {
    return uri != null && uri.isNotEmpty;
  }
  Data processNetworkData(var value) {
    String v = value;

    String speedFirstSix = v.substring(0, 6),
        rpmNextEight = v.substring(6, 14),
        fuelNextSix = v.substring(14, 20),
        gearNextTwo = v.substring(20, 22);
    log("$speedFirstSix");
    log("$rpmNextEight");
    log("$fuelNextSix");
    log("$gearNextTwo");
    return Data(
      speedData: double.parse(speedFirstSix),
      rpmData: double.parse(rpmNextEight),
      fuelData: double.parse(fuelNextSix),
      gearData: int.parse(gearNextTwo),
    );
  }
}
