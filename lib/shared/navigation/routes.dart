import 'package:core_dashboard/pages/anamnese/anamnese.dart';
import 'package:core_dashboard/pages/authentication/sign_in_page.dart';
import 'package:core_dashboard/pages/cadastros/cliente/cliente.dart';
import 'package:core_dashboard/pages/cadastros/cliente/cliente_search.dart';
import 'package:core_dashboard/pages/cadastros/usuario/usuario_search.dart';
import 'package:core_dashboard/pages/entry_point.dart';
import 'package:core_dashboard/pages/cadastros/profissional/profissional_search.dart';
import 'package:core_dashboard/pages/cadastros/usuario/usuario.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../pages/cadastros/profissional/profissional.dart';
import '../../responsive.dart';
import '../widgets/sidemenu/sidebar.dart';

final routerConfig = GoRouter(
  initialLocation: '/sign-in',
  routes: [
    ShellRoute(
        builder: (context, state, child) {
          bool showSidebar = state.fullPath != '/sign-in' && state.fullPath != '/register';
          return Scaffold(
            drawer: showSidebar ? const Sidebar() : null,
            body: Row(
              children: [
                if (showSidebar && Responsive.isDesktop(context)) const Sidebar(),
                if (showSidebar && Responsive.isTablet(context)) const Sidebar(),
                Expanded(
                  child: child,
                ),
              ],
            ),
          );
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const EntryPoint(),
          ),
          GoRoute(
            path: '/sign-in',
            builder: (context, state) => const SignInPage(),
          ),
          GoRoute(
            path: '/anamnese',
            builder: (context, state) => const Anamnese(),
          ),
          GoRoute(
            path: '/cadastro-search-cliente',
            builder: (context, state) => const ClienteSearch(),
          ),
          GoRoute(
            path: '/cadastro-cliente',
            builder: (context, state) => const Cliente(),
          ),
          GoRoute(
            path: '/cadastro-search-usuario',
            builder: (context, state) => const UsuarioSearch(),
          ),
          GoRoute(
            path: '/cadastro-usuario',
            builder: (context, state) => const Usuario(),
          ),
          GoRoute(
            path: '/cadastro-search-profissional',
            builder: (context, state) => const ProfissionalSearch(),
          ),
          GoRoute(
            path: '/cadastro-profissional',
            builder: (context, state) => const Profissional(),
          )
        ]
    )
  ],
);
