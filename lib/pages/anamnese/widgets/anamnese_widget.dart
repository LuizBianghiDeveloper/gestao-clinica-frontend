import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

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
              SectionTitle(title: "Dados Pessoais:"),
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

                    // Campo Data de Nascimento
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

                    // Campo Profissão
                    Expanded(
                      flex: 4,
                      child: TextFormField(
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

    Expanded( // Use Expanded para que o texto ocupe o espaço disponível
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, // Alinha o texto à esquerda
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

    Expanded( // Use Expanded para que o texto ocupe o espaço disponível
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, // Alinha o texto à esquerda
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

    Expanded( // Use Expanded para que o texto ocupe o espaço disponível
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, // Alinha o texto à esquerda
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

    Expanded( // Use Expanded para que o texto ocupe o espaço disponível
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, // Alinha o texto à esquerda
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

    Expanded( // Use Expanded para que o texto ocupe o espaço disponível
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, // Alinha o texto à esquerda
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

    Expanded( // Use Expanded para que o texto ocupe o espaço disponível
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, // Alinha o texto à esquerda
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

    Expanded( // Use Expanded para que o texto ocupe o espaço disponível
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, // Alinha o texto à esquerda
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
                      Expanded( // Use Expanded para que o texto ocupe o espaço disponível
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Alinha o texto à esquerda
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
                    crossAxisAlignment: WrapCrossAlignment.center, // Alinha os filhos no centro verticalmente
                    spacing: 16.0, // Espaçamento horizontal entre os filhos
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
                    onPressed: () {
                      if (formKey.currentState?.validate() == true &&
                          formKeyQueixa.currentState?.validate() == true &&
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
                        // Processar dados se válidos
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
                    child: const Text('Salvar'),
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
