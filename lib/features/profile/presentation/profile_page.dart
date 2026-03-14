import 'package:chat/const/app_colors.dart';
import 'package:chat/const/app_text_styles.dart';
import 'package:chat/features/chat/widgets/custom_text_field.dart';
import 'package:chat/features/profile/widgets/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfilePage extends StatefulWidget {
  static String route = '/profile';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String phoneNumber = '';
  late TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '+993');
    _controller.addListener(() {
      // Ensure the country code cannot be deleted
      if (!_controller.text.startsWith('+993')) {
        _controller.text = '+993';
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var maskFormatter = MaskTextInputFormatter(
    mask: '+993 ## ######',
    filter: {"#": RegExp(r'[0-9]')},
  );

  void onTap() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          actionsPadding: EdgeInsets.all(20),
          actions: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    formatters: [maskFormatter],
                    borderRadius: BorderRadius.circular(10),
                    hintText: 'write your number',
                    onTap: () {},
                    onTapOutside: (e) {},
                    textEditingController: _controller,
                    validator: (value) {
                      if (((value!.replaceAll(RegExp(r'[^0-9]'), '').length <
                                  8) &&
                              !(value.startsWith('+993'))) ||
                          ((value.startsWith('+993')) &&
                              (value.replaceAll(RegExp(r'[^0-9]'), '').length <
                                  11))) {
                        return "Number required";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print('object');
                if (_formKey.currentState!.validate()) {
                  print('men');
                  print(_controller.text);
                  setState(() {
                    phoneNumber = _controller.text;
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('save'),
            ),
          ],
        );
      },
    );
  }

  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    print('object1111');
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      body: ListView(
        children: [
          SizedBox(height: 50),
          Center(
            child: Image.asset(
              'assets/images/user1.png',
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text('Jacob West', style: AppTextStyles.s24w700clBlack),
          ),
          SizedBox(height: 30),
          ProfileTile(
            icon: Icon(Icons.dark_mode, color: AppColors.white),
            title: 'Dark Mode',
            trailing: Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
              inactiveThumbColor: AppColors.white,
            ),
            onTap: () {},
            iconColor: AppColors.black,
          ),

          Row(
            children: [
              SizedBox(width: 50),
              Expanded(
                child: Divider(height: 0, color: AppColors.blackWithOpacity5),
              ),
            ],
          ),
          ProfileTile(
            icon: Icon(Icons.offline_pin_outlined, color: AppColors.white),
            title: 'Active Status',
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.checkIconColor,
              size: 20,
            ),
            onTap: () {},
            iconColor: AppColors.green,
          ),
          Row(
            children: [
              SizedBox(width: 50),
              Expanded(
                child: Divider(height: 0, color: AppColors.blackWithOpacity5),
              ),
            ],
          ),
          ProfileTile(
            icon: Icon(Icons.alternate_email, color: AppColors.white),
            title: 'Username',
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.checkIconColor,
              size: 20,
            ),
            onTap: () {},
            iconColor: AppColors.red,
          ),
          Row(
            children: [
              SizedBox(width: 50),
              Expanded(
                child: Divider(height: 0, color: AppColors.blackWithOpacity5),
              ),
            ],
          ),
          ProfileTile(
            icon: Icon(Icons.call, color: AppColors.white),
            title: 'Phone',
            trailing: Row(
              children: [
                Text(phoneNumber, style: AppTextStyles.s13w400clBlack35),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.checkIconColor,
                  size: 20,
                ),
              ],
            ),
            onTap: onTap,
            iconColor: AppColors.blue,
          ),
          Row(
            children: [
              SizedBox(width: 50),
              Expanded(
                child: Divider(height: 0, color: AppColors.blackWithOpacity5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
