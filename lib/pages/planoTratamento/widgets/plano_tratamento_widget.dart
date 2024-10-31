import 'package:core_dashboard/utils/pdfUtils.dart';
import 'package:flutter/material.dart';

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

  final List<String> _clientes = [
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
  final List<String> _procedimentos = [
    'Botox',
    'Preenchimento Labial',
    'Limpeza de Pele',
    'Peeling Químico',
    'Depilação a Laser',
    'Tratamento para Acne',
    'Rinomodelação',
    'Microagulhamento',
    'Lifting Facial',
    'Tratamento de Melasma',
    'Harmonização Facial',
    'Escleroterapia',
    'Carboxiterapia',
    'Criolipólise',
    'Drenagem Linfática',
    'Laser Fracionado',
    'Peeling de Diamante',
    'Massagem Modeladora',
    'Radiofrequência',
    'Aplicação de Fios de Sustentação',
  ];

  final List<String> _formasPagamento = [
    'Pix',
    'Dinheiro',
    'Crédito',
    'Débito',
  ];

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
                return _clientes.take(999);
              }
              return _clientes.where((String cliente) {
                return cliente.toLowerCase().contains(textEditingValue.text.toLowerCase());
              });
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
                      return _procedimentos.take(999);
                    }
                    return _procedimentos.where((String procedimento) {
                      return procedimento.toLowerCase().contains(textEditingValue.text.toLowerCase());
                    });
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
                      // Verifica se o procedimento já está na lista
                      int index = _procedimentosAdicionados.indexWhere((element) => element.startsWith(_selectedProcedimento!));

                      if (index != -1) {
                        // Se o procedimento já existe, atualiza o número de sessões
                        final existingEntry = _procedimentosAdicionados[index];
                        final existingSessions = int.parse(existingEntry.split(' - ')[1].split(' ')[0]);
                        final newSessions = int.parse(sessaoController.text);
                        _procedimentosAdicionados[index] = '${_selectedProcedimento} - ${existingSessions + newSessions} sessões';
                      } else {
                        // Caso contrário, adiciona o novo procedimento
                        _procedimentosAdicionados.add('${_selectedProcedimento} - ${sessaoController.text} sessões');
                      }

                      sessaoController.clear();
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

                      PdfUtils.abrirPlanoTratamentoPdf(_selectedCliente!, _procedimentosAdicionados.join(', '), "Administrador", observacaoController.text);
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
                        _selectedPagamento != null ) {

                      PdfUtils.abrirContratoPdf(_selectedCliente!, "casado", "médico", "Rua Joao Ferreira", "Retiro", "152", "34002-582", "31", "Outubro", "2024");
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
                )
              ],
            ),
        ],
      ),
    );
  }
}
