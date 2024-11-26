import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  List<String> allClientes = [
    'Ana Paula Silva',
    'Bruno Mendes Oliveira',
    'Carlos Alberto Souza',
    'Diana Costa Pereira',
    'Eduardo Gomes Ferreira',
    'Fernanda Lima Santos',
    'Gabriel Rocha Lima',
    'Helena Martins Alves',
    'Igor Henrique Dias',
    'Júlia de Souza Almeida',
    'Karla Cristina Lima',
    'Leonardo da Silva Santos',
    'Mariana Oliveira Costa',
    'Natália Mendes Nascimento',
    'Otávio Augusto Lima',
    'Paula Regina Cardoso',
    'Quiteria de Almeida Oliveira',
    'Ricardo Carvalho Pinto',
    'Sofia Regina Ferreira',
    'Thiago Fernandes da Costa',
    'Ulisses Martins de Oliveira',
    'Vanessa Silva Freitas',
    'William Figueiredo Santos',
    'Xuxa de Almeida',
    'Yasmin Rodrigues da Silva',
  ];

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
    final screenHeight = MediaQuery.of(context).size.height;
    final int itemCount = filteredClientes.length;

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
                              Text(filteredClientes[index]),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      FontAwesomeIcons.whatsapp,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      // Ação do WhatsApp aqui
                                    },
                                  ),
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
