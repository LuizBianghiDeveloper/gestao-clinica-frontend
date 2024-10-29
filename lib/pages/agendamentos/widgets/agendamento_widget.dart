import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart'; // Para formatar a data
import 'package:go_router/go_router.dart';

import '../../../responsive.dart';
import '../../../shared/constants/defaults.dart';
import '../../../shared/constants/ghaps.dart';
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

class AgendamentoWidget extends StatefulWidget {
  const AgendamentoWidget({super.key});

  @override
  State<AgendamentoWidget> createState() => _AgendamentoWidgetState();
}

class _AgendamentoWidgetState extends State<AgendamentoWidget> {
  List<String> allHorarios = [];
  Map<String, List<Agendamento>> agendamentos = {};
  DateTime selectedDate = DateTime.now();
  String formattedDate = '';

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pt_BR', null);
    Intl.defaultLocale = 'pt_BR';
    _gerarHorarios();
    _formatDate();
    _gerarAgendamentos();
  }

  void _gerarHorarios() {
    for (int hora = 7; hora <= 21; hora++) {
      String horaStr = hora.toString().padLeft(2, '0');
      allHorarios.add('$horaStr:00');
      allHorarios.add('$horaStr:30');
    }
  }

  void _formatDate() {
    formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
  }

  void _gerarAgendamentos() {
    agendamentos.clear();
    if (selectedDate.day % 2 == 0) {
      agendamentos = {
        '07:00': [
          Agendamento(
            descricao: "Drenagem",
            profissional: "Ana Romani",
            sala: "Sala 1",
            cor: Colors.teal,
          ),
          Agendamento(
            descricao: "Criolipolise",
            profissional: "Thais Melo",
            sala: "Sala 2",
            cor: Colors.pinkAccent,
          ),
          Agendamento(
            descricao: "Limpeza de pele",
            profissional: "Maria Joaquina",
            sala: "Sala 3",
            cor: Colors.orange,
          ),
          Agendamento(
            descricao: "Drenagem",
            profissional: "Fulana de tal",
            sala: "Sala 4",
            cor: Colors.purple,
          ),
        ],
        '07:30': [
          Agendamento(
            descricao: "Drenagem",
            profissional: "Ana Romani",
            sala: "Sala 1",
            cor: Colors.teal,
          ),
          Agendamento(
            descricao: "Drenagem",
            profissional: "Fulana de tal",
            sala: "Sala 4",
            cor: Colors.purple,
          ),
        ],
        '08:00': [
          Agendamento(
            descricao: "Limpeza de pele",
            profissional: "Maria Joaquina",
            sala: "Sala 3",
            cor: Colors.orange,
          ),
        ],
        '09:00': [
          Agendamento(
            descricao: "Exame",
            profissional: "Enfermeira Ana",
            sala: "Sala 102",
            cor: Colors.deepPurple,
          ),
        ],
        '10:00': [
          Agendamento(
            descricao: "Drenagem",
            profissional: "Fulana de tal",
            sala: "Sala 4",
            cor: Colors.purple,
          ),
          Agendamento(
            descricao: "Drenagem",
            profissional: "Ana Romani",
            sala: "Sala 1",
            cor: Colors.teal,
          ),
          Agendamento(
            descricao: "Limpeza de pele",
            profissional: "Maria Joaquina",
            sala: "Sala 3",
            cor: Colors.orange,
          ),
          Agendamento(
            descricao: "Criolipolise",
            profissional: "Thais Melo",
            sala: "Sala 2",
            cor: Colors.pinkAccent,
          ),
        ],
        '10:30': [
          Agendamento(
            descricao: "Reunião",
            profissional: "Sr. Carlos",
            sala: "Sala 201",
            cor: Colors.blue,
          ),
        ],
        '11:00': [
          Agendamento(
            descricao: "Dentista",
            profissional: "Dr. Marta",
            sala: "Sala 301",
            cor: Colors.pink,
          ),
        ],
      };
    } else {
      agendamentos = {
        '07:00': [
          Agendamento(
            descricao: "Limpeza de pele",
            profissional: "Maria Joaquina",
            sala: "Sala 3",
            cor: Colors.orange,
          ),
          Agendamento(
            descricao: "Drenagem",
            profissional: "Fulana de tal",
            sala: "Sala 4",
            cor: Colors.purple,
          ),
        ],
        '07:30': [
          Agendamento(
            descricao: "Drenagem",
            profissional: "Ana Romani",
            sala: "Sala 1",
            cor: Colors.teal,
          ),
        ],
        '09:00': [
          Agendamento(
            descricao: "Exame",
            profissional: "Enfermeira Ana",
            sala: "Sala 102",
            cor: Colors.deepPurple,
          ),
        ],
      };
    }
  }

  Future<void> _confirmarExclusao(
      BuildContext context, String horario, Agendamento agendamento) async {
    bool? confirmacao = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação de Exclusão'),
          content:
              const Text('Tem certeza que deseja excluir este agendamento?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancelar',
                  style: TextStyle(
                    color: Colors.grey,
                  )),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Excluir',
                  style: TextStyle(
                    color: Colors.red,
                  )),
            ),
          ],
        );
      },
    );

    if (confirmacao == true) {
      _removerAgendamento(horario, agendamento);
    }
  }

  void _removerAgendamento(String horario, Agendamento agendamento) {
    setState(() {
      agendamentos[horario]?.remove(agendamento);
      if (agendamentos[horario]?.isEmpty ?? true) {
        agendamentos.remove(horario);
      }
    });
  }

  void _editarAgendamento(String horario, Agendamento agendamento) {
    context.go('/editar-agendamento', extra: agendamento);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      locale: const Locale('pt', 'BR'),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.pink,
            colorScheme: const ColorScheme.light(
              primary: Colors.pink,
              onSurface: Colors.pink,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _formatDate();
        _gerarAgendamentos();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(AppDefaults.padding),
          decoration: const BoxDecoration(
            color: AppColors.bgSecondayLight,
            borderRadius: BorderRadius.all(
              Radius.circular(AppDefaults.borderRadius),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!Responsive.isMobile(context))
                Expanded(
                  flex: 5,
                  child: Text(
                    'Agendamentos do dia $formattedDate',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  _selectDate(context);
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  backgroundColor: Colors.pink,
                ),
                child: const Text(
                  'Alterar data',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  context.go('/cadastro-cliente');
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  backgroundColor: Colors.pink,
                ),
                child: const Text(
                  'Novo agendamento',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        gapH20,
        Flexible(
          fit: FlexFit.loose,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
            decoration: const BoxDecoration(
              color: AppColors.bgSecondayLight,
              borderRadius: BorderRadius.all(
                Radius.circular(AppDefaults.borderRadius),
              ),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: allHorarios.length,
              itemBuilder: (context, index) {
                String horario = allHorarios[index];
                List<Agendamento>? agendamentosDoHorario =
                    agendamentos[horario];
                return Row(
                  children: [
                    Container(
                      width: 80,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(horario),
                    ),
                    Expanded(
                      child: agendamentosDoHorario != null
                          ? Row(
                              children:
                                  agendamentosDoHorario.map((agendamento) {
                                return Expanded(
                                  child: Container(
                                    height: 110,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4.0, vertical: 4),
                                    color: agendamento.cor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                agendamento.descricao,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                softWrap: false,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                agendamento.profissional,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                softWrap: false,
                                              ),
                                              const SizedBox(height: 4),
                                              if (!Responsive.isMobile(context))
                                                Text(
                                                  agendamento.sala,
                                                  style: const TextStyle(
                                                      color: Colors.white70),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                ),
                                              const SizedBox(height: 4),
                                              if (!Responsive.isMobile(context))
                                                const Text(
                                                  "Paciente X",
                                                  style: const TextStyle(
                                                      color: Colors.white70),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                ),
                                            ],
                                          ),
                                          if (!Responsive.isMobile(context))
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(Icons.edit,
                                                        color: Colors.white),
                                                    onPressed: () {
                                                      _editarAgendamento(
                                                          horario, agendamento);
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.white),
                                                    onPressed: () {
                                                      _confirmarExclusao(
                                                          context,
                                                          horario,
                                                          agendamento);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          : GestureDetector(
                              onTap: () {
                                context.go('/cadastro-cliente');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  height: 50,
                                  color: Colors.grey[200],
                                  child: const Center(
                                      child: Text("Sem Agendamentos")),
                                ),
                              ),
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
