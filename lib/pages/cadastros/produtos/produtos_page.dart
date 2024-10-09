import 'package:core_dashboard/pages/cadastros/cliente/widgets/cliente_widget.dart';
import 'package:core_dashboard/pages/cadastros/produtos/widgets/produtos_widget.dart';
import 'package:core_dashboard/responsive.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants/ghaps.dart';

class ProdutosPage extends StatelessWidget {
  const ProdutosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gapH24,
        Text(
          "Cadastro de Produtos",
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
                  ProdutosWidget(),
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
