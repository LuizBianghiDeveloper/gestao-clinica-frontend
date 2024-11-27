import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controllers/clientes_controller.dart';
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
  final ClientesController clientesController = Get.find<ClientesController>();
  late final List<dynamic> dataList;
  List<dynamic> filteredClientes = [];

  @override
  void initState() {
    super.initState();
    final dynamic decodedJson = jsonDecode(clientesController.clientes);
    dataList = decodedJson['data'];
    filteredClientes = dataList;
  }

  void _filterClientes(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredClientes = dataList;
      });
    } else {
      final results = dataList.where((cliente) {
        final nome = cliente['nome']?.toLowerCase() ?? '';
        return nome.contains(query.toLowerCase());
      }).toList();

      setState(() {
        filteredClientes = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final int itemCount = filteredClientes.length;

    String formatarTelefone(String telefone) {
      return telefone.replaceAll(RegExp(r'[^0-9]'), '');
    }

    Future<void> _launchWhatsApp(String telefone) async {
      final String phoneNumber = "+55${formatarTelefone(telefone)}";
      final String message = "🎉 Parabéns! 🎉\n\n"
          "A Clínica Thais Melo Estética Integrativa deseja a você um dia repleto de alegria e realizações! "
          "Que este novo ano de vida traga muitas conquistas e momentos especiais. "
          "Estamos aqui para cuidar de você e ajudar a realçar sua beleza. "
          "Aproveite seu dia! 🎂✨";


      final Uri whatsappUrl = Uri.parse("https://wa.me/$phoneNumber?text=$message");

      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      } else {
        throw 'Não foi possível abrir o WhatsApp.';
      }
    }

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
                  clientesController.clientesSelecionado = null;
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
                height: itemCount > 5 ? screenHeight * 0.4 : itemCount * 90,
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
                              Text(filteredClientes[index]['nome']),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      FontAwesomeIcons.whatsapp,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      _launchWhatsApp(filteredClientes[index]['telefone']);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.orange),
                                    onPressed: () {
                                      clientesController.clientesSelecionado = filteredClientes[index];
                                      context.go('/cadastro-cliente');
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
                                                'Tem certeza que deseja excluir o usuário ${filteredClientes[index]['nome']}?'),
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
                                                  await clientesController.deletarClientes(context, filteredClientes[index]['idPaciente']);
                                                  if (clientesController.isError.isTrue) {
                                                    Navigator.of(context).pop();
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                        content: Text('Não foi possivel excluir o usuário, por favor, tente novamente.'),
                                                        backgroundColor: Colors.red,
                                                        duration: Duration(seconds: 2),
                                                      ),
                                                    );
                                                  } else {
                                                    Navigator.of(context).pop();
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                        content: Text('Usuário excluido com sucesso.'),
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
