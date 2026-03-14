import 'package:chat/const/app_colors.dart';
import 'package:chat/const/app_text_styles.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/svg_icon.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final ChatUser chatUser;

  const ContactItem({super.key, required this.chatUser});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
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
                child: Text(
                  chatUser.fullName,
                  style: AppTextStyles.s17w500clBlack,
                ),
              ),

              // isRead
              //     ? const Icon(
              //         Icons.check_circle,
              //         size: 16,
              //         color: AppColors.checkIconColor,
              //       )
              IconButton(
                onPressed: () {},
                icon: SvgIcon(
                  iconName: 'assets/icons/hi.svg',
                  height: 16,
                  width: 16,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.blackWithOpacity5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
