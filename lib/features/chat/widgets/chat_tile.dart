import 'package:chat/const/app_colors.dart';
import 'package:chat/const/app_text_styles.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/features/chat_detail/presentation/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatTile extends StatelessWidget {
  final ChatUser chatUser;

  const ChatTile({super.key, required this.chatUser});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          context.push(ChatPage.route, extra: chatUser);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundImage: AssetImage(chatUser.imagePath),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatUser.fullName,
                      style: AppTextStyles.s17w500clBlack,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: Text(
                            chatUser.lastMessage,
                            style: AppTextStyles.s14w400clBlack50,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          flex: 1,
                          child: Text(
                            "· ${chatUser.time}",
                            style: AppTextStyles.s14w400clBlack50,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // isRead
              //     ? const Icon(
              //         Icons.check_circle,
              //         size: 16,
              //         color: AppColors.checkIconColor,
              //       )
              const Icon(
                Icons.circle_outlined,
                size: 16,
                color: AppColors.checkIconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
