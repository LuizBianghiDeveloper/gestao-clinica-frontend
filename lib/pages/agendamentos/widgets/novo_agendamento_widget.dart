import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

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
    'Uma vez', 'Diariamente', 'Semanalmente', 'Mensalmente'
  ];
  final List<String> _clientes = [
    'Ana Paula Silva', 'Bruno Mendes Oliveira', 'Carlos Alberto Souza',
    'Diana Costa Pereira', 'Eduardo Gomes Ferreira', 'Fernanda Lima Santos',
    'Gabriel Rocha Lima', 'Helena Martins Alves', 'Igor Henrique Dias',
    'Júlia de Souza Almeida', 'Karla Cristina Lima', 'Leonardo da Silva Santos',
    'Mariana Oliveira Costa', 'Natália Mendes Nascimento', 'Otávio Augusto Lima',
    'Paula Regina Cardoso', 'Quiteria de Almeida Oliveira', 'Ricardo Carvalho Pinto',
    'Sofia Regina Ferreira', 'Thiago Fernandes da Costa', 'Ulisses Martins de Oliveira',
    'Vanessa Silva Freitas', 'William Figueiredo Santos', 'Xuxa de Almeida',
    'Yasmin Rodrigues da Silva',
  ];

  final List<String> _sala = [
    'Sala 1', 'Sala 2', 'Sala 3', 'Sala 4'
  ];

  final List<String> _profissional = [
    'Ana Romani', 'Thais Melo', 'Michelle'
  ];

  final List<String> _procedimentos = [
    'Botox', 'Preenchimento Labial', 'Limpeza de Pele', 'Peeling Químico',
    'Depilação a Laser', 'Tratamento para Acne', 'Rinomodelação',
    'Microagulhamento', 'Lifting Facial', 'Tratamento de Melasma',
    'Harmonização Facial', 'Escleroterapia', 'Carboxiterapia', 'Criolipólise',
    'Drenagem Linfática', 'Laser Fracionado', 'Peeling de Diamante',
    'Massagem Modeladora', 'Radiofrequência', 'Aplicação de Fios de Sustentação',
  ];

  String? _selectedCliente;
  String? _selectedProcedimento;
  String? _selectedSala;
  String? _selectedProfissional;
  String? _selectedRecorrencia;
  final phoneController = MaskedTextController(mask: '(00) 00000-0000');
  final birthDateController = MaskedTextController(mask: '00/00/0000');
  final cpfController = MaskedTextController(mask: '000.000.000-00');
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController rgController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  String? _selectedHorarioInicio;
  String? _selectedHorarioFim;
  final List<String> _horariosDisponiveis = [];
  final List<String> _horariosDisponiveisFim = [];
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
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
      final DateTime horarioInicio = DateFormat('HH:mm').parse(_selectedHorarioInicio!);
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
                  _dataController.text = DateFormat('dd/MM/yyyy').format(selectedDay);
                });
                Navigator.pop(context);
              },
              selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
              calendarFormat: CalendarFormat.month,
              headerStyle: HeaderStyle(
                titleTextFormatter: (date, locale) => DateFormat('MMMM yyyy', locale).format(date),
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
              if (textEditingValue.text.isEmpty) return _clientes.take(999);
              return _clientes.where((String cliente) {
                return cliente.toLowerCase().contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (String selectedCliente) {
              setState(() {
                _selectedCliente = selectedCliente;
              });
            },
            fieldViewBuilder: (BuildContext context, TextEditingController fieldTextEditingController, FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
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
                    if (textEditingValue.text.isEmpty) return _profissional.take(999);
                    return _profissional.where((String profissional) {
                      return profissional.toLowerCase().contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  onSelected: (String selectedProfissional) {
                    setState(() {
                      _selectedProfissional = selectedProfissional;
                    });
                  },
                  fieldViewBuilder: (BuildContext context, TextEditingController fieldTextEditingController, FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
                    return TextFormField(
                      controller: fieldTextEditingController,
                      focusNode: fieldFocusNode,
                      decoration: const InputDecoration(
                        labelText: 'Selecione o profissional',
                        border: OutlineInputBorder(),
                      ),
                      onTap: () {
                        if (!fieldFocusNode.hasFocus) fieldFocusNode.requestFocus();
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) return _sala.take(999);
                    return _sala.where((String sala) {
                      return sala.toLowerCase().contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  onSelected: (String selectedSala) {
                    setState(() {
                      _selectedSala = selectedSala;
                    });
                  },
                  fieldViewBuilder: (BuildContext context, TextEditingController fieldTextEditingController, FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
                    return TextFormField(
                      controller: fieldTextEditingController,
                      focusNode: fieldFocusNode,
                      decoration: const InputDecoration(
                        labelText: 'Selecione a sala',
                        border: OutlineInputBorder(),
                      ),
                      onTap: () {
                        if (!fieldFocusNode.hasFocus) fieldFocusNode.requestFocus();
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
                    if (textEditingValue.text.isEmpty) return _procedimentos.take(999);
                    return _procedimentos.where((String procedimento) {
                      return procedimento.toLowerCase().contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  onSelected: (String selectedProcedimento) {
                    setState(() {
                      _selectedProcedimento = selectedProcedimento;
                    });
                  },
                  fieldViewBuilder: (BuildContext context, TextEditingController fieldTextEditingController, FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
                    return TextFormField(
                      controller: fieldTextEditingController,
                      focusNode: fieldFocusNode,
                      decoration: const InputDecoration(
                        labelText: 'Selecione o Procedimento',
                        border: OutlineInputBorder(),
                      ),
                      onTap: () {
                        if (!fieldFocusNode.hasFocus) fieldFocusNode.requestFocus();
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
                  items: _horariosDisponiveis.map<DropdownMenuItem<String>>((String horario) {
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
                  validator: (value) => value == null ? 'Horário de Início é obrigatório' : null,
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
                  items: _horariosDisponiveisFim.map<DropdownMenuItem<String>>((String horario) {
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
                  validator: (value) => value == null ? 'Horário de Fim é obrigatório' : null,
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
                  controller: TextEditingController(),
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
                  onPressed: () {

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
