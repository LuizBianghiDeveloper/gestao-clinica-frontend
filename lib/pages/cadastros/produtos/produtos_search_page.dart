import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/constants/defaults.dart';
import '../../../shared/constants/ghaps.dart';
import '../../../theme/app_colors.dart';

class Produto {
  final String nome;
  final double valor;

  Produto(this.nome, this.valor);
}

class ProdutosSearchPage extends StatefulWidget {
  const ProdutosSearchPage({super.key});

  @override
  _ProdutosSearchPageState createState() => _ProdutosSearchPageState();
}

class _ProdutosSearchPageState extends State<ProdutosSearchPage> {
  final TextEditingController searchController = TextEditingController();
  List<Produto> allProdutos = [
    Produto('Hidratante Facial', 120.0),
    Produto('Sérum Anti-Idade', 180.0),
    Produto('Máscara de Argila', 50.0),
    Produto('Creme para Olheiras', 90.0),
    Produto('Protetor Solar Facial', 85.0),
    Produto('Esfoliante Corporal', 70.0),
    Produto('Óleo Corporal Hidratante', 110.0),
    Produto('Gel de Limpeza Facial', 60.0),
    Produto('Tônico Revitalizante', 95.0),
    Produto('Creme Noturno', 130.0),
    Produto('Ampola Capilar', 45.0),
    Produto('Shampoo Anticaspa', 75.0),
    Produto('Condicionador Nutritivo', 80.0),
    Produto('Bálsamo para Lábios', 40.0),
    Produto('Creme para as Mãos', 55.0),
  ];
  List<Produto> filteredProdutos = [];

  @override
  void initState() {
    super.initState();
    filteredProdutos = allProdutos;
  }

  void _filterProdutos(String query) {
    List<Produto> results = [];
    if (query.isEmpty) {
      results = allProdutos;
    } else {
      results = allProdutos
          .where((produto) =>
          produto.nome.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredProdutos = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final int itemCount = filteredProdutos.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        gapH24,
        gapH20,
        Text(
          "Cadastro de Produtos",
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
                    labelText: 'Digite aqui o nome do produto que deseja encontrar',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: _filterProdutos,
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  context.go('/cadastro-produtos');
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
                height: itemCount > 5 ? screenHeight * 0.4 : itemCount * 90,
                child: ListView.builder(
                  itemCount: itemCount,
                  padding: EdgeInsets.zero,
                  itemBuilder: (_, index) {
                    final produto = filteredProdutos[index];
                    return Column(
                      children: [
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${produto.nome} - R\$ ${produto.valor.toStringAsFixed(2)}'),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.orange),
                                    onPressed: () {
                                      print('Editar ${produto.nome}');
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      print('Excluir ${produto.nome}');
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
