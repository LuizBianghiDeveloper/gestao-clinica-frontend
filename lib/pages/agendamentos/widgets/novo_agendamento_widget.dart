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
  final phoneController = MaskedTextController(mask: '(00) 00000-0000');
  final birthDateController = MaskedTextController(mask: '00/00/0000');
  final cpfController = MaskedTextController(mask: '000.000.000-00');
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController rgController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  String? _selectedHorario;
  final List<String> _horariosDisponiveis = [];

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
          // Campo de Seleção de Cliente
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
                child: TextFormField(
                  controller: _dataController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Data do Agendamento',
                    border: OutlineInputBorder(),
                  ),
                  onTap: _showDatePickerDialog,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedHorario,
                  items: _horariosDisponiveis.map((String horario) {
                    return DropdownMenuItem(
                      value: horario,
                      child: Text(horario),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedHorario = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Horário do Agendamento',
                    border: OutlineInputBorder(),
                  ),
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
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: TextEditingController(),
                  decoration: const InputDecoration(
                    labelText: 'Selecione o Profissional',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: TextEditingController(),
                  decoration: const InputDecoration(
                    labelText: 'Selecione a Sala',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          gapH24,
          // Botões de Salvar e Cancelar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() == true) {
                      // Lógica para salvar os dados
                    } else {
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
                  child: const Text('Salvar'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Lógica de cancelamento
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
