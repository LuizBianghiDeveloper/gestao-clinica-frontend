import 'package:core_dashboard/pages/cadastros/profissional/widgets/profissional_widget.dart';
import 'package:core_dashboard/responsive.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants/ghaps.dart';

class ProfissionalPage extends StatelessWidget {
  const ProfissionalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!Responsive.isMobile(context)) gapH24,
        Text(
          "Cadastro de Profissional",
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
                  ProfissionalWidget(),
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
