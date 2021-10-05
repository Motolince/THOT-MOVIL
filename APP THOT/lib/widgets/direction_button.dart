import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class DirectionButton extends StatelessWidget {
  final String direction;
  final Icon directionIcon;
  final io.Socket socket;

  const DirectionButton(
      {Key? key,
      required this.direction,
      required this.directionIcon,
      required this.socket})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Ink(
          decoration: ShapeDecoration(
            color: Theme.of(context).colorScheme.surface,
            shape: const CircleBorder(),
          ),
          child: IconButton(
            icon: directionIcon,
            color: Theme.of(context).primaryColor,
            iconSize: 100,
            onPressed: _move,
          ),
        ),
      ),
    );
  }

  void _move() {
    socket.emit(
        "ak:move", <String, dynamic>{"direction": direction, "origin": "MOB"});
  }
}
