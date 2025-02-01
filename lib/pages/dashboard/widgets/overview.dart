import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../controllers/agendamento_controller.dart';
import '../../../controllers/clientes_controller.dart';
import '../../../controllers/procedimentos_controller.dart';
import '../../../controllers/profissional_controller.dart';
import '../../../controllers/salas_controller.dart';
import '../../../shared/constants/config.dart';
import '../../../shared/constants/defaults.dart';
import '../../../shared/constants/ghaps.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../theme/app_colors.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  final ClientesController clientesController = Get.find<ClientesController>();
  final ProfissionalController profissionalController = Get.find<ProfissionalController>();
  final ProcedimentosController procedimentosController = Get.find<ProcedimentosController>();
  final SalasController salasController = Get.find<SalasController>();
  final AgendamentoController agendamentoController = Get.find<AgendamentoController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: const BoxDecoration(
        color: AppColors.bgSecondayLight,
        borderRadius: BorderRadius.all(Radius.circular(AppDefaults.borderRadius)),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              SectionTitle(title: "Agenda"),
              Spacer(),
            ],
          ),
          gapH24,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDefaults.borderRadius),
                  ),
                  child: InkWell(
                    onTap: () async {
                      AppConfig.showLoadingSpinner(context);
                      await clientesController.listarClientes(context);
                      if (clientesController.isError.isFalse) {
                        await profissionalController.listarProfissional(context);
                        if (profissionalController.isError.isFalse) {
                          await procedimentosController.listarProcedimentos(context);
                          if (procedimentosController.isError.isFalse) {
                            await salasController.listarSalas(context);
                            AppConfig.hideLoadingSpinner(context);
                            if (salasController.isError.isFalse) {
                              context.go('/novo-agendamento');
                            }
                          }
                        }
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24, horizontal: AppDefaults.padding),
                      child: Column(
                        children: [
                          Icon(Icons.add, size: 40, color: Colors.pink), // Ícone rosa
                          SizedBox(height: 16), // Maior espaçamento vertical
                          Text(
                            'Criar Agendamento',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDefaults.borderRadius),
                  ),
                  child: InkWell(
                    onTap: () async {
                      AppConfig.showLoadingSpinner(context);
                      final String dataAtual = DateFormat('yyyy-MM-dd').format(DateTime.now());
                      await agendamentoController.listarAgendamentoDia(context, dataAtual);
                      AppConfig.hideLoadingSpinner(context);
                      if (agendamentoController.isError.isFalse) {
                        context.go('/agendamento');
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24, horizontal: AppDefaults.padding),
                      child: Column(
                        children: [
                          Icon(Icons.calendar_month, size: 40, color: Colors.pink),
                          SizedBox(height: 16),
                          Text(
                            'Ver Agenda',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
