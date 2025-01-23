import 'dart:convert';

import 'package:core_dashboard/controllers/clientes_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../controllers/anamnese_controller.dart';
import '../../../shared/constants/defaults.dart';
import '../../../shared/constants/ghaps.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../theme/app_colors.dart';

class AnamneseWidget extends StatefulWidget {
  const AnamneseWidget({super.key});

  @override
  State<AnamneseWidget> createState() => _AnamneseWidgetState();
}

class _AnamneseWidgetState extends State<AnamneseWidget> {
  String? _tabagismo = '';
  String? _etilista = '';
  String? _hipertensao = '';
  String? _diabetes = '';
  String? _marcapasso = '';
  String? _implantemetalico = '';
  String? _gestante = '';
  String? _lactante = '';
  String? _cicatrizacao = '';
  String? _filhos = '';
  String? _hipotireoidismo = '';
  String? _hipertireoidismo = '';
  String? _vitaminaC = '';
  String? _anticoagulante = '';
  String? _deficiencia = '';
  String? _divulgacao = '';
  final formKey = GlobalKey<FormState>();
  final formKeyQueixa = GlobalKey<FormState>();
  final formKeyHistorico = GlobalKey<FormState>();
  final AnamneseController anamneseController = Get.find<AnamneseController>();
  final ClientesController clientesController = Get.find<ClientesController>();
  final phoneController = MaskedTextController(mask: '(00) 00000-0000');
  final birthDateController = MaskedTextController(mask: '00/00/0000');
  final cpfController = MaskedTextController(mask: '000.000.000-00');
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController rgController = TextEditingController();
  final TextEditingController queixaController = TextEditingController();
  final TextEditingController planoTratamentoController =
      TextEditingController();
  final TextEditingController observacaoController = TextEditingController();
  final TextEditingController historicoEsteticoController =
      TextEditingController();
  final TextEditingController historicoCirurgicoController =
      TextEditingController();
  final TextEditingController antecedentesController = TextEditingController();
  final TextEditingController disturbioController = TextEditingController();
  final TextEditingController tratamentoMedicoController =
      TextEditingController();
  final TextEditingController alergiaController = TextEditingController();
  final TextEditingController frequenciaController = TextEditingController();
  final TextEditingController atividadeFisicaController =
      TextEditingController();
  final TextEditingController ingestaoLiquidosController =
      TextEditingController();
  final TextEditingController alimentacaoController = TextEditingController();
  final TextEditingController exposicaoSolController = TextEditingController();
  final TextEditingController qualidadeSonoController = TextEditingController();
  final TextEditingController intestinoController = TextEditingController();
  late Map<String, dynamic> jsonData;
  String? selectedProfissional;
  late final List<dynamic> dataList;
  List<dynamic> clientes = [];

  @override
  void initState() {
    super.initState();
    final dynamic decodedJson = jsonDecode(clientesController.clientes);
    dataList = decodedJson['data'];
    clientes = dataList;
    if (anamneseController.anamnese != null) {
      final anamnese = anamneseController.anamnese;
      jsonData = jsonDecode(anamnese);

      queixaController.text = jsonData['data'][0]['queixaPrinciapal'] ?? '';
      intestinoController.text = jsonData['data'][0]['intestino'] ?? '';
      qualidadeSonoController.text = jsonData['data'][0]['qualidadeSono'] ?? '';
      exposicaoSolController.text = jsonData['data'][0]['exposicaoSol'] ?? '';
      alimentacaoController.text = jsonData['data'][0]['alimentacao'] ?? '';
      ingestaoLiquidosController.text =
          jsonData['data'][0]['ingestaoLiquido'] ?? '';
      atividadeFisicaController.text =
          jsonData['data'][0]['atividadeFisica'] ?? '';
      frequenciaController.text = jsonData['data'][0]['frequencia'] ?? '';
      _gestante = jsonData['data'][0]['gestante'] == true ? 'Sim' : 'Não' ?? '';
      _tabagismo =
          jsonData['data'][0]['tabagismo'] == true ? 'Sim' : 'Não' ?? '';
      _etilista = jsonData['data'][0]['etilista'] == true ? 'Sim' : 'Não' ?? '';
      _hipertensao =
          jsonData['data'][0]['hipertensao'] == true ? 'Sim' : 'Não' ?? '';
      _diabetes = jsonData['data'][0]['diabetes'] == true ? 'Sim' : 'Não' ?? '';
      _marcapasso =
          jsonData['data'][0]['marcapasso'] == true ? 'Sim' : 'Não' ?? '';
      _implantemetalico =
          jsonData['data'][0]['implantemetalico'] == true ? 'Sim' : 'Não' ?? '';
      _lactante = jsonData['data'][0]['lactante'] == true ? 'Sim' : 'Não' ?? '';
      _filhos = jsonData['data'][0]['filhos'] == true ? 'Sim' : 'Não' ?? '';
      _hipotireoidismo =
          jsonData['data'][0]['hipotireoidismo'] == true ? 'Sim' : 'Não' ?? '';
      _hipertireoidismo =
          jsonData['data'][0]['hipertireoidismo'] == true ? 'Sim' : 'Não' ?? '';
      _vitaminaC =
          jsonData['data'][0]['vitaminaC'] == true ? 'Sim' : 'Não' ?? '';
      _anticoagulante =
          jsonData['data'][0]['anticoagulante'] == true ? 'Sim' : 'Não' ?? '';
      _deficiencia =
          jsonData['data'][0]['deficiencia'] == true ? 'Sim' : 'Não' ?? '';
      _divulgacao =
          jsonData['data'][0]['divulgacao'] == true ? 'Sim' : 'Não' ?? '';
      _cicatrizacao = jsonData['data'][0]['cicatrizacao'] ?? '';
      alergiaController.text = jsonData['data'][0]['alergia'] ?? '';
      tratamentoMedicoController.text =
          jsonData['data'][0]['tratamentoMedico'] ?? '';
      disturbioController.text = jsonData['data'][0]['disturbio'] ?? '';
      antecedentesController.text =
          jsonData['data'][0]['antecedentesOncologicos'] ?? '';
      historicoCirurgicoController.text =
          jsonData['data'][0]['historicoCirurgico'] ?? '';
      historicoEsteticoController.text =
          jsonData['data'][0]['historicoEstetico'] ?? '';
      observacaoController.text = jsonData['data'][0]['observacoes'] ?? '';
      planoTratamentoController.text =
          jsonData['data'][0]['planoTratamento'] ?? '';
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
          anamneseController.anamnese == null
              ? const Row(
                  children: [
                    SectionTitle(title: "Dados Pessoais:"),
                    Spacer(),
                  ],
                )
              : const SizedBox(),
          gapH24,
          anamneseController.anamnese == null
              ? DropdownButtonFormField<String>(
                  value: selectedProfissional,
                  hint: const Text('Selecione o cliente'),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: clientes.map((dynamic clientes) {
                    return DropdownMenuItem<String>(
                      value: clientes.toString(),
                      child: Text(clientes['nome'].toString()),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedProfissional = newValue;
                      String formatJson(String input) {
                        input = input.replaceAllMapped(RegExp(r'(\w+):'), (match) => '"${match.group(1)}":');
                        input = input.replaceAllMapped(
                          RegExp(r':\s*([^\[{",}\]\d\s][^,}]*)'),
                              (match) => ': "${match.group(1)}"',
                        );
                        input = input.replaceAllMapped(
                          RegExp(r':\s*(\d{4}-\d{2}-\d{2})(?=[,\}])'),
                              (match) => ': "${match.group(1)}"',
                        );
                        input = input.replaceAllMapped(
                          RegExp(r':\s*(\d+)(?=[,\}])'),
                              (match) => ': "${match.group(1)}"',
                        );
                        return input;
                      }
                      var usuarioSelecionado = formatJson(selectedProfissional!);
                      clientesController.clientesSelecionado = jsonDecode(usuarioSelecionado);
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor, selecione um profissional responsável';
                    }
                    return null;
                  },
                )
              : Text(
    "Cliente: " + clientesController.clientesSelecionado['nome'],
    style: Theme.of(context)
        .textTheme
        .headlineLarge!
        .copyWith(fontWeight: FontWeight.w200, fontSize: 24),
    ),
          gapH24,
          const Row(
            children: [
              SectionTitle(title: "Queixa Principal:"),
              Spacer(),
            ],
          ),
          gapH24,
          Form(
            key: formKeyQueixa,
            child: Column(
              children: [
                TextFormField(
                  controller: queixaController,
                  decoration: const InputDecoration(
                    labelText: 'Queixa principal',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a queixa do paciente';
                    }
                    return null;
                  },
                ),
                gapH24,
              ],
            ),
          ),
          gapH24,
          const Row(
            children: [
              SectionTitle(title: "Histórico Clínico:"),
              Spacer(),
            ],
          ),
          gapH24,
          Form(
            key: formKeyHistorico,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: intestinoController,
                        decoration: const InputDecoration(
                          labelText: 'Funcionamento do intestino',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o funcionamento do intestino';
                          }
                          return null;
                        },
                      ),
                    ),
                    gapW16,
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: qualidadeSonoController,
                        decoration: const InputDecoration(
                          labelText: 'Qualidade do sono',
                          border: OutlineInputBorder(),
                          hintText: 'Qualidade do sono',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a qualidade do sono';
                          }
                          return null;
                        },
                      ),
                    ),
                    gapW16,
                    Expanded(
                      flex: 4,
                      child: TextFormField(
                        controller: exposicaoSolController,
                        decoration: const InputDecoration(
                          labelText: 'Exposição ao sol',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a exposição ao sol';
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
                        controller: alimentacaoController,
                        decoration: const InputDecoration(
                          labelText: 'Alimentação',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a alimentação';
                          }
                          return null;
                        },
                      ),
                    ),
                    gapW16,
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: ingestaoLiquidosController,
                        decoration: const InputDecoration(
                          labelText: 'Ingestão de líquidos',
                          border: OutlineInputBorder(),
                          hintText: 'Ingestão de líquidos',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a ingestão de líquidos';
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
                        controller: atividadeFisicaController,
                        decoration: const InputDecoration(
                          labelText: 'Atividade física',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a atividade física';
                          }
                          return null;
                        },
                      ),
                    ),
                    gapW16,
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: frequenciaController,
                        decoration: const InputDecoration(
                          labelText: 'Frequência',
                          border: OutlineInputBorder(),
                          hintText: 'Frequência',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a frequência';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                gapH16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tabagismo:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(width: 16),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Sim',
                                  groupValue: _tabagismo,
                                  onChanged: (value) {
                                    setState(() {
                                      _tabagismo = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Sim'),
                                const SizedBox(width: 16),
                                Radio<String>(
                                  value: 'Não',
                                  groupValue: _tabagismo,
                                  onChanged: (value) {
                                    setState(() {
                                      _tabagismo = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Não'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                    ],
                  ),
                ),
                gapH16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Etilista:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(width: 16),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Sim',
                                  groupValue: _etilista,
                                  onChanged: (value) {
                                    setState(() {
                                      _etilista = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Sim'),
                                const SizedBox(width: 16),
                                Radio<String>(
                                  value: 'Não',
                                  groupValue: _etilista,
                                  onChanged: (value) {
                                    setState(() {
                                      _etilista = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Não'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                    ],
                  ),
                ),
                gapH16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hipertensão:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(width: 16),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Sim',
                                  groupValue: _hipertensao,
                                  onChanged: (value) {
                                    setState(() {
                                      _hipertensao = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Sim'),
                                const SizedBox(width: 16),
                                Radio<String>(
                                  value: 'Não',
                                  groupValue: _hipertensao,
                                  onChanged: (value) {
                                    setState(() {
                                      _hipertensao = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Não'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                    ],
                  ),
                ),
                gapH16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Diabetes:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(width: 16),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Sim',
                                  groupValue: _diabetes,
                                  onChanged: (value) {
                                    setState(() {
                                      _diabetes = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Sim'),
                                const SizedBox(width: 16),
                                Radio<String>(
                                  value: 'Não',
                                  groupValue: _diabetes,
                                  onChanged: (value) {
                                    setState(() {
                                      _diabetes = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Não'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                    ],
                  ),
                ),
                gapH16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        // Use Expanded para que o texto ocupe o espaço disponível
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // Alinha o texto à esquerda
                          children: [
                            const Text(
                              'Marca Passo:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(width: 16),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Sim',
                                  groupValue: _marcapasso,
                                  onChanged: (value) {
                                    setState(() {
                                      _marcapasso = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Sim'),
                                const SizedBox(width: 16),
                                Radio<String>(
                                  value: 'Não',
                                  groupValue: _marcapasso,
                                  onChanged: (value) {
                                    setState(() {
                                      _marcapasso = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Não'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                    ],
                  ),
                ),
                gapH16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        // Use Expanded para que o texto ocupe o espaço disponível
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // Alinha o texto à esquerda
                          children: [
                            const Text(
                              'Implante metálico:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(width: 16),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Sim',
                                  groupValue: _implantemetalico,
                                  onChanged: (value) {
                                    setState(() {
                                      _implantemetalico = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Sim'),
                                const SizedBox(width: 16),
                                Radio<String>(
                                  value: 'Não',
                                  groupValue: _implantemetalico,
                                  onChanged: (value) {
                                    setState(() {
                                      _implantemetalico = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Não'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                    ],
                  ),
                ),
                gapH16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        // Use Expanded para que o texto ocupe o espaço disponível
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // Alinha o texto à esquerda
                          children: [
                            const Text(
                              'Gestante:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(width: 16),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Sim',
                                  groupValue: _gestante,
                                  onChanged: (value) {
                                    setState(() {
                                      _gestante = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Sim'),
                                const SizedBox(width: 16),
                                Radio<String>(
                                  value: 'Não',
                                  groupValue: _gestante,
                                  onChanged: (value) {
                                    setState(() {
                                      _gestante = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Não'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                    ],
                  ),
                ),
                gapH16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        // Use Expanded para que o texto ocupe o espaço disponível
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // Alinha o texto à esquerda
                          children: [
                            const Text(
                              'Lactante:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(width: 16),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Sim',
                                  groupValue: _lactante,
                                  onChanged: (value) {
                                    setState(() {
                                      _lactante = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Sim'),
                                const SizedBox(width: 16),
                                Radio<String>(
                                  value: 'Não',
                                  groupValue: _lactante,
                                  onChanged: (value) {
                                    setState(() {
                                      _lactante = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Não'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                    ],
                  ),
                ),
                gapH16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 16.0,
                    children: [
                      const Text(
                        'Cicatrização:',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(width: 16),
                      Wrap(
                        spacing: 16.0, // Espaço entre os botões de rádio
                        children: [
                          Row(
                            children: [
                              Radio<String>(
                                value: 'Normal',
                                groupValue: _cicatrizacao,
                                onChanged: (value) {
                                  setState(() {
                                    _cicatrizacao = value;
                                  });
                                },
                                activeColor: Colors.pink,
                              ),
                              const Text('Normal'),
                            ],
                          ),
                          Row(
                            children: [
                              Radio<String>(
                                value: 'Hipertrofica',
                                groupValue: _cicatrizacao,
                                onChanged: (value) {
                                  setState(() {
                                    _cicatrizacao = value;
                                  });
                                },
                                activeColor: Colors.pink,
                              ),
                              const Text('Hipertrófica'),
                            ],
                          ),
                          Row(
                            children: [
                              Radio<String>(
                                value: 'Queloide',
                                groupValue: _cicatrizacao,
                                onChanged: (value) {
                                  setState(() {
                                    _cicatrizacao = value;
                                  });
                                },
                                activeColor: Colors.pink,
                              ),
                              const Text('Queloide'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                gapH16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        // Use Expanded para que o texto ocupe o espaço disponível
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // Alinha o texto à esquerda
                          children: [
                            const Text(
                              'Filhos:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(width: 16),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Sim',
                                  groupValue: _filhos,
                                  onChanged: (value) {
                                    setState(() {
                                      _filhos = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Sim'),
                                const SizedBox(width: 16),
                                Radio<String>(
                                  value: 'Não',
                                  groupValue: _filhos,
                                  onChanged: (value) {
                                    setState(() {
                                      _filhos = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Não'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                    ],
                  ),
                ),
                gapH16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        // Use Expanded para que o texto ocupe o espaço disponível
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // Alinha o texto à esquerda
                          children: [
                            const Text(
                              'Hipotireoidismo:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(width: 16),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Sim',
                                  groupValue: _hipotireoidismo,
                                  onChanged: (value) {
                                    setState(() {
                                      _hipotireoidismo = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Sim'),
                                const SizedBox(width: 16),
                                Radio<String>(
                                  value: 'Não',
                                  groupValue: _hipotireoidismo,
                                  onChanged: (value) {
                                    setState(() {
                                      _hipotireoidismo = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Não'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                    ],
                  ),
                ),
                gapH16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        // Use Expanded para que o texto ocupe o espaço disponível
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // Alinha o texto à esquerda
                          children: [
                            const Text(
                              'Hipertireoidismo:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(width: 16),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Sim',
                                  groupValue: _hipertireoidismo,
                                  onChanged: (value) {
                                    setState(() {
                                      _hipertireoidismo = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Sim'),
                                const SizedBox(width: 16),
                                Radio<String>(
                                  value: 'Não',
                                  groupValue: _hipertireoidismo,
                                  onChanged: (value) {
                                    setState(() {
                                      _hipertireoidismo = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Não'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                    ],
                  ),
                ),
                gapH16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // Alinha o texto à esquerda
                          children: [
                            const Text(
                              'Uso de vitamina C:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Sim',
                                  groupValue: _vitaminaC,
                                  onChanged: (value) {
                                    setState(() {
                                      _vitaminaC = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Sim'),
                                const SizedBox(width: 16),
                                Radio<String>(
                                  value: 'Não',
                                  groupValue: _vitaminaC,
                                  onChanged: (value) {
                                    setState(() {
                                      _vitaminaC = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Não'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                    ],
                  ),
                ),
                gapH16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        // Use Expanded para que o texto ocupe o espaço disponível
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // Alinha o texto à esquerda
                          children: [
                            const Text(
                              'Uso de antiacoagulantes:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(width: 16),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Sim',
                                  groupValue: _anticoagulante,
                                  onChanged: (value) {
                                    setState(() {
                                      _anticoagulante = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Sim'),
                                const SizedBox(width: 16),
                                Radio<String>(
                                  value: 'Não',
                                  groupValue: _anticoagulante,
                                  onChanged: (value) {
                                    setState(() {
                                      _anticoagulante = value;
                                    });
                                  },
                                  activeColor: Colors.pink,
                                ),
                                const Text('Não'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                    ],
                  ),
                ),
                gapH16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    // Alinha os filhos no centro verticalmente
                    spacing: 16.0,
                    // Espaçamento horizontal entre os filhos
                    children: [
                      const Text(
                        'Portador de deficiência grave de enzima glicose 6 fosfato desidrogenase GP6D:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Sim',
                            groupValue: _deficiencia,
                            onChanged: (value) {
                              setState(() {
                                _deficiencia = value;
                              });
                            },
                            activeColor: Colors.pink,
                          ),
                          const Text('Sim'),
                          const SizedBox(width: 16),
                          Radio<String>(
                            value: 'Não',
                            groupValue: _deficiencia,
                            onChanged: (value) {
                              setState(() {
                                _deficiencia = value;
                              });
                            },
                            activeColor: Colors.pink,
                          ),
                          const Text('Não'),
                        ],
                      ),
                    ],
                  ),
                ),
                gapH16,
                TextFormField(
                  controller: alergiaController,
                  decoration: const InputDecoration(
                    labelText: 'Alergia',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a alegia';
                    }
                    return null;
                  },
                ),
                gapH16,
                TextFormField(
                  controller: tratamentoMedicoController,
                  decoration: const InputDecoration(
                    labelText: 'Tratamento médico',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o tratamento médico';
                    }
                    return null;
                  },
                ),
                gapH16,
                TextFormField(
                  controller: disturbioController,
                  decoration: const InputDecoration(
                    labelText:
                        'Distúrbio (respiratórios, circulatórios, gastrointestinal, hepático, neurológico, hormonal, renal):',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira os disturbios.';
                    }
                    return null;
                  },
                ),
                gapH16,
                TextFormField(
                  controller: antecedentesController,
                  decoration: const InputDecoration(
                    labelText: 'Antecedentes oncológicos:',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira os antecedentes oncológicos.';
                    }
                    return null;
                  },
                ),
                gapH16,
                TextFormField(
                  controller: historicoCirurgicoController,
                  decoration: const InputDecoration(
                    labelText: 'Histórico cirurgico:',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o histórico cirurgico.';
                    }
                    return null;
                  },
                ),
                gapH16,
                TextFormField(
                  controller: historicoEsteticoController,
                  decoration: const InputDecoration(
                    labelText: 'Histórico estético:',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o histórico estético.';
                    }
                    return null;
                  },
                ),
                gapH16,
                TextFormField(
                  controller: observacaoController,
                  decoration: const InputDecoration(
                    labelText: 'Observações:',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira as observações.';
                    }
                    return null;
                  },
                ),
                gapH16,
                TextFormField(
                  controller: planoTratamentoController,
                  decoration: const InputDecoration(
                    labelText: 'Plano de tratamento:',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o plano de tratamento.';
                    }
                    return null;
                  },
                ),
                gapH16,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(
                    children: [
                      Text(
                        'Declaro que todas as informações acima são verdadeiras, não cabendo a profissional a responsabilidade por informações omitidas.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                gapH16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(
                    spacing: 16.0, // Espaçamento entre os filhos do Wrap
                    children: [
                      const Text(
                        'Autorizo o profissional o uso de imagem (divulgação, estudos, pesquisas):',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Sim',
                            groupValue: _divulgacao,
                            onChanged: (value) {
                              setState(() {
                                _divulgacao = value;
                              });
                            },
                            activeColor: Colors.pink,
                          ),
                          const Text('Sim'),
                          const SizedBox(width: 16),
                          Radio<String>(
                            value: 'Não',
                            groupValue: _divulgacao,
                            onChanged: (value) {
                              setState(() {
                                _divulgacao = value;
                              });
                            },
                            activeColor: Colors.pink,
                          ),
                          const Text('Não'),
                        ],
                      ),
                    ],
                  ),
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
                      if (formKeyQueixa.currentState?.validate() == true &&
                          formKeyHistorico.currentState?.validate() == true &&
                          _tabagismo != "" &&
                          _etilista != "" &&
                          _hipertensao != "" &&
                          _diabetes != "" &&
                          _marcapasso != "" &&
                          _implantemetalico != "" &&
                          _gestante != "" &&
                          _lactante != "" &&
                          _cicatrizacao != "" &&
                          _filhos != "" &&
                          _hipotireoidismo != "" &&
                          _hipertireoidismo != "" &&
                          _vitaminaC != "" &&
                          _anticoagulante != "" &&
                          _deficiencia != "" &&
                          _divulgacao != "") {
                        var params = <String, dynamic>{};

                        params["queixaPrinciapal"] = queixaController.text;
                        params["intestino"] = intestinoController.text;
                        params["qualidadeSono"] = qualidadeSonoController.text;
                        params["exposicaoSol"] = exposicaoSolController.text;
                        params["alimentacao"] = alimentacaoController.text;
                        params["ingestaoLiquido"] =
                            ingestaoLiquidosController.text;
                        params["atividadeFisica"] =
                            atividadeFisicaController.text;
                        params["frequencia"] = frequenciaController.text;
                        params["tabagismo"] =
                            _tabagismo == "Sim" ? true : false;
                        params["etilista"] = _etilista == "Sim" ? true : false;
                        params["hipertensao"] =
                            _hipertensao == "Sim" ? true : false;
                        params["diabetes"] = _diabetes == "Sim" ? true : false;
                        params["marcaPasso"] =
                            _marcapasso == "Sim" ? true : false;
                        params["implanteMetalico"] =
                            _implantemetalico == "Sim" ? true : false;
                        params["gestante"] = _gestante == "Sim" ? true : false;
                        params["lactante"] = _lactante == "Sim" ? true : false;
                        params["cicatrizacao"] = _cicatrizacao;
                        params["filhos"] = _filhos == "Sim" ? true : false;
                        params["hipotireoidismo"] =
                            _hipotireoidismo == "Sim" ? true : false;
                        params["hipertireoidismo"] =
                            _hipertireoidismo == "Sim" ? true : false;
                        params["vitaminaC"] =
                            _vitaminaC == "Sim" ? true : false;
                        params["anticoagulantes"] =
                            _anticoagulante == "Sim" ? true : false;
                        params["deficienciaGrave"] =
                            _deficiencia == "Sim" ? true : false;
                        params["usoImagem"] =
                            _divulgacao == "Sim" ? true : false;
                        params["alergia"] = alergiaController.text;
                        params["tratamentoMedico"] =
                            tratamentoMedicoController.text;
                        params["disturbio"] = disturbioController.text;
                        params["antecedentesOncologicos"] =
                            antecedentesController.text;
                        params["historicoCirurgico"] =
                            historicoCirurgicoController.text;
                        params["historicoEstetico"] =
                            historicoEsteticoController.text;
                        params["observacoes"] = observacaoController.text;
                        params["planoTratamento"] =
                            planoTratamentoController.text;
                        params["paciente"] = {
                          "id": int.parse(clientesController.clientesSelecionado['idPaciente'].toString())
                        };

                        anamneseController.anamnese == null
                            ? await anamneseController.adicionarAnamnese(
                                context,
                                params,
                            int.parse(clientesController.clientesSelecionado['idPaciente'].toString()))
                            : await anamneseController.atualizarAnamnese(
                                context, params, jsonData['data'][0]['id']);
                        if (clientesController.isError.isTrue) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Não foi possivel adicionar a anamnese, por favor, tente novamente.'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Anamnese atualizada com sucesso.'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          context.go('/');
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Por favor, preencha todos os campos da Ficha de Anamnese.',
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
                    child: anamneseController.anamnese != null
                        ? const Text('Atualizar')
                        : const Text('Salvar'),
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
                      context.go('/');
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
