import 'dart:convert';

import 'package:core_dashboard/controllers/procedimentos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final ProcedimentosController procedimentosController = Get.find<ProcedimentosController>();
  late final List<dynamic> dataList;
  List<dynamic> filteredProcedimento = [];

  @override
  void initState() {
    super.initState();
    final dynamic decodedJson = jsonDecode(procedimentosController.procedimentos);
    dataList = decodedJson['data'];
    filteredProcedimento = dataList;
  }

  void _filterProcedimento(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredProcedimento = dataList;
      });
    } else {
      final results = dataList.where((procedimento) {
        final nome = procedimento['nome']?.toLowerCase() ?? '';
        return nome.contains(query.toLowerCase());
      }).toList();

      setState(() {
        filteredProcedimento = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final int itemCount = filteredProcedimento.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        gapH24,
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
                  procedimentosController.procedimentosSelecionado = null;
                  context.go('/cadastro-procedimento');
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
                              Text(filteredProcedimento[index]['nome']),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.orange),
                                    onPressed: () {
                                      procedimentosController.procedimentosSelecionado = filteredProcedimento[index];
                                      print('Editar ${filteredProcedimento[index]}');
                                      context.go('/cadastro-procedimento');
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Confirmação'),
                                            content: Text(
                                                'Tem certeza que deseja excluir o procedimento ${filteredProcedimento[index]['nome']}?'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('Cancelar', style: TextStyle(color: Colors.pink),),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: const Text('Excluir', style: TextStyle(color: Colors.pink),),
                                                onPressed: () async {
                                                  await procedimentosController.deletarProcedimentos(context, filteredProcedimento[index]['idProcedimento']);
                                                  if (procedimentosController.isError.isTrue) {
                                                    Navigator.of(context).pop();
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                        content: Text('Não foi possivel excluir o procedimento, por favor, tente novamente.'),
                                                        backgroundColor: Colors.red,
                                                        duration: Duration(seconds: 2),
                                                      ),
                                                    );
                                                  } else {
                                                    Navigator.of(context).pop();
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                        content: Text('Procedimento excluido com sucesso.'),
                                                        backgroundColor: Colors.green,
                                                        duration: Duration(seconds: 2),
                                                      ),
                                                    );
                                                    context.go('/');
                                                  }
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
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
