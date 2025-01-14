import 'package:core_dashboard/controllers/procedimentos_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/constants/defaults.dart';
import '../../../../shared/constants/ghaps.dart';
import '../../../../shared/widgets/section_title.dart';
import '../../../../theme/app_colors.dart';

class ProcedimentoWidget extends StatefulWidget {
  const ProcedimentoWidget({super.key});

  @override
  State<ProcedimentoWidget> createState() => _ProcedimentoWidgetState();
}

class _ProcedimentoWidgetState extends State<ProcedimentoWidget> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController valorController = TextEditingController();
  final ProcedimentosController procedimentosController = Get.find<ProcedimentosController>();

  @override
  void initState() {
    super.initState();

    if (procedimentosController.procedimentosSelecionado != null && procedimentosController.procedimentosSelecionado != "") {
      final procedimento = procedimentosController.procedimentosSelecionado;

      nomeController.text = procedimento['nome'] ?? '';
      descricaoController.text = procedimento['descricao'] ?? '';
      valorController.text = procedimento['valor'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              SectionTitle(title: "Dados"),
              Spacer(),
            ],
          ),
          gapH24,
          Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: nomeController,
                        decoration: const InputDecoration(
                          labelText: 'Nome do procedimento',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o nome do procedimento';
                          }
                          return null;
                        },
                      ),
                    ),
                    gapW16,
                  ],
                ),
                gapH16,
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: descricaoController,
                        decoration: const InputDecoration(
                          labelText: 'Descrição',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a descrição';
                          }
                          return null;
                        },
                      ),
                    ),
                    gapW16,
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: valorController,
                        decoration: const InputDecoration(
                          labelText: 'Confirme o valor',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o valor do procedimento';
                          }
                          return null;
                        },
                      ),
                    ),
                    gapW16,
                  ],
                ),
                gapH24,
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
                      if (formKey.currentState?.validate() == true ) {

                        if (procedimentosController.procedimentosSelecionado != null && procedimentosController.procedimentosSelecionado != "") {
                          var params = <String, dynamic>{};

                          params["nome"] = nomeController.text;
                          params["descricao"] = descricaoController.text;
                          params["valor"] = valorController.text;

                          await procedimentosController.atualizarProcedimentos(context, params, procedimentosController.procedimentosSelecionado['idProcedimento']);
                          if (procedimentosController.isError.isTrue) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Não foi possivel atualizar o procedimento, por favor, tente novamente.'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Procedimento atualizado com sucesso.'),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ),
                            );
                            await procedimentosController.listarProcedimentos(context);
                            context.go('/cadastro-search-procedimento');
                          }
                        } else {
                          var params = <String, dynamic>{};
                          params["nome"] = nomeController.text;
                          params["descricao"] = descricaoController.text;
                          params["valor"] = valorController.text;

                          await procedimentosController.adicionarProcedimentos(context, params);
                          if (procedimentosController.isError.isTrue) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Não foi possivel adicionar o procedimento, por favor, tente novamente.'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Procedimento adicionado com sucesso.'),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ),
                            );
                            await procedimentosController.listarProcedimentos(context);
                            context.go('/cadastro-search-procedimento');
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Por favor, preencha todos os campos do cadastro de procedimento.',
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
                    child: procedimentosController.procedimentosSelecionado != null && procedimentosController.procedimentosSelecionado != "" ? const Text('Atualizar') : const Text('Salvar'),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDefaults.padding * 0.5,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      context.go('/cadastro-search-procedimento');
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
              gapW16,
            ],
          ),
        ],
      ),
    );
  }
}
