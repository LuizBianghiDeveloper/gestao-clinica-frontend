import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../controllers/clientes_controller.dart';
import '../../../../shared/constants/defaults.dart';
import '../../../../shared/constants/ghaps.dart';
import '../../../../shared/widgets/section_title.dart';
import '../../../../theme/app_colors.dart';

class ClienteWidget extends StatefulWidget {
  final Map<String, dynamic>? cliente; // Dados do cliente (opcional)

  const ClienteWidget({super.key, this.cliente});

  @override
  State<ClienteWidget> createState() => _ClienteWidgetState();
}

class _ClienteWidgetState extends State<ClienteWidget> {
  final formKey = GlobalKey<FormState>();

  final phoneController = MaskedTextController(mask: '(00) 00000-0000');
  final birthDateController = MaskedTextController(mask: '00/00/0000');
  final cpfController = MaskedTextController(mask: '000.000.000-00');
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController rgController = TextEditingController();
  final TextEditingController profissaoController = TextEditingController();
  final ClientesController clientesController = Get.find<ClientesController>();

  @override
  void initState() {
    super.initState();

    if (clientesController.clientesSelecionado != null && clientesController.clientesSelecionado != "") {
      final cliente = clientesController.clientesSelecionado;

      nomeController.text = cliente['nome'] ?? '';
      enderecoController.text = cliente['endereco'] ?? '';
      phoneController.text = cliente['telefone'] ?? '';

      // Conversão da data de yyyy-MM-dd para dd/MM/yyyy
      if (cliente['dataNascimento'] != null && cliente['dataNascimento'].isNotEmpty) {
        final data = cliente['dataNascimento'];
        final partes = data.split('-'); // Divide a data no formato yyyy-MM-dd
        if (partes.length == 3) {
          birthDateController.text = "${partes[2]}/${partes[1]}/${partes[0]}"; // Formata para dd/MM/yyyy
        }
      }

      cpfController.text = cliente['cpf'] ?? '';
      rgController.text = cliente['rg'] ?? '';
      profissaoController.text = cliente['profissao'] ?? '';
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
                TextFormField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome';
                    }
                    return null;
                  },
                ),
                gapH16,
                TextFormField(
                  controller: enderecoController,
                  decoration: const InputDecoration(
                    labelText: 'Endereço',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o endereço';
                    }
                    return null;
                  },
                ),
                gapH16,
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Celular',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o número de celular';
                          }
                          return null;
                        },
                      ),
                    ),
                    gapW16,
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: birthDateController,
                        keyboardType: TextInputType.datetime,
                        decoration: const InputDecoration(
                          labelText: 'Data de Nascimento',
                          border: OutlineInputBorder(),
                          hintText: 'DD/MM/AAAA',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a data de nascimento';
                          }
                          return null;
                        },
                      ),
                    ),
                    gapW16,
                    Expanded(
                      flex: 4,
                      child: TextFormField(
                        controller: profissaoController,
                        decoration: const InputDecoration(
                          labelText: 'Profissão',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a profissão';
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
                        controller: cpfController,
                        decoration: const InputDecoration(
                          labelText: 'CPF',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o número do CPF';
                          }
                          return null;
                        },
                      ),
                    ),
                    gapW16,
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: rgController,
                        decoration: const InputDecoration(
                          labelText: 'RG',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o RG';
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
                        if (clientesController.clientesSelecionado != null && clientesController.clientesSelecionado != "") {
                          var params = <String, dynamic>{};

                          // Formatação da data de nascimento (dd/MM/yyyy -> yyyy-MM-dd)
                          var formattedDate = birthDateController.text.split('/').reversed.join('-');

                          // Remoção de máscaras do CPF (deixa apenas números)
                          var formattedCpf = cpfController.text.replaceAll(RegExp(r'\D'), '');

                          params["nome"] = nomeController.text;
                          params["dataNascimento"] = formattedDate;
                          params["telefone"] = phoneController.text;
                          params["rg"] = rgController.text;
                          params["cpf"] = formattedCpf;
                          params["profissao"] = profissaoController.text;
                          params["endereco"] = enderecoController.text;

                          await clientesController.atualizarClientes(context, params, clientesController.clientesSelecionado['idPaciente']);
                          if (clientesController.isError.isTrue) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Não foi possivel atualizar o usuário, por favor, tente novamente.'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Usuário atualizado com sucesso.'),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ),
                            );
                            await clientesController.listarClientes(context);
                            context.go('/cadastro-search-cliente');
                          }
                        } else {
                          var params = <String, dynamic>{};

                          // Formatação da data de nascimento (dd/MM/yyyy -> yyyy-MM-dd)
                          var formattedDate = birthDateController.text.split('/').reversed.join('-');

                          // Remoção de máscaras do CPF (deixa apenas números)
                          var formattedCpf = cpfController.text.replaceAll(RegExp(r'\D'), '');

                          params["nome"] = nomeController.text;
                          params["dataNascimento"] = formattedDate;
                          params["telefone"] = phoneController.text;
                          params["rg"] = rgController.text;
                          params["cpf"] = formattedCpf;
                          params["profissao"] = profissaoController.text;
                          params["endereco"] = enderecoController.text;

                          await clientesController.adicionarClientes(context, params);
                          if (clientesController.isError.isTrue) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Não foi possivel adicionar o usuário, por favor, tente novamente.'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Usuário adicionado com sucesso.'),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ),
                            );
                            await clientesController.listarClientes(context);
                            context.go('/cadastro-search-cliente');
                          }
                        }
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Por favor, preencha todos os campos do cadastro de cliente.',
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
                    child: clientesController.clientesSelecionado != null && clientesController.clientesSelecionado != "" ? const Text('Atualizar') : const Text('Salvar'),
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
                      context.go('/cadastro-search-cliente');
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
    );
  }
}

