import 'package:core_dashboard/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../constants/defaults.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.drawerKey});

  final GlobalKey<ScaffoldState> drawerKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDefaults.padding, vertical: AppDefaults.padding),
      color: AppColors.bgSecondayLight,
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            if (Responsive.isMobile(context))
              IconButton(
                onPressed: () {
                  drawerKey.currentState!.openDrawer();
                },
                icon: Badge(
                  isLabelVisible: false,
                  child: SvgPicture.asset(
                    "assets/icons/menu_light.svg",
                  ),
                ),
              ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!Responsive.isMobile(context))
                    PopupMenuButton<int>(
                      icon: const CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://media.istockphoto.com/id/1337144146/pt/vetorial/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=_XeYoSJQIN7GrE08cUQDJCo3U7yvoEp5OKpbhQzpmC0=",
                        ),
                      ),
                      onSelected: (int value) {
                        if (value == 0) {
                          context.go('/sign-in');
                        }
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                        const PopupMenuItem<int>(
                          value: 0,
                          child: ListTile(
                            leading: Icon(Icons.logout),
                            title: Text('Logout'),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
