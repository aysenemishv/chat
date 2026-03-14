import 'package:chat/const/app_colors.dart';
import 'package:chat/core/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.white,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(index);
        },
        type: BottomNavigationBarType.fixed,
        landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
        items: [
          BottomNavigationBarItem(
            icon: SvgIcon(
              iconName: 'assets/icons/chat.svg',
              iconColor: navigationShell.currentIndex == 0
                  ? AppColors.black
                  : AppColors.navBarItemColor,
            ),
            label: 'chat',
          ),
          BottomNavigationBarItem(
            icon: SvgIcon(
              iconName: 'assets/icons/contacts.svg',
              iconColor: navigationShell.currentIndex == 1
                  ? AppColors.black
                  : AppColors.navBarItemColor,
            ),
            label: 'contact',
          ),
          BottomNavigationBarItem(
            icon: SvgIcon(
              iconName: 'assets/icons/discover.svg',
              iconColor: navigationShell.currentIndex == 2
                  ? AppColors.black
                  : AppColors.navBarItemColor,
            ),
            label: 'discover',
          ),
        ],
      ),
    );
  }
}
