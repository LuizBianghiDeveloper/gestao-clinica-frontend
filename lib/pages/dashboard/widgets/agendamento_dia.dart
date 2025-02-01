import 'package:core_dashboard/controllers/agendamento_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../controllers/app_controller.dart';
import '../../../shared/constants/defaults.dart';
import '../../../shared/constants/ghaps.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../theme/app_colors.dart';

class AgendamentoDia extends StatefulWidget {
  const AgendamentoDia({super.key});

  @override
  State<AgendamentoDia> createState() => _AgendamentoDiaState();
}

class _AgendamentoDiaState extends State<AgendamentoDia> {
  final AppController appController = Get.find<AppController>();
  final AgendamentoController agendamentoController =
      Get.find<AgendamentoController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: const BoxDecoration(
        color: AppColors.bgSecondayLight,
        borderRadius:
            BorderRadius.all(Radius.circular(AppDefaults.borderRadius)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Define a altura mínima para a coluna
        children: [
          const Row(
            children: [
              SectionTitle(title: "Agendamento das próximas 24h"),
              Spacer(),
            ],
          ),
          gapH24,
          agendamentoController.agendamentoPorDia['data'].length > 0
              ? SizedBox(
                  height:
                      300,
                  child: ListView.builder(
                    itemCount:
                        agendamentoController.agendamentoPorDia['data'].length,
                    itemBuilder: (context, index) {
                      final agendamento = agendamentoController
                          .agendamentoPorDia['data'][index];
                      return Card(
                        color: Colors.white,
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppDefaults.borderRadius),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppDefaults.padding, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${agendamento['paciente']['nome']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                '${agendamento['procedimento']['nome']}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                '${agendamento['horarioInicio']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.grey,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Text(
            "Não possui agendamento para as próximas 24 horas",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
