import 'package:core_dashboard/controllers/profissional_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/constants/defaults.dart';
import '../../../../shared/constants/ghaps.dart';
import '../../../../shared/widgets/section_title.dart';
import '../../../../theme/app_colors.dart';

class ProfissionalWidget extends StatefulWidget {
  const ProfissionalWidget({super.key});

  @override
  State<ProfissionalWidget> createState() => _ProfissionalWidgetState();
}

class _ProfissionalWidgetState extends State<ProfissionalWidget> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController especialidadeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final ProfissionalController profissionalController = Get.find<ProfissionalController>();

  Color? selectedColor;
  final List<Color> availableColors = [
    Colors.green,
    Colors.pinkAccent,
    Colors.orange,
    Colors.cyan,
    Colors.blue,
    Colors.red,
  ];

  @override
  void initState() {
    super.initState();

    if (profissionalController.profissionalSelecionado != null &&
        profissionalController.profissionalSelecionado != "") {
      final profissional = profissionalController.profissionalSelecionado;

      nomeController.text = profissional['nome'] ?? '';
      especialidadeController.text = profissional['especialidade'] ?? '';
      emailController.text = profissional['email'] ?? '';
      telefoneController.text = profissional['telefone'] ?? '';

      if (profissional['cor'] != null) {
        selectedColor = getColorFromString(profissional['cor'] ?? '');
      }
    }
  }

  String? getStringFromColor(Color? color) {
    if (color == null) return null;

    if (color == Colors.green) return 'Green';
    if (color == Colors.pinkAccent) return 'PinkAccent';
    if (color == Colors.orange) return 'Orange';
    if (color == Colors.cyan) return 'Cyan';
    if (color == Colors.blue) return 'Blue';
    if (color == Colors.red) return 'Red';

    return null;
  }


  Color? getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'green':
        return Colors.green;
      case 'pink':
      case 'pinkaccent':
        return Colors.pinkAccent;
      case 'orange':
        return Colors.orange;
      case 'cyan':
        return Colors.cyan;
      case 'blue':
        return Colors.blue;
      case 'red':
        return Colors.red;
      default:
        return null;
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
              SectionTitle(title: "Dados Pessoais"),
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
                          labelText: 'Nome do profissional',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o nome do profissional';
                          }
                          return null;
                        },
                      ),
                    ),
                    gapW16,
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: especialidadeController,
                        decoration: const InputDecoration(
                          labelText: 'Especialidade do profissional',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a especialidade do profissional';
                          }
                          return null;
                        },
                      ),
                    ),
                    gapW16,
                    Expanded(
                      flex: 1,
                      child: DropdownButtonFormField<Color>(
                        decoration: const InputDecoration(
                          labelText: 'Cor',
                          border: OutlineInputBorder(),
                        ),
                        value: selectedColor,
                        items: List.generate(availableColors.length, (index) {
                          return DropdownMenuItem<Color>(
                            value: availableColors[index],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center, // Centraliza a cor
                              children: [
                                SizedBox(
                                  width: 20, // Tamanho do quadrado
                                  height: 20,
                                  child: Container(
                                    color: availableColors[index],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        onChanged: (Color? newValue) {
                          setState(() {
                            selectedColor = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Por favor, selecione uma cor';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                gapH16,
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o email';
                          }
                          return null;
                        },
                      ),
                    ),
                    gapW16,
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: telefoneController,
                        decoration: const InputDecoration(
                          labelText: 'Telefone',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o telefone do profissional';
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
                      if (formKey.currentState?.validate() == true) {
                        if (profissionalController.profissionalSelecionado != null && profissionalController.profissionalSelecionado != "") {
                          var params = <String, dynamic>{};

                          params["nome"] = nomeController.text;
                          params["especialidade"] = especialidadeController.text;
                          params["email"] = emailController.text;
                          params["telefone"] = telefoneController.text;
                          params["cor"] = getStringFromColor(selectedColor);

                          await profissionalController.atualizarProfissional(context, params, profissionalController.profissionalSelecionado['idProfissional']);
                          if (profissionalController.isError.isTrue) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Não foi possivel atualizar o profissional, por favor, tente novamente.'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Profissional atualizado com sucesso.'),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ),
                            );
                            await profissionalController.listarProfissional(context);
                            context.go('/cadastro-search-profissional');
                          }
                        } else {
                          var params = <String, dynamic>{};
                          params["nome"] = nomeController.text;
                          params["especialidade"] = especialidadeController.text;
                          params["email"] = emailController.text;
                          params["telefone"] = telefoneController.text;
                          params["cor"] = getStringFromColor(selectedColor);

                          await profissionalController.adicionarProfissional(context, params);
                          if (profissionalController.isError.isTrue) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Não foi possivel adicionar o profissional, por favor, tente novamente.'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Profissional adicionado com sucesso.'),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ),
                            );
                            await profissionalController.listarProfissional(context);
                            context.go('/cadastro-search-profissional');
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Por favor, preencha todos os campos do cadastro de profissional.',
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
                    child: profissionalController.profissionalSelecionado != null && profissionalController.profissionalSelecionado != "" ? const Text('Atualizar') : const Text('Salvar'),
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
                      context.go('/cadastro-search-profissional');
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
