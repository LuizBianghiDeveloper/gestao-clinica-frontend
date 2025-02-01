  import 'package:flutter/material.dart';
  import 'package:intl/date_symbol_data_local.dart';
  import 'package:intl/intl.dart'; // Para formatar a data
  import 'package:go_router/go_router.dart';
  import 'package:table_calendar/table_calendar.dart';

  import '../../../responsive.dart';
  import '../../../shared/constants/defaults.dart';
  import '../../../shared/constants/ghaps.dart';
  import '../../../theme/app_colors.dart';
  import 'dart:math';

  class Agendamento {
    final String descricao;
    final String profissional;
    final String sala;
    final String paciente;
    final Color cor;

    Agendamento({
      required this.descricao,
      required this.profissional,
      required this.sala,
      required this.paciente,
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
      for (int hora = 9; hora <= 20; hora++) {
        String horaStr = hora.toString().padLeft(2, '0');
        allHorarios.add('$horaStr:00');

        // Adiciona 30 minutos apenas se a hora não for 20
        if (hora < 20) {
          allHorarios.add('$horaStr:30');
        }
      }
    }


    void _formatDate() {
      formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
    }

    void _gerarAgendamentos() {
      agendamentos.clear();

      for (var agendamento in data) {
        String horario = agendamento['horarioInicio'].toString().substring(0, 5); // Ex: "19:00"
        Color cor = Colors.pink;

        if (agendamento['profissional']['cor'] == 'green') {
          cor = Colors.green;
        } else if (agendamento['profissional']['cor'] == 'pink') {
          cor = Colors.pink;
        } else if (agendamento['profissional']['cor'] == 'orange') {
          cor = Colors.orange;
        } else if (agendamento['profissional']['cor'] == 'cyan') {
          cor = Colors.cyan;
        } else if (agendamento['profissional']['cor'] == 'blue') {
          cor = Colors.blue;
        } else if (agendamento['profissional']['cor'] == 'red') {
          cor = Colors.red;
        }
        Agendamento agendamentoObj = Agendamento(
          descricao: agendamento['procedimento']['nome'],
          profissional: agendamento['profissional']['nome'],
          sala: agendamento['sala']['numero'],
          paciente: agendamento['paciente']['nome'],
          cor: cor,
        );

        if (agendamentos[horario] == null) {
          agendamentos[horario] = [];
        }
        agendamentos[horario]?.add(agendamentoObj);
      }
    }

    final List<Map<String, dynamic>> data = [
      {
        "id": 60,
        "profissional": {
          "idProfissional": 2,
          "nome": "Carlos Pereira",
          "cor": "red",
          "especialidade": "Cirurgião",
          "telefone": "(31) 98888-0002",
          "email": "carlos.pereira@example.com"
        },
        "paciente": {
          "nome": "Luiz Fernando Bianghi Soares",
          "dataNascimento": "1996-09-19",
          "telefone": "(31) 99498-0238",
          "endereco": "Rua Teste",
          "profissao": "Programador",
          "cpf": "06206138666",
          "rg": "17773482",
          "idPaciente": 8
        },
        "procedimento": {
          "idProcedimento": 1,
          "nome": "Limpeza de Pele",
          "descricao": "Tratamento facial para revitalização da pele",
          "valor": "150.00"
        },
        "sala": {
          "idSala": 3,
          "numero": "Sala Luiz Bianghi",
          "descricao": "Sala deu bom"
        },
        "dataAgendamento": "2025-01-28",
        "horarioInicio": "19:00:00",
        "horarioFim": "20:00:00",
        "recorrencia": "SEMANALMENTE",
        "observacoes": "Paciente prefere não atrasares."
      },
      {
        "id": 61,
        "profissional": {
          "idProfissional": 2,
          "nome": "Joao Augusto",
          "cor": "cyan",
          "especialidade": "Cirurgião",
          "telefone": "(31) 98888-0002",
          "email": "carlos.pereira@example.com"
        },
        "paciente": {
          "nome": "Josef House",
          "dataNascimento": "1996-09-19",
          "telefone": "(31) 99498-0238",
          "endereco": "Rua Teste",
          "profissao": "Programador",
          "cpf": "06206138666",
          "rg": "17773482",
          "idPaciente": 8
        },
        "procedimento": {
          "idProcedimento": 1,
          "nome": "Limpeza de Pele",
          "descricao": "Tratamento facial para revitalização da pele",
          "valor": "150.00"
        },
        "sala": {
          "idSala": 3,
          "numero": "Sala Luiz Bianghi",
          "descricao": "Sala deu bom"
        },
        "dataAgendamento": "2025-01-28",
        "horarioInicio": "19:00:00",
        "horarioFim": "20:00:00",
        "recorrencia": "SEMANALMENTE",
        "observacoes": "Paciente prefere não atrasares."
      },
      {
        "id": 64,
        "profissional": {
          "idProfissional": 2,
          "nome": "Carlos Pereira",
          "cor": "pink",
          "especialidade": "Cirurgião",
          "telefone": "(31) 98888-0002",
          "email": "carlos.pereira@example.com"
        },
        "paciente": {
          "nome": "Luiz Fernando Bianghi Soares",
          "dataNascimento": "1996-09-19",
          "telefone": "(31) 99498-0238",
          "endereco": "Rua Teste",
          "profissao": "Programador",
          "cpf": "06206138666",
          "rg": "17773482",
          "idPaciente": 8
        },
        "procedimento": {
          "idProcedimento": 1,
          "nome": "Limpeza de Pele",
          "descricao": "Tratamento facial para revitalização da pele",
          "valor": "150.00"
        },
        "sala": {
          "idSala": 3,
          "numero": "Sala Luiz Bianghi",
          "descricao": "Sala deu bom"
        },
        "dataAgendamento": "2025-01-28",
        "horarioInicio": "16:00:00",
        "horarioFim": "17:00:00",
        "recorrencia": "SEMANALMENTE",
        "observacoes": "Paciente prefere não atrasares."
      },
    ];


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
                focusedDay: selectedDate ?? DateTime.now(),
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 365)),
                locale: 'pt_BR',
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    selectedDate = selectedDay;
                    _formatDate();
                    _gerarAgendamentos();
                  });
                  Navigator.pop(context);
                },
                selectedDayPredicate: (day) => isSameDay(selectedDate, day),
                calendarFormat: CalendarFormat.month,
                headerStyle: HeaderStyle(
                  titleTextFormatter: (date, locale) => DateFormat('MMMM yyyy', locale).format(date),
                  formatButtonVisible: false,
                ),
                calendarStyle: const CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  weekendTextStyle: TextStyle(color: Colors.black),
                  selectedTextStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
          );
        },
      );
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
                    _showDatePickerDialog();
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
                    context.go('/novo-agendamento');
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
                                                   Text('Paciente: ${agendamento.paciente}',
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
                                  context.go('/novo-agendamento');
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
