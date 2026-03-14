import 'dart:io';

import 'package:chat/const/app_colors.dart';
import 'package:chat/core/models/message_model.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatefulWidget {
  final MessageModel message;
  final bool previousSame;
  final bool nextSame;
  const MessageBubble({
    super.key,
    required this.message,
    required this.previousSame,
    required this.nextSame,
  });

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  late Radius topLeft;
  late Radius topRight;
  late Radius bottomLeft;
  late Radius bottomRight;

  @override
  void initState() {
    super.initState();
    if (widget.message.isMe) {
      topLeft = Radius.circular(18);
      bottomLeft = Radius.circular(18);
      if (widget.previousSame) {
        topRight = Radius.circular(4);
      } else {
        topRight = Radius.circular(18);
      }
      if (widget.nextSame) {
        bottomRight = Radius.circular(4);
      } else {
        bottomRight = Radius.circular(18);
      }
    } else {
      topRight = Radius.circular(18);
      bottomRight = Radius.circular(18);
      if (widget.previousSame) {
        topLeft = Radius.circular(4);
      } else {
        topLeft = Radius.circular(18);
      }
      if (widget.nextSame) {
        bottomLeft = Radius.circular(4);
      } else {
        bottomLeft = Radius.circular(18);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 50,
        maxWidth: MediaQuery.of(context).size.width * 0.65,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: topLeft,
          topRight: topRight,
          bottomLeft: bottomLeft,
          bottomRight: bottomRight,
        ),
        color: widget.message.isMe && widget.message.type == 'text'
            ? AppColors.blue
            : !widget.message.isMe
            ? AppColors.blackWithOpacity5
            : Colors.transparent,
      ),
      child: widget.message.type == 'text'
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: SelectableText(
                widget.message.text!,
                style: TextStyle(
                  color: widget.message.isMe ? Colors.white : Colors.black,
                ),
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.file(
                File(widget.message.imageUrls![0]),
                height: 300,
                width: 180,
                fit: BoxFit.cover,
              ),
            ),
      // : Row(
      //     mainAxisSize: MainAxisSize.min,
      //     spacing: 2,
      //     children: List.generate(
      //       widget.message.imageUrls!.length <= 3
      //           ? widget.message.imageUrls!.length
      //           : 3,
      //       (index) {
      //         if (index < 2 || widget.message.imageUrls!.length == 3) {
      //           return Image.asset(
      //             widget.message.imageUrls![index],
      //             height: 50,
      //             width: 50,
      //             fit: BoxFit.cover,
      //           );
      //         } else {
      //           return Stack(
      //             children: [
      //               Image.asset(
      //                 widget.message.imageUrls![index],
      //                 height: 50,
      //                 width: 50,
      //                 fit: BoxFit.cover,
      //               ),
      //               Positioned.fill(
      //                 child: Container(
      //                   color: AppColors.blackWithOpacity50,
      //                   child: Center(
      //                     child: Text(
      //                       '3+',
      //                       style: AppTextStyles.s17w400clGrey,
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           );
      //         }
      //       },
      //     ),
      //   ),
    );
  }
}
