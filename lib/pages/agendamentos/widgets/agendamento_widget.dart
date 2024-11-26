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

      final List<String> pacientes = [
        "João Silva", "Maria Souza", "Carlos Lima", "Ana Pereira",
        "Bruno Santos", "Patrícia Almeida", "Marcos Teixeira", "Fernanda Costa",
        "Renata Gomes", "Joana Dias", "Luís Fernandes", "Carla Silva",
        "Pedro Costa", "Laura Nunes", "Thiago Mendes", "Daniela Souza"
      ];

      final List<String> procedimentos = [
        "Drenagem", "Criolipólise", "Limpeza de Pele", "Massagem Relaxante",
        "Peeling", "Radiofrequência", "Microagulhamento", "Laserterapia"
      ];

      final Map<String, Color> profissionais = {
        "Ana Romani": Colors.green,
        "Thais Melo": Colors.pinkAccent,
        "Carlos Almeida": Colors.orange,
        "Fernanda Costa": Colors.cyan,
      };

      final random = Random();

      // Gera horários de 07:00 até 21:00 com intervalos de 30 minutos
      for (int hour = 9; hour <= 20; hour++) {
        for (int minute = 0; minute < 60; minute += 30) {
          String horario = '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

          if (selectedDate.weekday == DateTime.sunday) {
            continue; // Ignora se for domingo
          }

          if (selectedDate.weekday == DateTime.saturday) {
            if (hour < 9 || hour > 14 || (hour == 14 && minute > 0)) {
              continue; // Ignora horários fora do intervalo permitido
            }
          }

          // Define uma quantidade aleatória de agendamentos (entre 0 e 4)
          int quantidadeAgendamentos = random.nextInt(5); // Número entre 0 e 4

          // Lista para armazenar os agendamentos do horário atual
          List<Agendamento> agendamentosHorario = [];

          // Conjunto para verificar os profissionais já agendados nesse horário
          Set<String> profissionaisAgendados = {};

          for (int i = 0; i < quantidadeAgendamentos; i++) {
            // Seleciona um profissional aleatório e garante que ele ainda não foi agendado
            String profissional;
            do {
              profissional = profissionais.keys.elementAt(random.nextInt(profissionais.length));
            } while (profissionaisAgendados.contains(profissional));

            // Marca o profissional como já agendado para esse horário
            profissionaisAgendados.add(profissional);

            // Seleciona aleatoriamente o procedimento e o paciente
            String descricao = procedimentos[random.nextInt(procedimentos.length)];
            String paciente = pacientes[random.nextInt(pacientes.length)];
            Color cor = profissionais[profissional]!;
            String sala = "Sala ${i + 1}";

            // Cria o agendamento e o adiciona à lista do horário
            agendamentosHorario.add(Agendamento(
              descricao: descricao,
              profissional: profissional,
              paciente: paciente,
              sala: sala,
              cor: cor,
            ));
          }

          // Adiciona a lista de agendamentos para o horário no mapa principal, se houver agendamentos
          if (agendamentosHorario.isNotEmpty) {
            agendamentos[horario] = agendamentosHorario;
          }
        }
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
