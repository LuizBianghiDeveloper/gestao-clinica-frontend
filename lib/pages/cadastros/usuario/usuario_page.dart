import 'package:core_dashboard/pages/cadastros/usuario/widgets/usuario_widget.dart';
import 'package:core_dashboard/responsive.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants/ghaps.dart';

class UsuarioPage extends StatelessWidget {
  const UsuarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!Responsive.isMobile(context)) gapH24,
        Text(
          "Cadastro de Usuário",
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        gapH20,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              flex: 5,
              child: Column(
                children: [
                  UsuarioWidget(),
                  gapH16,
                ],
              ),
            ),
            if (!Responsive.isMobile(context)) gapW16,
          ],
        )
      ],
    );
  }
}
