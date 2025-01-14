import 'package:core_dashboard/controllers/salas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/constants/defaults.dart';
import '../../../../shared/constants/ghaps.dart';
import '../../../../shared/widgets/section_title.dart';
import '../../../../theme/app_colors.dart';

class SalaWidget extends StatefulWidget {
  const SalaWidget({super.key});

  @override
  State<SalaWidget> createState() => _SalaWidgetState();
}

class _SalaWidgetState extends State<SalaWidget> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final SalasController salasController = Get.find<SalasController>();

  @override
  void initState() {
    super.initState();

    if (salasController.salaSelecionado != null && salasController.salaSelecionado != "") {
      final sala = salasController.salaSelecionado;

      nomeController.text = sala['numero'] ?? '';
      descricaoController.text = sala['descricao'] ?? '';
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
              SectionTitle(title: "Dados do consultório"),
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
                          labelText: 'Nome',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o nome da sala';
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
                        if (salasController.salaSelecionado != null && salasController.salaSelecionado != "") {
                          var params = <String, dynamic>{};

                          params["numero"] = nomeController.text;
                          params["descricao"] = descricaoController.text;

                          await salasController.atualizarSala(context, params, salasController.salaSelecionado['idSala']);
                          if (salasController.isError.isTrue) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Não foi possivel atualizar a sala, por favor, tente novamente.'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Sala atualizada com sucesso.'),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ),
                            );
                            await salasController.listarSalas(context);
                            context.go('/cadastro-search-sala');
                          }
                        } else {
                          var params = <String, dynamic>{};
                          params["numero"] = nomeController.text;
                          params["descricao"] = descricaoController.text;

                          await salasController.adicionarSalas(context, params);
                          if (salasController.isError.isTrue) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Não foi possivel adicionar a sala, por favor, tente novamente.'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Sala adicionada com sucesso.'),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ),
                            );
                            await salasController.listarSalas(context);
                            context.go('/cadastro-search-sala');
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Por favor, preencha todos os campos do cadastro de consultório.',
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
                    child: salasController.salaSelecionado != null && salasController.salaSelecionado != "" ? const Text('Atualizar') : const Text('Salvar'),
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
                      context.go('/cadastro-search-sala');
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
