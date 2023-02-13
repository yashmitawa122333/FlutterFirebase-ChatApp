import 'package:flutter/material.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String sender;
  final bool sendByMe;

  const MessageTile({Key? key,
    required this.message,
    required this.sendByMe,
    required this.sender})
      : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: widget.sendByMe ? 0 : 15, right: widget.sendByMe ? 24 : 0, top: 15, bottom: 4),
      alignment: widget.sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: widget.sendByMe ? const EdgeInsets.only(left: 30) : const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.only(left: 20, right: 20, top: 17, bottom: 17,),
        decoration: BoxDecoration(
          borderRadius: widget.sendByMe ? const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20)
          ) : const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20)
          ),
        color: widget.sendByMe ? Theme.of(context).primaryColor : Colors.grey[700],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.sender.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: -0.5),
            ),
            const SizedBox(height: 10,),
            Text(widget.message, style: const TextStyle(fontSize: 16, color: Colors.white),),
          ],
        ),
      ),
    );
  }
}
