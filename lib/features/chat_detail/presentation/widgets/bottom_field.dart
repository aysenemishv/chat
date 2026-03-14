import 'dart:io';

import 'package:chat/const/app_colors.dart';
import 'package:chat/core/models/message_model.dart';
import 'package:chat/core/svg_icon.dart';
import 'package:chat/features/chat/widgets/custom_text_field.dart';
import 'package:chat/providers/chat_provider.dart';
import 'package:chat/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomField extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  const BottomField({
    super.key,
    required this.focusNode,
    required this.textEditingController,
  });

  @override
  State<BottomField> createState() => _BottomFieldState();
}

class _BottomFieldState extends State<BottomField> {
  bool isTapped = false;
  List<String> iconNames = ['actions', 'camera', 'gallery', 'audio'];

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ChatProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!isTapped)
            Row(
              children: [
                BottomFieldIconButton(iconName: iconNames[0]),
                SizedBox(width: 15),
                BottomFieldIconButton(iconName: iconNames[1]),
                SizedBox(width: 15),
                GestureDetector(
                  onTap: () async {
                    File? image = await pickImage();
                    state.addMessage(
                      MessageModel(
                        id: state.messages.length + 1,
                        isMe: true,
                        read: false,
                        time: DateTime.now(),
                        type: 'image',
                        userId: 1,
                        text: null,
                        imageUrls: [image!.path],
                      ),
                    );
                    state.sendedPhoto(false);
                    await uploadImage(image);
                    state.sendedPhoto(true);
                  },
                  child: BottomFieldIconButton(iconName: iconNames[2]),
                ),
                SizedBox(width: 15),
                BottomFieldIconButton(iconName: iconNames[3]),
                SizedBox(width: 15),
              ],
            ),
          if (isTapped)
            IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                setState(() {
                  isTapped = false;
                });
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            ),
          Expanded(
            child: CustomTextField(
              textEditingController: widget.textEditingController,
              focusNode: widget.focusNode,
              borderRadius: BorderRadius.circular(18),
              hintText: 'Aa',
              suffixIcon: IconButton(
                onPressed: () {
                  if (widget.textEditingController.text.isNotEmpty) {
                    state.addMessage(
                      MessageModel(
                        id: state.messages.length + 1,
                        isMe: true,
                        read: true,
                        time: DateTime.now(),
                        type: 'text',
                        userId: 1,
                        text: widget.textEditingController.text,
                      ),
                    );
                    widget.textEditingController.clear();
                  }
                },
                icon: Icon(Icons.arrow_forward_rounded),
              ),
              onTap: () {
                setState(() {
                  isTapped = true;
                });
              },
              onTapOutside: (event) {},
            ),
          ),
          SizedBox(width: 10),
          BottomFieldIconButton(iconName: 'like'),
        ],
      ),
    );
  }
}

class BottomFieldIconButton extends StatelessWidget {
  final String iconName;
  const BottomFieldIconButton({super.key, required this.iconName});

  @override
  Widget build(BuildContext context) {
    return SvgIcon(
      height: 24,
      width: 24,
      iconName: 'assets/icons/$iconName.svg',
      iconColor: AppColors.blue,
    );
  }
}
