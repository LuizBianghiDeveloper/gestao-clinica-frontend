import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/constants/defaults.dart';
import '../../../shared/constants/ghaps.dart';
import '../../../theme/app_colors.dart';

class ClienteSearchPage extends StatefulWidget {
  const ClienteSearchPage({super.key});

  @override
  _ClienteSearchPageState createState() => _ClienteSearchPageState();
}

class _ClienteSearchPageState extends State<ClienteSearchPage> {
  final TextEditingController searchController = TextEditingController();
  List<String> allClientes = ['Ana', 'Bruno', 'Carlos', 'Diana', 'Eduardo'];
  List<String> filteredClientes = [];

  @override
  void initState() {
    super.initState();
    filteredClientes = allClientes;
  }

  void _filterClientes(String query) {
    List<String> results = [];
    if (query.isEmpty) {
      results = allClientes;
    } else {
      results = allClientes
          .where((clientes) =>
          clientes.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredClientes = results;
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
          "Cadastro de Cliente",
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
                    labelText: 'Digite aqui o nome do cliente que deseja encontrar',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: _filterClientes,
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
              itemCount: filteredClientes.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(filteredClientes[index]),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.orange),
                                onPressed: () {
                                  print('Editar ${filteredClientes[index]}');
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  print('Excluir ${filteredClientes[index]}');
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
