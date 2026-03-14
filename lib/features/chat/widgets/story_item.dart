import 'package:chat/const/app_colors.dart';
import 'package:chat/const/app_text_styles.dart';
import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {
  final String name;
  final String imagePath;
  final bool isAdd;

  const StoryItem({
    super.key,
    required this.name,
    required this.imagePath,
    this.isAdd = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isAdd
            ? Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blackWithOpacity5,
                ),
                child: Icon(Icons.add, size: 20),
              )
            : Stack(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage(imagePath),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                      ),
                      child: Center(
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.green,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        const SizedBox(height: 6),
        Text(name, style: AppTextStyles.s13w400clBlack35),
      ],
    );
  }
}
