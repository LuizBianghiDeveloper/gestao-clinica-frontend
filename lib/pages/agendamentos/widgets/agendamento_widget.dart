import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatar a data
import 'package:go_router/go_router.dart';

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
    agendamentos = {
      '07:00': [
        Agendamento(
          descricao: "Consulta",
          profissional: "Dr. João",
          sala: "Sala 101",
          cor: Colors.orange,
        ),
      ],
      '09:00': [
        Agendamento(
          descricao: "Exame",
          profissional: "Enfermeira Ana",
          sala: "Sala 102",
          cor: Colors.green,
        ),
      ],
      '14:00': [
        Agendamento(
          descricao: "Reunião",
          profissional: "Sr. Carlos",
          sala: "Sala 201",
          cor: Colors.blue,
        ),
      ],
      '18:00': [
        Agendamento(
          descricao: "Dentista",
          profissional: "Dr. Marta",
          sala: "Sala 301",
          cor: Colors.pink,
        ),
      ],
    };

    if (selectedDate.weekday == 1) {
      agendamentos = {
        '09:00': [
          Agendamento(
            descricao: "Consulta",
            profissional: "Dr. João",
            sala: "Sala 102",
            cor: Colors.orange,
          ),
        ],
        '12:00': [
          Agendamento(
            descricao: "Café",
            profissional: "Maria",
            sala: "Cozinha",
            cor: Colors.green,
          ),
        ],
        '18:30': [
          Agendamento(
            descricao: "Reunião de equipe",
            profissional: "Carlos",
            sala: "Sala 201",
            cor: Colors.blue,
          ),
        ],
      };
    } else if (selectedDate.weekday == 2) {
      agendamentos = {
        '10:30': [
          Agendamento(
            descricao: "Exame de Sangue",
            profissional: "Dr. Marta",
            sala: "Sala 103",
            cor: Colors.purple,
          ),
        ],
        '15:00': [
          Agendamento(
            descricao: "Aula de Yoga",
            profissional: "Instrutora Ana",
            sala: "Sala 301",
            cor: Colors.yellow,
          ),
        ],
      };
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
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
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  'Agendamentos do dia $formattedDate',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                ),
                child: const Text(
                  'Trocar Data',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                ),
                child: const Text(
                  'Cadastrar novo',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
            padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
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
                List<Agendamento>? agendamentosDoHorario = agendamentos[horario];
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
                        children: agendamentosDoHorario.map((agendamento) {
                          return Expanded(
                            child: Container(
                              height: 90,
                              color: agendamento.cor,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      agendamento.descricao,
                                      style: const TextStyle(
                                          color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      agendamento.profissional,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      agendamento.sala,
                                      style: const TextStyle(color: Colors.white70),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      )
                          : Container(
                        height: 50,
                        color: Colors.grey[200],
                        child: const Center(child: Text("Sem Agendamentos")),
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
