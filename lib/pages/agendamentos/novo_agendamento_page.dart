import 'package:core_dashboard/pages/agendamentos/widgets/agendamento_widget.dart';
import 'package:core_dashboard/pages/agendamentos/widgets/novo_agendamento_widget.dart';
import 'package:core_dashboard/pages/evolucao/widgets/evolucao_widget.dart';
import 'package:core_dashboard/responsive.dart';
import 'package:flutter/material.dart';

import '../../shared/constants/ghaps.dart';

class NovoAgendamentoPage extends StatelessWidget {
  const NovoAgendamentoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gapH24,
        Text(
          "Agendamento",
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
                  NovoAgendamentoWidget(),
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
