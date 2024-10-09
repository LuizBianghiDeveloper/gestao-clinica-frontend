import 'package:core_dashboard/pages/cadastros/sala/widgets/sala_widget.dart';
import 'package:core_dashboard/responsive.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants/ghaps.dart';

class SalaPage extends StatelessWidget {
  const SalaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gapH24,
        Text(
          "Cadastro de Consultório",
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
                  SalaWidget(),
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
