import 'package:chat/const/app_colors.dart';
import 'package:chat/const/app_text_styles.dart';
import 'package:chat/core/svg_icon.dart';
import 'package:chat/data/fake_data.dart';
import 'package:chat/features/chat/widgets/custom_text_field.dart';
import 'package:chat/features/contacts/widgets/contact_item.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  TextEditingController textEditingController = TextEditingController();

  bool isForYou = true;
  void selectCategory(bool isFirst) {
    setState(() {
      isForYou = isFirst;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        scrolledUnderElevation: 3,
        elevation: 0,
        surfaceTintColor: Colors.white,
        shadowColor: AppColors.blackWithOpacity5,
        title: Text("Discover", style: AppTextStyles.s30w700clBlack),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 16),
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
            Categories(selectCategory: selectCategory),
            SizedBox(height: 16),
            isForYou ? _ContactsList() : SizedBox(),
          ],
        ),
      ),
    );
  }
}

class _ContactsList extends StatelessWidget {
  const _ContactsList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => ContactItem(chatUser: chatUsers[index]),
      itemCount: chatUsers.length,
    );
  }
}

class Categories extends StatefulWidget {
  final Function selectCategory;
  const Categories({super.key, required this.selectCategory});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool isForYou = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                widget.selectCategory(true);
                setState(() {
                  isForYou = true;
                });
              },
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: isForYou
                      ? AppColors.blackWithOpacity5
                      : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    'FOR YOU',
                    style: isForYou
                        ? AppTextStyles.s13w700clBlack
                        : AppTextStyles.s13w500clBlack35,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                widget.selectCategory(false);
                setState(() {
                  isForYou = false;
                });
              },
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: !isForYou
                      ? AppColors.blackWithOpacity5
                      : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    'BUSINESSES',
                    style: !isForYou
                        ? AppTextStyles.s13w700clBlack
                        : AppTextStyles.s13w500clBlack35,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
