import 'package:core_dashboard/controllers/anamnese_controller.dart';
import 'package:core_dashboard/controllers/clientes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../shared/constants/config.dart';
import '../../shared/constants/ghaps.dart';
import 'package:core_dashboard/pages/evolucao/widgets/evolucao_cliente_widget.dart';

class EvolucaoClientePage extends StatefulWidget {
  final String nome;

  const EvolucaoClientePage({required this.nome, Key? key}) : super(key: key);

  @override
  _EvolucaoClientePageState createState() => _EvolucaoClientePageState();
}

class _EvolucaoClientePageState extends State<EvolucaoClientePage> {
  bool showEvolucaoWidget = true;
  bool showEvolucoesList = false;
  final AnamneseController anamneseController = Get.find<AnamneseController>();
  final ClientesController clientesController = Get.find<ClientesController>();

  List<Map<String, String>> evolucoes = [
    {
      'data': '10/10/2023',
      'profissional': 'Ana Romani',
      'descricao': 'Após avaliação, o paciente apresenta melhoras significativas no aspecto da pele, com redução visível das marcas de acne e maior uniformidade no tom.'
    },
    {
      'data': '05/10/2023',
      'profissional': 'Thais Melo',
      'descricao': 'O paciente apresenta quadro estável, sem alterações significativas. Os sinais vitais estão normais e não houve reações adversas ao tratamento.'
    },
    {
      'data': '01/10/2023',
      'profissional': 'Thais Melo',
      'descricao': 'Foi realizado acompanhamento pós-cirúrgico, com verificação de pontos e avaliação da cicatrização. O paciente está se recuperando conforme o esperado.'
    },
  ];


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Define o fundo branco para toda a página
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gapH24,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Paciente: ${widget.nome}",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          gapH20,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showEvolucaoWidget = true;
                        showEvolucoesList = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                    ),
                    child: const Text('Cadastrar Evolução'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showEvolucaoWidget = false;
                        showEvolucoesList = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                    ),
                    child: const Text('Consultar Evoluções'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        showEvolucaoWidget = false;
                        showEvolucoesList = false;
                      });
                      AppConfig.showLoadingSpinner(context);
                      await anamneseController.listarAnamnese(context, clientesController.clientesSelecionado['idPaciente']);
                      AppConfig.hideLoadingSpinner(context);
                      if (anamneseController.isError.isFalse) {
                        context.go('/anamnese');
                      }

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                    ),
                    child: const Text('Ver Anamnese'),
                  ),
                ],
              ),
            ),
          ),
          gapH20,

          if (showEvolucaoWidget)
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      EvolucaoClienteWidget(),
                      gapH16,
                    ],
                  ),
                ),
              ],
            ),

          if (showEvolucoesList)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ListView.builder(
                  itemCount: evolucoes.length,
                  itemBuilder: (context, index) {
                    final evolucao = evolucoes[index];
                    return Card(
                      color: Colors.white,
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text('Data: ${evolucao['data']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Profissional: ${evolucao['profissional']}'),
                            gapH8,
                            Text('Descrição: ${evolucao['descricao']}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
