import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart'; // Import da máscara
import 'package:intl/intl.dart'; // Import para formatação de data

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

  String? selectedProfissional;

  final List<String> profissionais = [
    'Ana Romani',
    'Thais Melo',
    'Fernanda Costa',
    'Pedro Costa',
  ];

  @override
  void initState() {
    super.initState();
    // Define a data atual no formato DD/MM/AAAA
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    dataController.text = formattedDate; // Preenche o campo de data com a data atual
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
                  // Campo de data com máscara
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
                  // Campo de descrição da evolução
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
                    items: profissionais.map((String profissional) {
                      return DropdownMenuItem<String>(
                        value: profissional,
                        child: Text(profissional),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedProfissional = newValue;
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
                      onPressed: () {
                        if (formKey.currentState?.validate() == true) {
                          // Lógica para salvar a evolução
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
                          // Limpar os campos após o cadastro
                          descricaoController.clear();
                          selectedProfissional = null; // Reseta a seleção do Dropdown
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
}
