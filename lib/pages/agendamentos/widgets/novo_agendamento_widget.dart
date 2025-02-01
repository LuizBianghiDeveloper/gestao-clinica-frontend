import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../controllers/agendamento_controller.dart';
import '../../../controllers/app_controller.dart';
import '../../../controllers/clientes_controller.dart';
import '../../../controllers/procedimentos_controller.dart';
import '../../../controllers/profissional_controller.dart';
import '../../../controllers/salas_controller.dart';
import '../../../responsive.dart';
import '../../../shared/constants/defaults.dart';
import '../../../shared/constants/ghaps.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../theme/app_colors.dart';

class Agendamento {
  final String descricao;
  final String profissional;
  final String sala;
  final Color cor;

  Agendamento({
    required this.descricao,
    required this.profissional,
    required this.sala,
    required this.cor,
  });
}

class NovoAgendamentoWidget extends StatefulWidget {
  const NovoAgendamentoWidget({super.key});

  @override
  State<NovoAgendamentoWidget> createState() => _NovoAgendamentoWidgetState();
}

class _NovoAgendamentoWidgetState extends State<NovoAgendamentoWidget> {
  final formKey = GlobalKey<FormState>();
  final List<String> _recorrenciaOpcoes = [
    'Uma vez',
    'Diariamente',
    'Semanalmente',
    'Mensalmente'
  ];

  final ClientesController clientesController = Get.find<ClientesController>();
  final ProfissionalController profissionalController =
      Get.find<ProfissionalController>();
  final ProcedimentosController procedimentosController =
      Get.find<ProcedimentosController>();
  final SalasController salasController = Get.find<SalasController>();
  final AgendamentoController agendamentoController =
      Get.find<AgendamentoController>();
  String? _selectedCliente;
  String? _selectedClienteId;
  String? _selectedProcedimento;
  String? _selectedProcedimentoId;
  String? _selectedSala;
  String? _selectedSalaId;
  String? _selectedProfissional;
  String? _selectedProfissionalId;
  String? _selectedRecorrencia;
  final phoneController = MaskedTextController(mask: '(00) 00000-0000');
  final birthDateController = MaskedTextController(mask: '00/00/0000');
  final cpfController = MaskedTextController(mask: '000.000.000-00');
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController rgController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController observacaoController = TextEditingController();
  String? _selectedHorarioInicio;
  String? _selectedHorarioFim;
  final List<String> _horariosDisponiveis = [];
  final List<String> _horariosDisponiveisFim = [];
  DateTime? _selectedDate;
  late final List<dynamic> dataList;
  late final List<dynamic> dataListProcedimento;
  late final List<dynamic> dataListProfissional;
  late final List<dynamic> dataListSala;
  List<dynamic> clientes = [];
  List<dynamic> procedimento = [];
  List<dynamic> profissional = [];
  List<dynamic> sala = [];

  @override
  void initState() {
    super.initState();
    final dynamic decodedJson = jsonDecode(clientesController.clientes);
    final dynamic decodedJsonProcedimento =
        jsonDecode(procedimentosController.procedimentos);
    final dynamic decodedJsonProfissional =
        jsonDecode(profissionalController.profissional);
    final dynamic decodedJsonSala = jsonDecode(salasController.sala);
    dataList = decodedJson['data'];
    dataListProcedimento = decodedJsonProcedimento['data'];
    dataListProfissional = decodedJsonProfissional['data'];
    dataListSala = decodedJsonSala['data'];
    clientes = dataList;
    procedimento = dataListProcedimento;
    profissional = dataListProfissional;
    sala = dataListSala;
    _gerarHorarios();
  }

  void _gerarHorarios() {
    DateTime inicio = DateTime(2024, 1, 1, 7, 0);
    DateTime fim = DateTime(2024, 1, 1, 21, 30);

    while (inicio.isBefore(fim)) {
      _horariosDisponiveis.add(DateFormat('HH:mm').format(inicio));
      inicio = inicio.add(const Duration(minutes: 30));
    }
  }

  void _atualizarHorariosFim() {
    _horariosDisponiveisFim.clear();
    if (_selectedHorarioInicio != null) {
      final DateTime horarioInicio =
          DateFormat('HH:mm').parse(_selectedHorarioInicio!);
      for (String horario in _horariosDisponiveis) {
        final DateTime horarioAtual = DateFormat('HH:mm').parse(horario);
        if (horarioAtual.isAfter(horarioInicio)) {
          _horariosDisponiveisFim.add(horario);
        }
      }
    }
  }

  Future<void> _showDatePickerDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        final size = MediaQuery.of(context).size;
        return AlertDialog(
          title: const Text('Selecione a Data'),
          backgroundColor: Colors.white,
          // Define o fundo do AlertDialog como branco
          content: SizedBox(
            height: size.height * 0.5,
            width: size.width * 0.6,
            child: TableCalendar(
              focusedDay: _selectedDate ?? DateTime.now(),
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(const Duration(days: 365)),
              locale: 'pt_BR',
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                  _dataController.text =
                      DateFormat('dd/MM/yyyy').format(selectedDay);
                });
                Navigator.pop(context);
              },
              selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
              calendarFormat: CalendarFormat.month,
              headerStyle: HeaderStyle(
                titleTextFormatter: (date, locale) =>
                    DateFormat('MMMM yyyy', locale).format(date),
                formatButtonVisible: false,
              ),
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.pink,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: TextStyle(color: Colors.pink),
                selectedTextStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
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
              SectionTitle(title: "Dados do Agendamento"),
              Spacer(),
            ],
          ),
          gapH24,
          Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return clientes
                    .map((clientes) => clientes['nome'].toString())
                    .take(999);
              }
              return clientes
                  .where((clientes) => clientes['nome']
                      .toString()
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()))
                  .map((clientes) => clientes['nome'].toString());
            },
            onSelected: (String selectedCliente) {
              setState(() {
                _selectedCliente = selectedCliente;
                _selectedClienteId = clientes
                    .firstWhere(
                      (cliente) => cliente['nome'] == selectedCliente,
                      orElse: () => null, // Evita erro se não encontrar
                    )?['idPaciente']
                    ?.toString();
              });
              print("Cliente Selecionado: $_selectedCliente");
              print("ID do Cliente: $_selectedClienteId");
            },
            fieldViewBuilder: (BuildContext context,
                TextEditingController fieldTextEditingController,
                FocusNode fieldFocusNode,
                VoidCallback onFieldSubmitted) {
              return TextFormField(
                controller: fieldTextEditingController,
                focusNode: fieldFocusNode,
                decoration: const InputDecoration(
                  labelText: 'Selecione o Cliente',
                  border: OutlineInputBorder(),
                ),
                onTap: () {
                  if (!fieldFocusNode.hasFocus) fieldFocusNode.requestFocus();
                },
              );
            },
          ),
          gapH16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return profissional
                          .map(
                              (profissional) => profissional['nome'].toString())
                          .take(999);
                    }
                    return profissional
                        .where((profissional) => profissional['nome']
                            .toString()
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()))
                        .map((profissional) => profissional['nome'].toString());
                  },
                  onSelected: (String selectedProfissional) {
                    setState(() {
                      _selectedProfissional = selectedProfissional;
                      _selectedProfissionalId = profissional
                          .firstWhere(
                            (profissional) => profissional['nome'] == selectedProfissional,
                        orElse: () => null, // Evita erro se não encontrar
                      )?['idProfissional']
                          ?.toString();
                    });
                  },
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController fieldTextEditingController,
                      FocusNode fieldFocusNode,
                      VoidCallback onFieldSubmitted) {
                    return TextFormField(
                      controller: fieldTextEditingController,
                      focusNode: fieldFocusNode,
                      decoration: const InputDecoration(
                        labelText: 'Selecione o profissional',
                        border: OutlineInputBorder(),
                      ),
                      onTap: () {
                        if (!fieldFocusNode.hasFocus)
                          fieldFocusNode.requestFocus();
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return sala
                          .map((sala) => sala['numero'].toString())
                          .take(999);
                    }
                    return sala
                        .where((sala) => sala['numero']
                            .toString()
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()))
                        .map((sala) => sala['numero'].toString());
                  },
                  onSelected: (String selectedSala) {
                    setState(() {
                      _selectedSala = selectedSala;
                      _selectedSalaId = sala
                          .firstWhere(
                            (sala) => sala['numero'] == selectedSala,
                        orElse: () => null,
                      )?['idSala']
                          ?.toString();
                    });
                  },
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController fieldTextEditingController,
                      FocusNode fieldFocusNode,
                      VoidCallback onFieldSubmitted) {
                    return TextFormField(
                      controller: fieldTextEditingController,
                      focusNode: fieldFocusNode,
                      decoration: const InputDecoration(
                        labelText: 'Selecione a sala',
                        border: OutlineInputBorder(),
                      ),
                      onTap: () {
                        if (!fieldFocusNode.hasFocus)
                          fieldFocusNode.requestFocus();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          gapH16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return procedimento
                          .map(
                              (procedimento) => procedimento['nome'].toString())
                          .take(999);
                    }
                    return procedimento
                        .where((procedimento) => procedimento['nome']
                            .toString()
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()))
                        .map((procedimento) => procedimento['nome'].toString());
                  },
                  onSelected: (String selectedProcedimento) {
                    setState(() {
                      _selectedProcedimento = selectedProcedimento;
                      _selectedProcedimentoId = procedimento
                          .firstWhere(
                            (procedimento) => procedimento['nome'] == selectedProcedimento,
                        orElse: () => null,
                      )?['idProcedimento']
                          ?.toString();
                    });
                  },
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController fieldTextEditingController,
                      FocusNode fieldFocusNode,
                      VoidCallback onFieldSubmitted) {
                    return TextFormField(
                      controller: fieldTextEditingController,
                      focusNode: fieldFocusNode,
                      decoration: const InputDecoration(
                        labelText: 'Selecione o Procedimento',
                        border: OutlineInputBorder(),
                      ),
                      onTap: () {
                        if (!fieldFocusNode.hasFocus)
                          fieldFocusNode.requestFocus();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          gapH24,
          const Row(
            children: [
              SectionTitle(title: "Horário do Agendamento"),
            ],
          ),
          gapH16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _dataController,
                  decoration: const InputDecoration(
                    labelText: 'Data',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: _showDatePickerDialog,
                ),
              ),
            ],
          ),
          gapH24,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedHorarioInicio,
                  decoration: const InputDecoration(
                    labelText: 'Horário Início',
                    border: OutlineInputBorder(),
                  ),
                  items: _horariosDisponiveis
                      .map<DropdownMenuItem<String>>((String horario) {
                    return DropdownMenuItem<String>(
                      value: horario,
                      child: Text(horario),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedHorarioInicio = value;
                      _atualizarHorariosFim(); // Atualiza os horários de fim
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Horário de Início é obrigatório' : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedHorarioFim,
                  decoration: const InputDecoration(
                    labelText: 'Horário Fim',
                    border: OutlineInputBorder(),
                  ),
                  items: _horariosDisponiveisFim
                      .map<DropdownMenuItem<String>>((String horario) {
                    return DropdownMenuItem<String>(
                      value: horario,
                      child: Text(horario),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedHorarioFim = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Horário de Fim é obrigatório' : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedRecorrencia,
                  decoration: const InputDecoration(
                    labelText: 'Recorrência',
                    border: OutlineInputBorder(),
                  ),
                  items: _recorrenciaOpcoes.map((String opcao) {
                    return DropdownMenuItem<String>(
                      value: opcao,
                      child: Text(opcao),
                    );
                  }).toList(),
                  onChanged: (String? novaOpcao) {
                    setState(() {
                      _selectedRecorrencia = novaOpcao;
                    });
                  },
                ),
              ),
            ],
          ),
          gapH16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  controller: observacaoController,
                  decoration: const InputDecoration(
                    labelText: 'Observações',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          gapH24,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    var params = <String, dynamic>{};
                    final DateFormat formatter = DateFormat('yyyy-MM-dd'); // Define o formato desejado
                    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(_dataController.text);
                    params["dataAgendamento"] = formatter.format(parsedDate);
                    params["horarioInicio"] = _selectedHorarioInicio;
                    params["horarioFim"] = _selectedHorarioFim;
                    params["recorrencia"] = _selectedRecorrencia;
                    params["observacoes"] = observacaoController.text;

                    await agendamentoController.adicionarAgendamento(
                        context, params, _selectedClienteId!, _selectedProfissionalId!, _selectedProcedimentoId!, _selectedSalaId!);
                    if (agendamentoController.isError.isTrue) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Não foi possivel adicionar o agendamento, por favor, tente novamente.'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Agendamento adicionado com sucesso.'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      final String dataAtual =
                          DateFormat('yyyy-MM-dd').format(DateTime.now());
                      await agendamentoController.listarAgendamentoDia(
                          context, dataAtual);
                      context.go('/agendamento');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text('Salvar'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/agendamento');
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
            ],
          ),
        ],
      ),
    );
  }
}
