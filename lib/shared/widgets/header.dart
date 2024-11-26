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
                    Row(
                      children: [
                        Text(
                          "Bem vindo, Luiz Bianghi!",
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 8), // Espaço entre o texto e o separador
                        // Substituir VerticalDivider por um Container
                        Container(
                          height: 20, // Ajuste a altura conforme necessário
                          width: 1, // Largura do separador
                          color: Colors.grey, // Cor do separador
                        ),
                        const SizedBox(width: 8),
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.person, color: Colors.grey),
                          onSelected: (value) {
                            if (value == 'logout') {
                              // Ação de logout
                              context.go('/sign-in');
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              const PopupMenuItem<String>(
                                value: 'logout',
                                child: Text('Sair'),
                              ),
                            ];
                          },
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
