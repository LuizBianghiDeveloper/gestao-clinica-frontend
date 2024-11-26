import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/constants/defaults.dart';
import '../../../shared/constants/ghaps.dart';
import '../../../theme/app_colors.dart';

class SalaSearchPage extends StatefulWidget {
  const SalaSearchPage({super.key});

  @override
  _SalaSearchPageState createState() => _SalaSearchPageState();
}

class _SalaSearchPageState extends State<SalaSearchPage> {
  final TextEditingController searchController = TextEditingController();

  List<String> allSala = [
    'Consultório 1',
    'Consultório 2',
    'Consultório 3',
    'Consultório 4',
  ];

  List<String> filteredSala = [];

  @override
  void initState() {
    super.initState();
    filteredSala = allSala;
  }

  void _filterSala(String query) {
    List<String> results = [];
    if (query.isEmpty) {
      results = allSala;
    } else {
      results = allSala
          .where((sala) =>
          sala.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredSala = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final int itemCount = filteredSala.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        gapH24,
        Text(
          "Cadastro de Consultórios",
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
                    labelText: 'Digite aqui o nome do consultório que deseja encontrar',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: _filterSala,
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  context.go('/cadastro-sala');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  backgroundColor: Colors.pink,
                ),
                child: const Text(
                  'Cadastrar novo',
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
        Container(
          decoration: const BoxDecoration(
            color: AppColors.bgSecondayLight,
            borderRadius: BorderRadius.all(
              Radius.circular(AppDefaults.borderRadius),
            ),
          ),
          padding: const EdgeInsets.all(AppDefaults.padding * 0.75),
          child: Column(
            children: [
              gapH8,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDefaults.padding * 0.5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "$itemCount",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              gapH16,
              SizedBox(
                height: itemCount > 5 ? screenHeight * 0.5 : itemCount * 90,
                child: ListView.builder(
                  itemCount: itemCount,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(filteredSala[index]),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.orange),
                                    onPressed: () {
                                      print('Editar ${filteredSala[index]}');
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      print('Excluir ${filteredSala[index]}');
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
                ),
              ),
              gapH8,
            ],
          ),
        ),
      ],
    );
  }
}
