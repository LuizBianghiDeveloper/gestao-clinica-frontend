import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../responsive.dart';
import '../../../shared/constants/defaults.dart';
import '../../../shared/constants/ghaps.dart';
import '../../../theme/app_colors.dart';

class UsuarioSearchPage extends StatefulWidget {
  const UsuarioSearchPage({super.key});

  @override
  _UsuarioSearchPageState createState() => _UsuarioSearchPageState();
}

class _UsuarioSearchPageState extends State<UsuarioSearchPage> {
  final TextEditingController searchController = TextEditingController();
  List<String> allProfissionais = ['Ana', 'Bruno', 'Carlos', 'Diana', 'Eduardo'];
  List<String> filteredProfissionais = [];

  @override
  void initState() {
    super.initState();
    filteredProfissionais = allProfissionais;
  }

  void _filterProfissionais(String query) {
    List<String> results = [];
    if (query.isEmpty) {
      results = allProfissionais;
    } else {
      results = allProfissionais
          .where((profissional) =>
          profissional.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredProfissionais = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!Responsive.isMobile(context)) gapH24,
        gapH20,
        Text(
          "Cadastro de Usuário",
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
                    labelText: 'Digite aqui o nome do usuário que deseja encontrar',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: _filterProfissionais,
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  context.go('/cadastro-usuario');
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
              itemCount: filteredProfissionais.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(filteredProfissionais[index]),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.orange),
                                onPressed: () {
                                  print('Editar ${filteredProfissionais[index]}');
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  print('Excluir ${filteredProfissionais[index]}');
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
