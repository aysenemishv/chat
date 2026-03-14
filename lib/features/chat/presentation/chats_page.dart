import 'package:chat/const/app_colors.dart';
import 'package:chat/const/app_text_styles.dart';
import 'package:chat/core/svg_icon.dart';
import 'package:chat/features/chat/presentation/chat_list.dart';
import 'package:chat/features/chat/widgets/custom_text_field.dart';
import 'package:chat/features/chat/widgets/story_item.dart';
import 'package:chat/features/profile/presentation/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:chat/data/fake_data.dart';
import 'package:go_router/go_router.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        scrolledUnderElevation: 3,
        elevation: 0,
        surfaceTintColor: Colors.white,
        shadowColor: AppColors.blackWithOpacity5,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                context.push(ProfilePage.route);
              },
              child: Image.asset(
                'assets/images/user1.png',
                height: 40,
                width: 40,
              ),
            ),
            SizedBox(width: 10),
            Text("Chats", style: AppTextStyles.s30w700clBlack),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgIcon(
              iconName: 'assets/icons/camera.svg',
              height: 20,
              width: 20,
            ),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.blackWithOpacity5,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgIcon(
              iconName: 'assets/icons/note.svg',
              height: 20,
              width: 20,
            ),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.blackWithOpacity5,
            ),
          ),
        ],
        backgroundColor: Colors.white,
        // elevation: 8,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CustomTextField(
                textEditingController: textEditingController,
                borderRadius: BorderRadius.circular(10),
                hintText: 'Search',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SvgIcon(
                    iconName: 'assets/icons/search.svg',
                    iconColor: AppColors.grey,
                  ),
                ),
                onTap: () {},
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
            ),
            SizedBox(height: 16),
            _StoriesSection(),
            SizedBox(height: 16),
            ChatList(),
          ],
        ),
      ),
    );
  }
}

class _StoriesSection extends StatelessWidget {
  const _StoriesSection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: chatUsers.length,
        separatorBuilder: (context, index) => SizedBox(width: 20),
        itemBuilder: (context, index) => StoryItem(
          name: chatUsers[index].name,
          imagePath: chatUsers[index].imagePath,
        ),
      ),
    );
  }
}
