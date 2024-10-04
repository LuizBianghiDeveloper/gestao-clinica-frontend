import 'package:core_dashboard/responsive.dart';
import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/widgets/sidemenu/sidebar.dart';
import 'package:core_dashboard/shared/widgets/sidemenu/tab_sidebar.dart';
import 'package:flutter/material.dart';

import '../shared/widgets/header.dart';
import 'anamnese/anamnese_page.dart';

final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

class Anamnese extends StatelessWidget {
  const Anamnese({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Header(drawerKey: _drawerKey),
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1360),
                    child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDefaults.padding *
                                (Responsive.isMobile(context) ? 1 : 1.5),
                          ),
                          child: const SafeArea(child: AnamnesePage()),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
