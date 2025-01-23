import 'dart:convert';

import 'package:core_dashboard/controllers/evolucao_controller.dart';
import 'package:core_dashboard/controllers/profissional_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../controllers/clientes_controller.dart';
import '../../../shared/constants/config.dart';
import '../../../shared/constants/defaults.dart';
import '../../../shared/constants/ghaps.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../theme/app_colors.dart';

class EvolucaoWidget extends StatefulWidget {
  const EvolucaoWidget({super.key});

  @override
  State<EvolucaoWidget> createState() => _EvolucaoWidgetState();
}

class _EvolucaoWidgetState extends State<EvolucaoWidget> {
  final ClientesController clientesController = Get.find<ClientesController>();
  final ProfissionalController profissionalController = Get.find<ProfissionalController>();
  final EvolucaoController evolucaoController = Get.find<EvolucaoController>();
  late final List<dynamic> dataList;
  final TextEditingController searchController = TextEditingController();
  List<dynamic> filteredEvolucoes = [];

  @override
  void initState() {
    super.initState();
    final dynamic decodedJson = jsonDecode(clientesController.clientes);
    dataList = decodedJson['data'];
    filteredEvolucoes = dataList;
  }

  void _filterEvolucoes(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredEvolucoes = dataList;
      });
    } else {
      final results = dataList.where((cliente) {
        final nome = cliente['nome']?.toLowerCase() ?? '';
        return nome.contains(query.toLowerCase());
      }).toList();

      setState(() {
        filteredEvolucoes = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final int itemCount = filteredEvolucoes.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(AppDefaults.padding),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(AppDefaults.borderRadius),
            ),
          ),
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              labelText: 'Digite o nome do paciente que deseja evoluir',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: _filterEvolucoes,
          ),
        ),
        gapH20,
        Flexible(
          fit: FlexFit.loose,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
              decoration: const BoxDecoration(
                color: AppColors.bgSecondayLight,
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDefaults.borderRadius),
                ),
              ),
              child: SizedBox(
                height: itemCount > 5 ? screenHeight * 0.65 : itemCount * 90,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(filteredEvolucoes[index]['nome']),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.arrow_forward, color: Colors.pink),
                                    onPressed: () async {
                                      AppConfig.showLoadingSpinner(context);
                                      await profissionalController.listarProfissional(context);
                                      if (profissionalController.isError.isFalse) {
                                        clientesController.clientesSelecionado = filteredEvolucoes[index];
                                        await evolucaoController.listarEvolucao(context, filteredEvolucoes[index]['idPaciente']);
                                        AppConfig.hideLoadingSpinner(context);
                                        if (profissionalController.isError.isFalse) {
                                          context.go('/evolucao-cliente/${filteredEvolucoes[index]['nome']}');
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  },
                ),
              )
          ),
        ),
      ],
    );
  }
}
