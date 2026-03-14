import 'package:chat/const/app_colors.dart';
import 'package:chat/const/app_text_styles.dart';
import 'package:flutter/material.dart';

class ProfileTile extends StatefulWidget {
  final Icon icon;
  final String title;
  final Widget trailing;
  final Function()? onTap;
  final Color iconColor;
  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.trailing,
    required this.onTap,
    required this.iconColor,
  });

  @override
  State<ProfileTile> createState() => _ProfileTileState();
}

class _ProfileTileState extends State<ProfileTile> {
  String number = '';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.iconColor,
                ),
                child: widget.icon,
              ),
              SizedBox(width: 10),
              Text(widget.title, style: AppTextStyles.s17w500clBlack),
              Expanded(child: SizedBox()),
              widget.trailing,
            ],
          ),
        ),
      ),
    );
  }
}
