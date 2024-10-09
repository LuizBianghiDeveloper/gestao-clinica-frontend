import 'package:core_dashboard/responsive.dart';
import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../constants/config.dart';
import 'menu_tile.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  int _activeIndex = 0;

  void _onItemPressed(int index) {
    setState(() {
      _activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (Responsive.isMobile(context))
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDefaults.padding,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: SvgPicture.asset('assets/icons/close_filled.svg'),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDefaults.padding,
                    vertical: AppDefaults.padding * 1.5,
                  ),
                  child: SvgPicture.asset(AppConfig.logo),
                ),
              ],
            ),
            const Divider(),
            gapH16,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDefaults.padding,
                ),
                child: ListView(
                  children: [
                    MenuTile(
                      isActive: _activeIndex == 0,
                      title: "Início",
                      activeIconSrc: "assets/icons/home_filled.svg",
                      inactiveIconSrc: "assets/icons/home_light.svg",
                      onPressed: () {
                        _onItemPressed(0);
                        context.go('/');
                      },
                    ),
                    ExpansionTile(
                      leading: SvgPicture.asset(
                          "assets/icons/profile_circled_light.svg"),
                      title: Text(
                        "Cadastro",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                      ),
                      children: [
                        MenuTile(
                          isSubmenu: true,
                          isActive: _activeIndex == 1,
                          title: "Cliente",
                          onPressed: () {
                            _onItemPressed(1);
                            context.go('/cadastro-search-cliente');
                          },
                        ),
                        MenuTile(
                          isSubmenu: true,
                          isActive: _activeIndex == 2,
                          title: "Usuário",
                          onPressed: () {
                            _onItemPressed(2);
                            context.go('/cadastro-search-usuario');
                          },
                        ),
                        MenuTile(
                          isSubmenu: true,
                          isActive: _activeIndex == 3,
                          title: "Produtos",
                          count: 16,
                          onPressed: () {
                            _onItemPressed(3);
                            context.go('/cadastro-search-produtos');
                          },
                        ),
                        MenuTile(
                          isSubmenu: true,
                          isActive: _activeIndex == 4,
                          title: "Profissional",
                          onPressed: () {
                            _onItemPressed(4);
                            context.go('/cadastro-search-profissional');
                          },
                        ),
                        MenuTile(
                          isSubmenu: true,
                          isActive: _activeIndex == 5,
                          title: "Sala",
                          onPressed: () {
                            _onItemPressed(5);
                            context.go('/cadastro-search-sala');
                          },
                        ),
                        MenuTile(
                          isSubmenu: true,
                          isActive: _activeIndex == 6,
                          title: "Procedimentos",
                          onPressed: () {
                            _onItemPressed(6);
                            context.go('/cadastro-search-procedimento');
                          },
                        ),
                      ],
                    ),
                    MenuTile(
                      isActive: _activeIndex == 7,
                      title: "Agendamentos",
                      activeIconSrc: "assets/icons/message_light.svg",
                      inactiveIconSrc: "assets/icons/message_filled.svg",
                      onPressed: () {
                        _onItemPressed(7);
                        context.go('/agendamento');
                      },
                    ),
                    MenuTile(
                      isActive: _activeIndex == 8,
                      title: "Anamnese",
                      activeIconSrc: "assets/icons/file_add_light.svg",
                      inactiveIconSrc: "assets/icons/file_add_filled.svg",
                      onPressed: () {
                        _onItemPressed(8);
                        context.go('/anamnese');
                      },
                    ),
                    MenuTile(
                      isActive: _activeIndex == 9,
                      title: "Evolução",
                      activeIconSrc: "assets/icons/check_all_light.svg",
                      inactiveIconSrc: "assets/icons/check_all_filled.svg",
                      onPressed: () {
                        _onItemPressed(9);
                        context.go('/evolucao');
                      },
                    ),
                    MenuTile(
                      isActive: _activeIndex == 10,
                      title: "Plano de tratamento",
                      activeIconSrc: "assets/icons/document_light.svg",
                      inactiveIconSrc: "assets/icons/document_filled.svg",
                      onPressed: () {
                        _onItemPressed(10);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Column(
                children: [
                  const Divider(),
                  gapH8,
                  Row(
                    children: [
                      gapW8,
                      Text(
                        'Clinica Estética Avançada',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  gapH20,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

