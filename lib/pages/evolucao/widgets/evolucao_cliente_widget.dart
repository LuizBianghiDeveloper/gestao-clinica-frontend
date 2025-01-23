import 'dart:convert';

import 'package:core_dashboard/controllers/clientes_controller.dart';
import 'package:core_dashboard/controllers/evolucao_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart'; // Import da máscara
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart'; // Import para formatação de data

import '../../../controllers/profissional_controller.dart';
import '../../../shared/constants/config.dart';
import '../../../shared/constants/defaults.dart';
import '../../../shared/constants/ghaps.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../theme/app_colors.dart';

class EvolucaoClienteWidget extends StatefulWidget {
  const EvolucaoClienteWidget({super.key});

  @override
  State<EvolucaoClienteWidget> createState() => _EvolucaoClienteWidgetState();
}

class _EvolucaoClienteWidgetState extends State<EvolucaoClienteWidget> {
  final formKey = GlobalKey<FormState>();

  final MaskedTextController dataController = MaskedTextController(mask: '00/00/0000');
  final TextEditingController descricaoController = TextEditingController();
  final ProfissionalController profissionalController = Get.find<ProfissionalController>();
  final EvolucaoController evolucaoController = Get.find<EvolucaoController>();
  final ClientesController clientesController = Get.find<ClientesController>();
  String? selectedProfissional;
  int? idProfissional;
  late final List<dynamic> dataList;
  List<dynamic> profissionais = [];

  @override
  void initState() {
    super.initState();
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    dataController.text = formattedDate;
    final dynamic decodedJson = jsonDecode(profissionalController.profissional);
    dataList = decodedJson['data'];
    profissionais = dataList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.all(AppDefaults.padding),
        decoration: const BoxDecoration(
          color: AppColors.bgSecondayLight,
          borderRadius: BorderRadius.all(
            Radius.circular(AppDefaults.borderRadius),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                SectionTitle(title: "Cadastrar Evolução"),
                Spacer(),
              ],
            ),
            gapH24,
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: dataController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      labelText: 'Data',
                      border: OutlineInputBorder(),
                      hintText: 'DD/MM/AAAA',
                    ),
                    readOnly: true, // Campo não editável
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length != 10) {
                        return 'Por favor, insira uma data válida';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  TextFormField(
                    controller: descricaoController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Descrição da Evolução',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a descrição da evolução';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  DropdownButtonFormField<String>(
                    value: selectedProfissional,
                    hint: const Text('Selecione o Profissional'),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: profissionais.map((dynamic profissional) {
                      return DropdownMenuItem<String>(
                        value: jsonEncode(profissional),
                        child: Text(profissional['nome'].toString()),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedProfissional = newValue;
                        if (selectedProfissional != null) {
                          Map<String, dynamic> profissionalMap = jsonDecode(selectedProfissional!);
                          idProfissional = profissionalMap['idProfissional'];
                        }
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Por favor, selecione um profissional responsável';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            gapH24,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDefaults.padding * 0.5,
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState?.validate() == true) {
                          AppConfig.showLoadingSpinner(context);
                          var params = <String, dynamic>{};
                          params["descricao"] = descricaoController.text;
                          params["dataEvolucao"] = _formatDateForBackend(dataController.text);
                          await evolucaoController.adicionarEvolucao(context, params, clientesController.clientesSelecionado['idPaciente'], idProfissional!);
                          AppConfig.hideLoadingSpinner(context);
                          if (profissionalController.isError.isFalse) {
                            context.go('/');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Evolução cadastrada com sucesso!',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }
                          descricaoController.clear();
                          selectedProfissional = null;
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Por favor, preencha todos os campos.',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: const Text('Salvar'),
                    ),
                  ),
                ),
                gapW16,
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDefaults.padding * 0.5,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Lógica ao cancelar
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.pink,
                        side: const BorderSide(color: Colors.pink),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: const Text('Cancelar'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateForBackend(String date) {
    try {
      final parsedDate = DateFormat('dd/MM/yyyy').parse(date);
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      return date;
    }
  }
}

