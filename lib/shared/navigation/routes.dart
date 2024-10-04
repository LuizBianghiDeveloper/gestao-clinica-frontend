import 'package:core_dashboard/pages/anamnese.dart';
import 'package:core_dashboard/pages/anamnese/anamnese_page.dart';
import 'package:core_dashboard/pages/authentication/register_page.dart';
import 'package:core_dashboard/pages/authentication/sign_in_page.dart';
import 'package:core_dashboard/pages/entry_point.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            path: '/register',
            builder: (context, state) => const RegisterPage(),
          ),
          GoRoute(
            path: '/anamnese',
            builder: (context, state) => const Anamnese(),
          ),
        ]
    )
  ],
);
