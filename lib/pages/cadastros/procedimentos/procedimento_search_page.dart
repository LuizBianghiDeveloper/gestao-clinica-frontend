import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/constants/defaults.dart';
import '../../../shared/constants/ghaps.dart';
import '../../../theme/app_colors.dart';

class ProcedimentoSearchPage extends StatefulWidget {
  const ProcedimentoSearchPage({super.key});

  @override
  _ProcedimentoSearchPageState createState() => _ProcedimentoSearchPageState();
}

class _ProcedimentoSearchPageState extends State<ProcedimentoSearchPage> {
  final TextEditingController searchController = TextEditingController();
  List<String> allProcedimento = ['Ana', 'Bruno', 'Carlos', 'Diana', 'Eduardo'];
  List<String> filteredProcedimento = [];

  @override
  void initState() {
    super.initState();
    filteredProcedimento = allProcedimento;
  }

  void _filterProcedimento(String query) {
    List<String> results = [];
    if (query.isEmpty) {
      results = allProcedimento;
    } else {
      results = allProcedimento
          .where((procedimento) =>
          procedimento.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredProcedimento = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        gapH24,
        gapH20,
        Text(
          "Cadastro de Procedimentos",
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        gapH20,
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
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    labelText: 'Digite aqui o nome do procedimento que deseja encontrar',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: _filterProcedimento,
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  context.go('/cadastro-procedimento');
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
              itemCount: filteredProcedimento.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(filteredProcedimento[index]),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.orange),
                                onPressed: () {
                                  print('Editar ${filteredProcedimento[index]}');
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  print('Excluir ${filteredProcedimento[index]}');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            )
          ),
        ),
      ],
    );
  }
}
