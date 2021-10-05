import 'package:ananke_mobile/widgets/direction_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late io.Socket socket;
  bool lightsPower = false;
  String lightsStatus = 'apagadas';

  void connectSocket() {
    socket = io.io('http://middleware.ananke.pro', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false
    });

    socket.connect();
    socket.onConnect((_) => print('=====> Socket Connected!'));

    socket.on('ak:lights', (data) {
      setState(() {
        lightsPower = data['power'];
      });
      updateLightsStatus(data['power']);
    });
  }

  void updateLightsStatus(bool power) {
    setState(() {
      lightsStatus = power ? "encendidas" : "apagadas";
    });
  }

  @override
  Widget build(BuildContext context) {
    connectSocket();

    Widget bigCircle = Container(
      width: 370.0,
      height: 370.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        shape: BoxShape.circle,
      ),
    );

    return Scaffold(
        appBar: null,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // ===== ANANKE LOGO
              SimpleShadow(
                child: const Image(
                  width: 280.0,
                  image: AssetImage('assets/logo_ananke.png'),
                  semanticLabel: 'asdf',
                ),
                opacity: 0.25,
                color: Colors.white,
                offset: const Offset(3, 3),
                sigma: 7,
              ),
              // ===== ANANKE CONTROLLER
              Center(
                child: Stack(
                  children: <Widget>[
                    bigCircle,
                    Positioned(
                      child: DirectionButton(
                          direction: 'forward',
                          directionIcon: const Icon(Icons.arrow_upward),
                          socket: socket),
                      top: 15.0,
                      left: 125.0,
                    ),
                    Positioned(
                      child: DirectionButton(
                          direction: 'left',
                          directionIcon: const Icon(Icons.arrow_back),
                          socket: socket),
                      top: 125.0,
                      left: 15.0,
                    ),
                    Positioned(
                      child: Column(
                        children: <Widget>[
                          const Text(
                            "LUCES",
                            style: TextStyle(fontSize: 16),
                          ),
                          CupertinoSwitch(
                              activeColor: Theme.of(context).primaryColor,
                              value: lightsPower,
                              onChanged: (bool value) {
                                setState(() {
                                  lightsPower = value;
                                });
                                socket.emit('ak:lights', <String, bool>{
                                  'power': value,
                                });
                              }),
                          // Text(
                          //   lightsStatus,
                          //   style: const TextStyle(fontSize: 10),
                          // ),
                        ],
                      ),
                      top: 155.0,
                      left: 155.0,
                    ),
                    Positioned(
                      child: DirectionButton(
                          direction: 'right',
                          directionIcon: const Icon(Icons.arrow_forward),
                          socket: socket),
                      top: 125.0,
                      right: 15.0,
                    ),
                    Positioned(
                      child: DirectionButton(
                          direction: 'backward',
                          directionIcon: const Icon(Icons.arrow_downward),
                          socket: socket),
                      bottom: 15.0,
                      left: 125.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }
}
