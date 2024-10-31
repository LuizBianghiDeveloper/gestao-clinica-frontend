import 'package:core_dashboard/pages/dashboard/widgets/agendamento_dia.dart';
import 'package:core_dashboard/pages/dashboard/widgets/avaliacao.dart';
import 'package:core_dashboard/pages/dashboard/widgets/overview.dart';
import 'package:core_dashboard/pages/dashboard/widgets/product_overview.dart';
import 'package:core_dashboard/responsive.dart';
import 'package:flutter/material.dart';

import '../../shared/constants/ghaps.dart';
import 'widgets/comments.dart';
import 'widgets/popular_products.dart';
import 'widgets/pro_tips.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gapH24,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Dashboard",
              style: Theme.of(context).textTheme.headlineSmall!,
            ),
            gapW24,
          ],
        ),
        gapH20,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  const Overview(),
                  gapH16,
                  const AgendamentoDia(),
                  gapH16,
                  if (Responsive.isMobile(context))
                    const Column(
                      children: [
                        gapH16,
                        Comments(),
                        gapH16,
                        Avaliacao(),
                      ],
                    ),
                ],
              ),
            ),
            if (!Responsive.isMobile(context)) gapW16,
            if (!Responsive.isMobile(context))
              const Expanded(
                flex: 2,
                child: Column(
                  children: [
                    gapH16,
                    Comments(),
                    gapH16,
                    Avaliacao(),
                  ],
                ),
              ),
          ],
        )
      ],
    );
  }
}
