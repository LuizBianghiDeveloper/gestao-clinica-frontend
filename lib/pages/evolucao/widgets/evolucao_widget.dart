import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import '../../../shared/constants/defaults.dart';
import '../../../shared/constants/ghaps.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../theme/app_colors.dart';

class EvolucaoWidget extends StatefulWidget {
  const EvolucaoWidget({super.key});

  @override
  State<EvolucaoWidget> createState() => _EvolucaoWidgetState();
}

class _EvolucaoWidgetState extends State<EvolucaoWidget> {
  final TextEditingController searchController = TextEditingController();
  List<String> allEvolucoes = ['Ana', 'Bruno', 'Carlos', 'Diana', 'Eduardo'];
  List<String> filteredEvolucoes = [];

  @override
  void initState() {
    super.initState();
    filteredEvolucoes = allEvolucoes;
  }

  void _filterEvolucoes(String query) {
    List<String> results = [];
    if (query.isEmpty) {
      results = allEvolucoes;
    } else {
      results = allEvolucoes
          .where((evolucao) =>
          evolucao.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredEvolucoes = results;
    });
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
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(AppDefaults.borderRadius),
            ),
          ),
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              labelText: 'Digite o nome do usuário que deseja evoluir',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: _filterEvolucoes,
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
                itemCount: filteredEvolucoes.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(filteredEvolucoes[index]),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_forward, color: Colors.green),
                                  onPressed: () {
                                    print('Editar ${filteredEvolucoes[index]}');
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
