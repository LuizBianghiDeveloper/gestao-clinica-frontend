import 'dart:convert';

import 'package:core_dashboard/controllers/procedimentos_controller.dart';
import 'package:core_dashboard/utils/pdfUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/clientes_controller.dart';
import '../../../shared/constants/defaults.dart';
import '../../../shared/constants/ghaps.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../theme/app_colors.dart';

class PlanoTratamentoWidget extends StatefulWidget {
  const PlanoTratamentoWidget({super.key});

  @override
  State<PlanoTratamentoWidget> createState() => _PlanoTratamentoWidgetState();
}

class _PlanoTratamentoWidgetState extends State<PlanoTratamentoWidget> {
  String? _selectedCliente;
  String? _selectedProcedimento;
  String? _selectedPagamento;
  int? _selectedParcelas;
  List<String> _procedimentosAdicionados = [];
  final TextEditingController observacaoController = TextEditingController();
  final TextEditingController sessaoController = TextEditingController();

  final ClientesController clientesController = Get.find<ClientesController>();
  final ProcedimentosController procedimentosController = Get.find<ProcedimentosController>();
  late final List<dynamic> dataList;
  late final List<dynamic> dataListProcedimento;
  List<dynamic> clientes = [];
  List<dynamic> procedimento = [];

  final List<String> _formasPagamento = [
    'Pix',
    'Dinheiro',
    'Crédito',
    'Débito',
  ];

  @override
  void initState() {
    super.initState();
    final dynamic decodedJson = jsonDecode(clientesController.clientes);
    final dynamic decodedJsonProcedimento = jsonDecode(procedimentosController.procedimentos);
    dataList = decodedJson['data'];
    dataListProcedimento = decodedJsonProcedimento['data'];
    clientes = dataList;
    procedimento = dataListProcedimento;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: const BoxDecoration(
        color: AppColors.bgSecondayLight,
        borderRadius: BorderRadius.all(
          Radius.circular(AppDefaults.borderRadius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            children: [
              SectionTitle(title: "Plano de tratamento"),
              Spacer(),
            ],
          ),
          gapH24,
          Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return clientes.map((cliente) => cliente['nome'].toString()).take(999);
              }
              return clientes
                  .where((cliente) => cliente['nome']
                  .toString()
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase()))
                  .map((cliente) => cliente['nome'].toString());
            },
            onSelected: (String selectedCliente) {
              setState(() {
                _selectedCliente = selectedCliente;
              });
            },
            fieldViewBuilder: (BuildContext context, TextEditingController fieldTextEditingController, FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
              return TextFormField(
                controller: fieldTextEditingController,
                focusNode: fieldFocusNode,
                decoration: const InputDecoration(
                  labelText: 'Selecione o Cliente',
                  border: OutlineInputBorder(),
                ),
                onTap: () {
                  if (!fieldFocusNode.hasFocus) {
                    fieldFocusNode.requestFocus();
                  }
                },
              );
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return procedimento.map((procedimento) => procedimento['nome'].toString()).take(999);
                    }
                    return procedimento
                        .where((procedimento) => procedimento['nome']
                        .toString()
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase()))
                        .map((procedimento) => procedimento['nome'].toString());
                  },
                  onSelected: (String selectedProcedimento) {
                    setState(() {
                      _selectedProcedimento = selectedProcedimento;
                    });
                  },
                  fieldViewBuilder: (BuildContext context, TextEditingController fieldTextEditingController, FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
                    return TextFormField(
                      controller: fieldTextEditingController,
                      focusNode: fieldFocusNode,
                      decoration: const InputDecoration(
                        labelText: 'Selecione o Procedimento',
                        border: OutlineInputBorder(),
                      ),
                      onTap: () {
                        if (!fieldFocusNode.hasFocus) {
                          fieldFocusNode.requestFocus();
                        }
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: sessaoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'N° Sessões',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: observacaoController,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              labelText: 'Observações',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Forma de pagamento:',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedPagamento,
            decoration: const InputDecoration(
              labelText: 'Selecione a forma de pagamento',
              border: OutlineInputBorder(),
            ),
            items: _formasPagamento.map((String pagamento) {
              return DropdownMenuItem<String>(
                value: pagamento,
                child: Text(pagamento),
              );
            }).toList(),
            onChanged: (String? novoPagamento) {
              setState(() {
                _selectedPagamento = novoPagamento;
                if (novoPagamento != 'Crédito') {
                  _selectedParcelas = null;
                }
              });
            },
          ),
          const SizedBox(height: 16),
          if (_selectedPagamento == 'Crédito') ...[
            const Text(
              'Número de Parcelas:',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            DropdownButtonFormField<int>(
              value: _selectedParcelas,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: List.generate(12, (index) => index + 1).map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (int? novoValor) {
                setState(() {
                  _selectedParcelas = novoValor;
                  procedimentosController.parcelasSelecionado = novoValor;
                });
              },
            ),
          ],
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_selectedProcedimento != null && sessaoController.text.isNotEmpty) {
                    setState(() {
                      // Busca o procedimento selecionado na lista `procedimento` para obter o valor
                      final procedimentoSelecionado = procedimento.firstWhere(
                            (item) => item['nome'] == _selectedProcedimento,
                        orElse: () => null,
                      );

                      if (procedimentoSelecionado != null) {
                        final valor = double.tryParse(procedimentoSelecionado['valor'].toString()) ?? 0.0;
                        final valorFormatado = valor.toStringAsFixed(2);
                        int index = _procedimentosAdicionados.indexWhere(
                              (element) => element.startsWith(_selectedProcedimento!),
                        );

                        if (index != -1) {
                          // Se o procedimento já existe, atualiza o número de sessões
                          final existingEntry = _procedimentosAdicionados[index];
                          final existingSessions = int.parse(existingEntry.split(' - ')[1].split(' ')[0]);
                          final newSessions = int.parse(sessaoController.text);
                          _procedimentosAdicionados[index] = '${_selectedProcedimento} - ${existingSessions + newSessions} sessões - R\$${valorFormatado}';
                        } else {
                          // Caso contrário, adiciona o novo procedimento com o valor
                          _procedimentosAdicionados.add('${_selectedProcedimento} - ${sessaoController.text} sessões - R\$${valorFormatado}');
                        }

                        sessaoController.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Procedimento não encontrado!')),
                        );
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Selecione o procedimento e informe o número de sessões!')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: const Text(
                  'Adicionar Procedimento',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          if (_procedimentosAdicionados.isNotEmpty)
            Column(
              children: [
                const Text(
                  'Tratamento selecionado:',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _procedimentosAdicionados.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _procedimentosAdicionados[index],
                            style: const TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _procedimentosAdicionados.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          const SizedBox(height: 32),
          if (_procedimentosAdicionados.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_selectedCliente != null &&
                        _procedimentosAdicionados.isNotEmpty &&
                        _selectedPagamento != null) {

                      final List<Map<String, String>> listaParcelas = _selectedPagamento == 'Crédito' && _selectedParcelas != null
                          ? List.generate(_selectedParcelas!, (index) {
                        final valorParcela = _procedimentosAdicionados.fold<double>(
                          0.0,
                              (sum, item) {
                            final partes = item.split(' - ');
                            final unitario = double.tryParse(partes[2].replaceAll('R\$', '').trim()) ?? 0.0;
                            final sessoes = int.tryParse(partes[1].split(' ')[0]) ?? 0;
                            return sum + (unitario * sessoes);
                          },
                        ) / _selectedParcelas!;

                        return {
                          'parcelas': '${index + 1}/${_selectedParcelas}',
                          'vencimento': 'Vencimento ${index + 1}', // Adapte para calcular a data de vencimento real
                          'valor': valorParcela.toStringAsFixed(2),
                          'forma': 'Crédito',
                        };
                      })
                          : [];

                      final List<Map<String, String>> listaProcedimentos = _procedimentosAdicionados.map((item) {
                        final partes = item.split(' - ');
                        return {
                          'procedimento': partes[0],
                          'sessoes': partes[1].split(' ')[0], // Número de sessões
                          'unitario': partes[2].replaceAll('R\$', ''), // Valor (sem o símbolo R$)
                        };
                      }).toList();

                      PdfUtils.abrirPlanoTratamentoPdf(_selectedCliente!, listaProcedimentos, "Administrador", observacaoController.text,  _selectedPagamento!, parcelas: listaParcelas,);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Preencha todos os campos antes de gerar o plano de tratamento!')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Gerar Plano de Tratamento',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_selectedCliente != null &&
                        _procedimentosAdicionados.isNotEmpty &&
                        _selectedPagamento != null) {

                      final clienteSelecionado = clientes.firstWhere(
                            (cliente) => cliente['nome'] == _selectedCliente,
                        orElse: () => null,
                      );

                      if (clienteSelecionado != null) {
                        final nome = clienteSelecionado['nome'];
                        final profissao = clienteSelecionado['profissao'] ?? 'Não informado';
                        final endereco = clienteSelecionado['endereco'] ?? 'Não informado';
                        final dia = DateTime.now().day.toString();
                        final mes = DateTime.now().month.toString().padLeft(2, '0');
                        final ano = DateTime.now().year.toString();

                        PdfUtils.abrirContratoPdf(
                          nome,
                          profissao,
                          endereco,
                          dia,
                          mes,
                          ano,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Cliente não encontrado!')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Preencha todos os campos antes de gerar o contrato!')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Gerar Contrato',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
