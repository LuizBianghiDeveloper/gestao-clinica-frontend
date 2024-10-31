import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/constants/defaults.dart';
import '../../../shared/constants/ghaps.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../theme/app_colors.dart';

class AgendamentoDia extends StatelessWidget {
  const AgendamentoDia({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de agendamentos fictícios
    final agendamentos = [
      {'paciente': 'Maria Silva', 'procedimento': 'Limpeza de Pele', 'horario': '10:00'},
      {'paciente': 'João Souza', 'procedimento': 'Massagem Relaxante', 'horario': '12:30'},
      {'paciente': 'Ana Clara', 'procedimento': 'Peeling', 'horario': '15:00'},
      {'paciente': 'Pedro Paulo', 'procedimento': 'Consulta', 'horario': '16:00'},
    ];

    return Container(
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: const BoxDecoration(
        color: AppColors.bgSecondayLight,
        borderRadius: BorderRadius.all(Radius.circular(AppDefaults.borderRadius)),
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
          // Define a altura para três cards e exibe os demais com rolagem
          SizedBox(
            height: 300, // Aproximadamente a altura para exibir três cards
            child: ListView.builder(
              itemCount: agendamentos.length,
              itemBuilder: (context, index) {
                final agendamento = agendamentos[index];
                return Card(
                  color: Colors.white,
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDefaults.borderRadius),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${agendamento['paciente']}',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${agendamento['procedimento']}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          '${agendamento['horario']}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
